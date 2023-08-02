import { useState } from "react";
import $u from "../utils/$u";
import { ethers } from "ethers";

const wc = require("../circuit/witness_calculator");
const tornadoAddress = "0x5FC8d32690cc91D4c39d9d3abcBD16989F875707";
const tornadoJson = require("../json/Tornado.json");
const tornadoABI = tornadoJson.abi;
const tornadoInterface = new ethers.utils.Interface(tornadoABI);

const Interface = () => {
  const [account, updateAccount] = useState(null);
  const [proofElements, updateProofElements] = useState(null);
  const [proofStringEl, updateProofStringEl] = useState(null);
  const [textArea, updateTextArea] = useState(null);

  const copyProof = () => {
    if(!!proofStringEl) {
      // Copy thuần JS
      navigator.clipboard.writeText(proofStringEl.innerHTML);
    }
  }

  const connectMetamask = async () => {
    try {
      if(!window.ethereum){
        alert("Please install Metamask to use this app.");
        throw "No-Metamask";
      }
      const accounts = await window.ethereum.request({ method: "eth_requestAccounts" });
      const chainId = window.ethereum.networkVersion;

      // Có thể check chain id đúng chain mới cho connect ở đây

      const activeAccount = accounts[0];
      var balance = await window.ethereum.request({ method: "eth_getBalance", params: [activeAccount, "latest"] });
      balance = $u.moveDecimalLeft(BigInt(balance).toString(), 18);

      var newAccountState = {
        chainId: chainId,
        address: activeAccount,
        balance: balance
      }
      updateAccount(newAccountState);

    } catch (error) {
      console.log(error);
    }
  }

  const depositEther = async () => {
    const secret = ethers.BigNumber.from(ethers.utils.randomBytes(32)).toString();
    const nullifier = ethers.BigNumber.from(ethers.utils.randomBytes(32)).toString();
    const input = {
      secret: $u.BN256ToBinary(secret).split(""), // Vì input vào mạch cần dạng mảng
      nullifier: $u.BN256ToBinary(nullifier).split(""),
    }
    console.log("input::", input);

    var res = await fetch("/deposit.wasm"); 
    var buffer = await res.arrayBuffer();
    var depositWC = await wc(buffer);

    const result = await depositWC.calculateWitness(input, 0); // sanityCheck k qtr nên truyền 0 vào

    // witness chứa mọi intermediate signal luôn, ta chỉ cần lấy ra 2 cái hash thôi.
    const commitmentHash = result[1];
    const nullifierHash = result[2];
    const value = ethers.BigNumber.from("1000000000000000000").toHexString();

    console.log("commitmentHash::", commitmentHash);
    console.log("nullifierHash::", nullifierHash);

    const tx = {
      to: tornadoAddress,
      from: account.address,
      value: value,
      data: tornadoInterface.encodeFunctionData("deposit", [commitmentHash])
    }

    try{
      const txHash = await window.ethereum.request({ method: "eth_sendTransaction", params: [tx]});
      // K được gọi request({ method: "eth_getTransactionReceipt", params: [txHash]}) để lấy giá trị trả về của tx này ở đây vì mạng local nhanh nhưng mạng public chậm. Bên trên sendTransaction xong thì txHash có thể chưa tồn tại trên mạng public nên chỉ lấy ra null. Hình như có hàm wait tx finish mà 
      // Do ta chỉ cần data thực khi withdraw nên k cần extract ngay từ lúc deposit làm gì

      // Ta convert mọi trường sang số và string để người dùng lưu data đó lại, nó sẽ là private input cho circuit sinh signature sau này khi cần withdraw.
      const proofElements = {
        nullifierHash: `${nullifierHash}`,
        secret: secret,
        nullifier: nullifier,
        commitment: `${commitmentHash}`,
        txHash,
      };
      console.log(proofElements);
      // Ép cả cục sang base64 1 string để người dùng dễ dàng copy paste
      updateProofElements(btoa(JSON.stringify(proofElements)));

    } catch(err){
      console.error(err);
    }
  }

  const widthdraw = async () => {
    if(!textArea || !textArea.value) {
      alert("Please input the proof of deposit string");
    }
    try{
      const proofString = textArea.value;
      const proofElements = JSON.parse(atob(proofString));
      const SnarkJS = window["snarkjs"];
      
      const receipt = await window.ethereum.request({ method: "eth_getTransactionReceipt", params: [txHash]});
      if(!receipt) throw "empty-receipt";
      const log = receipt.logs[0];
      const decodedData = tornadoInterface.decodeEventLog("Deposit", log.data, log.topics);
      console.log("Event from deposit::", decodedData);

      const proofInput = {
        root: $u.BNToDecimal(decodedData.root),
        nullifierHash: proofElements.nullifierHash,
        recipient: $u.BNToDecimal(account.address),
        secret: $u.BN256ToBinary(proofElements.secret).split(""),
        nullifier: $u.BN256ToBinary(proofElements.nullifier).split(""),
        hashPairings: decodedData.hashPairings.map(n => ($u.BNToDecimal(n))),
        hashDirections: decodedData.pairDirection
      }

      const { proof, publicSignals } = await SnarkJS.groth16.fullProve(proofInput, "/withdraw.wasm", "/setup_final.zkey");
      
      // Data lấy về từ snarkjs luôn là BN và data truyền vào contract hàm verify luôn là hexa
      const callInputs = [
        proof.pi_a.slice(0, 2).map($u.BN256ToHex),
        proof.pi_b.slice(0, 2).map(row => ($u.reverseCoordinate(row.map($u.BN256ToHex)))),
        // 2 giá trị pi_b phải đảongược thứ tự lại khi truyền vào hàm verify
        proof.pi_c.slice(0, 2).map($u.BN256ToHex),
        publicSignals.slice(0, 2).map($u.BN256ToHex)
      ];

      const callData = tornadoInterface.encodeFunctionData("withdraw", callInputs);
      const tx = {
        to: tornadoAddress,
        from: account.address,
        data: callData
      }
      const txHash = await window.ethereum.request({ method: "eth_sendTransaction", params: [tx]});
    } catch(e){
      console.log(e);
    }
  }
  return (
    <div>
      {
        !!account ? (
          <div>
            <p>ChainId: {account.chainId}</p>
            <p>Wallet address: {account.address}</p>
            <p>Balance: {account.balance}</p>
          </div>
        ) : (
          <div>
            <button onClick={connectMetamask}>Connect Metamask</button>
          </div>
        )
      }

      <div><hr/></div>

      {
        !!account ? (
          <div>
            {
              !!proofElements ? (
                <div>
                  <p><strong>Proof of Deposit:</strong></p>
                  <div style={{ maxWidth: "100%", overflowWrap: "break-word"}}>
                    <span ref={(proofStringEl) => { updateProofStringEl(proofStringEl); }}>{proofElements}</span>
                    {/* Khi xuất hiện sẽ tự gán proofStringEl là thẻ này */}
                  </div>
                  {
                    !!proofStringEl && (
                      <button onClick={copyProof}>Copy proof string</button>
                    )
                  }
                </div>
              ) : (
                <button onClick={depositEther}>Deposit 1 ETH</button>
              )
            }
          </div>
        ) : (
          <div>
            <p>You need to connect Metamask to use this section</p>
          </div>
        )
      }
      <div><hr/></div>
      {
        !!account ? (
          <div>
            <div>
              <textarea ref={(ta) => updateTextArea(ta)}></textarea>
            </div>
            <button onClick={widthdraw}>Withdraw 1 ETH</button>
          </div>
        ) : (
          <div>
            <p>You need to connect Metamask to use this section</p>
          </div>
        )
      }
    </div>
  )
}

export default Interface;
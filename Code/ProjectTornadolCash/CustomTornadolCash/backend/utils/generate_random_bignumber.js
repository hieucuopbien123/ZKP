const { ethers } = require("ethers");

const num = 10;

async function generate() {
    for(let i = 0; i < num; i++){
        let n = BigInt.from(ethers.utils.randomBytes(32));
        console.log(n.toString());
    }
}

generate()
    .catch((err) => { console.log(err); process.exit(1); })
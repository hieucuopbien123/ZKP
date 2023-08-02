const ethers = require("ethers");

const utils = {
  moveDecimalLeft: (str, count) => {
    let start = str.length - count;
    let prePadding = "";
    while(start < 0){
      prePadding += "0";
      start += 1;
    }
    str = prePadding + str;
    let result = str.slice(0, start) + "." + str.slice(start);
    if(result[0] == ".") {
      result = "0" + result;
    }
    return result;
  },
  BN256ToBinary: (str) => {
    let r = BigInt(str).toString(2);
    while(r.length < 256) {
      r = "0" + r;
    }
    return r;
  },
  BNToDecimal: (bn) => {
    return ethers.BigNumber.from(bn).toString();
  },
  BN256ToHex: (n) => {
    let nstr = BigInt(n).toString(16);
    nstr = `0x${nstr.padEnd(64, "0")}`;
    return nstr;
  },
  reverseCoordinate: (p) => {
    let r = [0, 0];
    r[0] = p[1];
    r[1] = p[0];
    return r;
  }
}

export default utils;
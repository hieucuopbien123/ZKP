// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract Hasher {
    
    // Số p vẫn nhỏ hơn 2^256 - 1 nên lưu được
    uint256 p = 21888242871839275222246405745257275088548364400416034343698204186575808495617;
    uint8 nRounds = 10;
    uint256[10] c = [
        0,
        7643976507530909735871869339851864835582057468941827073864687428684990950281,
        58352356718228235839820087910127208145707672620179709276377827498214453060209,
        65077236802530454191656149823640282844920291372145024802792546098362160474877,
        15746121220386657489320777674410317320974196675322270504323290962992881584094,
        40838442152368157160151136586472540154199748555076691223715471882688721533866,
        10175987186366581086137586225912369616232104310808416167614670042919410435608,
        57043143336721851975071654389412643078153515630765112296738635628083869713612,
        77144945397361890461561024617992638409110047305962378690149268237726682797271,
        37009164509731272734793526143024925481749484535125102560355867860358582208922
    ];

    function MiMC5(uint256 x, uint256 k) public view returns(uint256 h) {
        uint256 lastOutput = x;

        uint256 base;
        uint256 base2;
        uint256 base4;

        // Bản solidity 0.8 khi overflow nó k tự quay vòng nữa mà báo lỗi nên bị quá max phải tự xử lý. 
        // Nó ra thêm hàm addmod và mulmod cung xử lý prime field mod dễ dàng.
        // Solidity uint có max 2^256 giá trị từ 0 đến 2^256 - 1. Thực tế, 2^256 - 1 là số nguyên tố nhưng 2^256 thì không nên solidity k dùng prime field
        for(uint8 i = 0; i < nRounds; i++){
            base = addmod(lastOutput, k, p);
            base = addmod(base, c[i], p);
            
            base2 = mulmod(base, base, p);
            base4 = mulmod(base2, base2, p);

            lastOutput = mulmod(base4, base, p);
        }

        h = addmod(lastOutput, k, p);
    }
}

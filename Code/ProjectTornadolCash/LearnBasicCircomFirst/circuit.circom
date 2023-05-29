pragma circom 2.0.0;

// VD: f(x, y) = x^2 * y + x * y^2 + 17; => vẽ mạch ra y hệt như dưới

// Signal Definition:
// 1. All the inputs are signals
// 2. Every time you multiply two signals together, you need to define a new signal
// 3. Only two signals can be multiplied at once to get a new signal
// 4. All the outputs are signals
// 5. Value gán cho signal luôn dùng <==

template F() {
    signal input x;
    signal input y;
    signal output o;

    signal m1 <== x * x;
    signal m2 <== m1 * y;

    signal m3 <== y * y;
    signal m4 <== m3 * x;

    o <== m2 + m4 + 17;
}

component main = F();

/*

Compile:
circom circuit.circom --r1cs --wasm
=> Vì ta cần compile nó thành r1cs(mạch logic có cổng cộng và nhân) và wasm (binary code assembly)
Nó sinh ra file generate_witness.js của nodejs để sinh bằng chứng
=> Số lượng constraint thg bằng số lượng intermediate signal. Ở đây là 4

node ./circuit_js/generate_witness.js ./circuit_js/circuit.wasm input.json witness.wtns
Chạy file ./circuit_js/generate_witness.js để sinh witness từ mạch binary ./circuit_js/circuit.wasm có input từ input.json và output witness lưu vào file witness.wtns

witness.wtns sinh ra là binary, ta convert sang json để xem bên trong có gì:
snarkjs wtns export json witness.wtns witness.json

Nội dung witness.json:
[
    "1",
    "47",
    "2",
    "3",
    "4",
    "12",
    "9"
]
=> 1 là constant của mạch, luôn là 1; 47 là output; 2 và 3 là input; 4 12 và 9 là các witness value k trùng nhau (intermediate signal)

*/

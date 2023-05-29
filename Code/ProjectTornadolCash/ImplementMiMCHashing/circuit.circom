pragma circom 2.0.0;

// Tạo MiMC Hashfunction có 10 rounds, k dùng mũ 3 mà dùng hẳn mũ 5
// Tính toán theo từng round:
// * Output của phép nhân luôn là 1 signal, kp output signal thì là intermediate signal. Output của phép cộng mà kp output signal thì dùng intermediate signal hay var cũng được, nó k bắt buộc phải là witness
// * Do phải chứng minh witness trong quá trình tính toán, nên mọi intermediate signal đều phải khởi tạo và lưu lại

// VD ta tính x^5 ở từng round, ta buộc phải tạo 4 biến intermediate signal để lưu x^1, x^2, x^4 và x^5 mới tính được qua các cổng. Mà có 10 rounds nên cần tới 40 biến, ta lưu vào 4 mảng 10 phần tử là xong.

// Để generate random big number, dùng lib ethers:
// node generate_random_bignumber.js

template MiMC5() {
    signal input x; 
    signal input k;
    signal output h;

    var nRounds = 10;
    var c[nRounds] = [
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
    signal base5[nRounds + 1];
    var base[nRounds]; // Nó chỉ lưu kết quả của phép cộng nên dùng var là được
    signal base2[nRounds];
    signal base4[nRounds];
    // 10 round, 3 intermediate signal => 30 constraints

    base5[0] <== x;

    for(var i = 0; i < nRounds; i++){
        base[i] = base5[i] + k + c[i];
        base2[i] <== base[i] * base[i];
        base4[i] <== base2[i] * base2[i];
        base5[i + 1] <== base4[i] * base[i];
    }

    h <== base5[nRounds] + k;
}

component main = MiMC5();

// Compile: 
// circom circuit.circom --r1cs --wasm
// node .\circuit_js\generate_witness.js ./circuit_js/circuit.wasm input.json output.wtns
// snarkjs wtns export json output.wtns output.json
// => Thấy các intermediate signal là các base2, base4, base5 generate random ok là mạch đã chạy thành công
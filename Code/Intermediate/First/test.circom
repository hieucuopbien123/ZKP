pragma circom 2.0.8;
include "./node_modules/circomlib/circuits/mux3.circom";

template test(){
    signal output o[1];
    signal input i$;
    signal input _i2;

    component testComp = MultiMux3(1);
    testComp.s[0] <== 1;
    testComp.s[1] <== 2;
    testComp.s[2] <== 3;
    for(var i = 0; i < 8; i++){
        testComp.c[0][i] <== i;
    }
    o <== testComp.out;
}
// Chạy thử cái này !!!!!! Tiếp basic operator => đáng lẽ nó phải lỗi vì output phụ thuộc vào điều kiện ss signal với 1 số nguyên
template IsZero() {
    signal input in;
    signal output out;
    signal inv;
    inv <-- in!=0 ? 1/in : 0;
    out <== -in*inv +1;
    in*out === 0;
}

component main {public [in]}= IsZero();
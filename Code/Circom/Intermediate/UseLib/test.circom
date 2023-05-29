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

template IsZero() {
    signal input in;
    signal output out;
    signal inv;
    log(in);
    log(1/in);
    log(-in*(1/in) +1);
    inv <-- in!=0 ? 1/in : 0;
    // Tức là in!=0 thì 1/in sẽ ok trên trường hữu hạn. in=0 thì trả ra 0 luôn. Thực tế ở TH này in = 0 thì 1/in cũng trả ra 0 vì 
    // groth bỏ qua lỗi và lấy giá trị mặc định là 0
    out <== -in*inv +1;
    in*out === 0;
}

component main {public [in]}= IsZero();
pragma circom 2.0.0;

template A(n){
    signal aux <== 2;
    signal out;

    // # Signal
    _ <== aux;
    if(n <= 2){
        signal x; // v2 của circom cho phép tạo signal trong if
    }
}

component main = A(3);
pragma circom 2.0.0;
include "./node_modules/circomlib/circuits/bitify.circom";

template parity(n){ 
    signal input in; 
    signal output out; 
    component check = Num2Bits(n); 
    check.in <== in; 
    // out là 1 mảng 10 phần tử, nếu chỉ dùng phần tử 0, ta vẫn nên dùng --inspect cho mọi phần tử còn lại k dùng
    out <== check.out[0]; 
    for (var i = 1; i < n; i++) {
        _ <== check.out[i];
    }
}

template check_bits(n){ 
    signal input in; 

    // # Signal
    // Hàm Num2Bits của bitify.circom thg dùng để check xem in có thể biểu diễn dạng n bits không
    component check = Num2Bits(n); 
    check.in <== in; 
    _ <== check.out; // khi k dùng biến out nên để như này
}

// template k được để sau component
component main = check_bits(10);

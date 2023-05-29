pragma circom 2.0.0;

// # Tag / # assert keyword
template A() {
    signal input {binary} in;
    signal intermediate;
    signal {binary} out;
    intermediate <== in*1;
    out.binary = 0;
    out <== intermediate;
}

template B(){
    // Chống lỗi scalar
    signal input a;  
    signal input b;  
    signal inter <== a*b;
    signal output c; 
    c <== inter; 
    // Chống lỗi scalar

    signal {binary} test;
    test <== 2;
    component TestA = A();
    TestA.in <== test;
    assert(1 > 0);

    // # Basic / Dùng log
    // log chỉ được với non-conditional expression
    log();
    log("");
    log("The expected result is ", 135, " but the value of a is", test);
}

component main{public[a, b]} = B();

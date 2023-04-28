pragma circom 2.0.0;

template A() {
    signal input {binary} in;
    signal intermediate;
    signal {binary} out;
    intermediate <== in*1;
    out.binary = 0;
    out <== intermediate;
}

template B(){
    signal {binary} test;
    test <== 2;
    component TestA = A();
    TestA.in <== test;
}

component main = B();

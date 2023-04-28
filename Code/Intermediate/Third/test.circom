pragma circom 2.0.8;

template A(n){
    signal input a, b;
    signal output c;
    c <== a*b;
}
template C(){
    signal output c, d;
}

template D(n){
    signal input a;
    signal output b, c, d;
    b <== a * a;
    c <== a + 2;
    d <== a * a + 2;
}

template B(n){
    signal input in[n];
    signal out <== A(n)( a <== in[0], b <-- in[1]); // Anonymous Components, dùng --> hay ==> đều được
    signal out2 <== A(n)(in[0], in[1]); // or đúng thứ tự

    // Khi có nhiều output thì dùng tuple
    signal output o1, oK;
    (o1,oK) <== C()();

    // tuple cũng dùng được <== và = khi 2 vế cùng là tuple
    var a = 0, b = 0; component c;
    (a, b, c) = (1, a+1, C());

    // signal array cũng dùng được <== nhưng phải cùng kích thước mảng. Kết hợp thoải mái với anonymous component
    signal output out3[n];
    out3 <== in;

    signal output out5;
    (_, out5, _) <== D(n)(1); // Nhiều lúc chỉ muốn thêm constraints, k cần lấy output
}
component main = B(2);
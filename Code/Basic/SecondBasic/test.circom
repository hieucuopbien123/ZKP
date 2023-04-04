pragma circom 2.0.8; // đảm bảo dùng được mọi tính năng. Nếu k có sẽ mặc định dùng bản mới nhất và báo warning
pragma custom_templates;

template custom test(){
    
}

function testFunc(a) {
    var n = 1;
    var r = 0;
    while (n-1<a) {
        r++;
        n *= 2;
    }
    return r;
}

template parallel MultiComponent(n) {
    signal input in[n];
    signal output out;
    component ands[2];
    var i;

    if (n==1) {
        out <== in[0];
    } else {
        var n1 = n\2;
        var n2 = n-n\2;
        ands[0] = MultiComponent(n1);
        ands[1] = MultiComponent(n2);

        for (i=0; i<n1; i++) ands[0].in[i] <== in[i];
        for (i=0; i<n2; i++) ands[1].in[i] <== in[n1+i];
        
        //gán xong giá trị input signal cho mạch thì mới truy cập biến output như này
        out <== ands[0].in[0];
    }
}

template A(param1, param2){
    signal output o1;
    signal input i1;
    o1 <== param1 * param2;

    while (param1 < 2){ 
        param1++;
    }
}

template B(N){
    component a;
    if(N > 0){
        a = parallel A(N,2);
    }
    else{
        a = A(0, 2);
    }
    a.i1 <== 1;
    // a là immutable k thể gán sang 1 loại mạch khác, trong code thì mọi phép gán phải cùng 1 loại mạch

    component b = MultiComponent(2);
    b.in[0] <== 8;
    b.in[1] <== 9;

    component customtemplate = test();
}

component main = B(1);
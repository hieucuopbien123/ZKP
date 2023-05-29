pragma circom 2.0.8;

template fun(N){
    signal output out;
    out <== N;
}
template all(N){
    component c[N];
    for(var i = 0; i < N; i++){
        // Mảng component thì mọi phần tử phải là cùng 1 component nhưng params có thể khác nhau
        c[i] = fun(i);
    }
}

template Num2Bits(n) {
    signal input in; // số đầu vào decimal
    signal output out[n]; // array dầu ra là string dạng binary convert của số đầu vào
    var lc1=0;
    var e2=1;
    for (var i = 0; i<n; i++) {
        out[i] <-- (in >> i) & 1; // lấy từng bit từ phải qua của số
        out[i] * (out[i] -1 ) === 0; // check là chỉ chứa 0 và 1
        lc1 += out[i] * e2; // tính ngược lại giá trị decimal
        e2 = e2+e2;
    }
    lc1 === in; // check tính ngược phải bằng số ban đầu dể đảm bảo conversion đúng
}

component main {public [in]}= Num2Bits(3);

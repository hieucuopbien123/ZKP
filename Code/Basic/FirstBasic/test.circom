pragma circom 2.0.0;

template A(){
   signal input i;
   signal output o;
   i ==> o;

   var x;
   x = 23456;
   var z[3] = [1,2,3];
}

template Multiplier2() {  
   signal input a;  
   signal input b;  
   signal output c;  
   signal testarray[2];
   signal intermediateSignal <== a*b;

   testarray[0] <-- (b >> 1) & 1;

   /*Constraints mạch này check xem c is the multiplication of a and b.*/  
   c <== a * b; 

   var i = 1;
   signal test;
   component comp = A();
   comp.i <== 0;
   test <== comp.o; // chỉ lấy được input output signal của mạch khác, k lấy được intermediate signal
}

component main{public[a, b]} = Multiplier2();

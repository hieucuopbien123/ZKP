pragma circom 2.0.0;

include "./commitment_hasher.circom";

// Mạch circom có vai trò check, nhưng cũng có thể chỉ dùng để sinh ra output để sử dụng. Cho các constraint đều là luôn đúng, khi đó ta k cần sinh ra signature mà compile ra output.
// VD mạch này k check gì cả và chỉ có vai trò sinh output là 2 cái hash. K thích viết bằng JS thì viết lấy hash bằng circom thôi. Nói là deposit nhưng thực chất chỉ là mạch sinh hash
component main = CommitmentHasher();

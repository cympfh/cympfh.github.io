# 代数 - モノイド

モノイド $(X, \times, 1)$ を `std::ops::Mul, unit()` で定義したもの.
`Sum, Prod` は整数型の上の和及び積を二項演算としたモノイド構造.

特に二項演算子が [群](algebra.group) とは違うので注意.

@[rust](procon-rs/src/algebra/monoid.rs)

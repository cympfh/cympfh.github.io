# 代数 - モノイド

積に関するモノイド $(X, \times, 1)$ を定義する.

- 演算 `std::ops::Mul`,
- 単位元 `Monoid::one()`

Rust の `i64`, `f64` はそのまま乗算に関してモノイドになっている.

また, ユーザーが定義した型をモノイドにするためのマクロ `monoid!` を提供する.

```rust
// monoid マクロの使用例
monoid! {
    MyType ;
    one = MyType(1) ;
    mul(self, other) = { compute_multiplication(self, other) }
}

// 型パラメータを取る場合
monoid! {
    MyType<X> where [ X:Ord ] ;
    one = MyType(X::one) ;
    mul(self, other) = { compute_multiplication(self, other) }
}
```

`monoid!` は `product()`, `mul_assign()` を自動で定義する.

@[rust](procon-rs/src/algebra/monoid.rs)

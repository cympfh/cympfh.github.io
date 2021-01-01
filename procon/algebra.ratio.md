# 代数 - 有理数

有理数 $\frac{n}{m}$ を `i64` の２つ組 `Ratio(n, m)` で表す.
`Ratio::new(n, m)` は約分を行うがその分コストがあるので注意.

@[rust](procon-rs/src/algebra/ratio.rs)

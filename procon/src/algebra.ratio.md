# 代数 - 有理数

## 概要
有理数 $\frac{n}{m} \in \mathbb Q$ を `i64` の２つ組 `Ratio(n, m)` で表す.

## 実装
`Ratio(n, m)` で構築するときはただ値の代入のみ行う.
一方で `Ratio::new(n, m)` は約分を行う為コストが係ることに注意.

@[rust](procon-rs/src/algebra/ratio.rs)

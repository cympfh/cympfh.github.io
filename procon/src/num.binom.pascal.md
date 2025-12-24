# 自然数/整数 - 関数 - 二項係数 (パスカルの三角形)

## 概要

パスカルの三角形を用いて,
$1 \leq n \leq N, 0 \leq k \leq n$ についての
$\left(\begin{array}{c}n\\k\end{array}\right)$
を $O(N^2)$ で求める.

二次元配列 `binom` を返し,
$\left(\begin{array}{c}n\\k\end{array}\right)$
が
`binom[n][k]` に入ってる.
範囲外にはゼロが入ってる.

@[rust](procon-rs/src/num/binom_pascal.rs)

# 自然数/整数 - 関数 - 二項係数 (ModInt)

## 概要

二項係数の剰余を取った値
$\left(\begin{array}{c}n\\k\end{array}\right) \bmod M$
を計算量 $O(n \log n)$ で計算する.

@[rust](procon-rs/src/num/binom_modint.rs)

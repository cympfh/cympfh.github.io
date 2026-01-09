# 自然数/整数 - 関数 - 二項係数 (パスカルの三角形)

$\def\binom#1#2{\left(\begin{array}{c}#1\\#2\end{array}\right)}$

## 概要

パスカルの三角形を用いて
$1 \leq n \leq N, 0 \leq k \leq n$ の範囲全ての
$\binom{n}{k}$
を $O(N^2)$ で求める.

境界条件
$$\binom{n}{1} = \binom{0}{k} = 1 \text{ for all } n, k$$

漸化式
$$\binom{n}{k} = \binom{n-1}{k} + \binom{n-1}{k-1} \quad (1 \leq k \lt n)$$

から計算する.

## 実装

二次元配列 `binom` を返し,
$\left(\begin{array}{c}n\\k\end{array}\right)$
が
`binom[n][k]` に入ってる.
範囲外にはゼロが入ってる.

@[rust](procon-rs/src/num/binom_pascal.rs)

# 自然数/整数 - 関数 - 二項係数 (ModInt)

$\def\binom#1#2{\left(\begin{array}{c}#1\\#2\end{array}\right)}$

## 概要

二項係数の剰余を取った値
$\left(\begin{array}{c}n\\k\end{array}\right) \bmod M$
を計算量 $O(n \log n)$ で計算する.

$$\binom{n}{k} = \prod_{i=0}^{k-1} \frac{n-i}{k-i} \bmod M$$

で計算する.
$\mod M$ で除算が出来ることを仮定している.
$M$ が素数であればこれは常に成り立つ.

また, もし計算済みの $\binom{n'}{k'}$ があれば, そこから最短距離で $\binom{n}{k}$ を計算する API も用意している.
これは $O(|n-n'| + |k-k'|)$ で行う.

## 実装

@[rust](procon-rs/src/num/binom_modint.rs)

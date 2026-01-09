# アルゴリズム - FFT - 数列の畳み込み

## 概要

2つの数列 $A_i, B_i$ について,
$$C_k = \sum_{i=0}^k A_i B_{k-i}$$
なる数列 $C_k$ を計算する.

ただし $A_0=B_0=0$ であるとし, $C_0=0$.

## 参考

- [ATC001/C - 高速フーリエ変換](http://atc001.contest.atcoder.jp/tasks/fft_c)

@[rust](procon-rs/src/algorithm/fft.rs)

# アルゴリズム - 連立一次方程式 - Gauss-Jordan の消去法

## 概要

行列 $A \in \mathbb R^{N \times N}$ と
ベクトル $b \in \mathbb R^N$ について
$$Ax=b$$
を $O(N^3)$ で解く.

掃き出し法とも呼ばれる.

## 参考

- [[https://ja.wikipedia.org/wiki/%E3%82%AC%E3%82%A6%E3%82%B9%E3%81%AE%E6%B6%88%E5%8E%BB%E6%B3%95]]

## 実装

@[rust](procon-rs/src/algorithm/gauss_jordan.rs)

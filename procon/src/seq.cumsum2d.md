# 数列 - 二次元累積和 (Cumulative sum)

## 概要

二次元配列を与えたとき,
`(0, 0)` から `(i, j)` までの矩形の和を保存することで
任意の矩形 `(i0..i1, j0..j1)` (`i1`, `j1` は含まない半開区間) の和を $O(1)$ で求める.

## 実装

@[rust](procon-rs/src/sequence/cumsum2d.rs)

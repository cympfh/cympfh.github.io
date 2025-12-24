# 数列 - 一次元累積和 (Cumulative sum)

## 概要

一次元配列 $x$ が与えられたとき,
任意の添字区間 $[l, r)$ に対して
$$\sum_{i = l}^{r-1} x_i$$
を $O(1)$ で計算する.

数列中の値の変更は出来ないので注意.

## メモ
値を動的に変更したい場合は [BIT (Fenwick Tree)](seq.bit) を使うと便利.

@[rust](procon-rs/src/sequence/cumsum1d.rs)

# 数列の畳み込み

2つの数列 $A_i, B_i$ について,
$$C_k = \sum_{i=0}^k A_i B_{k-i}$$
なる数列 $C_k$ を計算する.

## 例題

- [C: 高速フーリエ変換 - AtCoder](http://atc001.contest.atcoder.jp/tasks/fft_c)

## [fft.convolution.rs](fft.convolution.rs)
@[rust](fft.convolution.rs)

## [fft.convolution.cc](fft.convolution.cc)
@[cpp](fft.convolution.cc)

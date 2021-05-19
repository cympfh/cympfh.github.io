# 数列 - スライド最小値

## 概要

全順序集合の上の数列
$$x_1, x_2, \ldots, x_N$$
について,
ウィンドウサイズ $k$ のウィンドウ列とは長さ $N-k+1$ の列であって,
$$(x_1, x_2, \ldots, x_k), (x_2, x_3, \ldots, x_{k+1}), \ldots, (x_{N-k+1}, \ldots, x_N)$$
というもの.
この各
$$(x_j, x_{j+1}, \ldots, x_{j+k-1})$$
の最小値のその添字の列
$$i_1, i_2, \ldots, i_{N-k+1}$$
$$\text{s.t. } ~~ x_{i_j} = \min \{ x_j, x_{j+1}, \ldots, x_{j+k-1} \}$$
を $O(N)$ で計算する.

## 実装

@[rust](procon-rs/src/sequence/slide_min.rs)


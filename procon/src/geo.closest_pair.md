# 2次元最近点対問題

## 概要

$N$ 個の平面上の点
$S = \{p_1, p_2, \ldots, p_N\}$
が与えられたとき,
最近接点対 (closest pair) とは, 互いに最も近い2点の組のことである.

$$\mathrm{closest\_pair}(S) = \mathop{\mathrm{argmin}}_{i \neq j} ~ \|p_i, p_j\|_2$$

## 実装

空間に関して分割統治法を用いることで $O(N \log N)$ 時間で解くことができる.

@[rust](procon-rs/src/geometry2d/closest_pair.rs)

# Manacher による最大長回文探索アルゴリズム

## 参考

- [Spaghetti Source - 最長回文 (Manacher)](http://www.prefield.com/algorithm/string/manacher.html)

## 概要

文字列 $s$ が与えられた時、$s$ の各点を中心とする回文の最大長を求める.
ここで $n = |s|$ とすると、各点とは

- $i = 1,2, \ldots, n$ 及び
- $j = (1, 2), (2, 3), \ldots, (n-1, n)$

の二種類のこと.
$i$ は各文字に対応し、$j$ は隣り合った2文字の間を指す.
これを中心とする (連続) 部分文字列とは

- 中心 $i$ に就いて $s(i - x, i + x)$ または
- 中心 $j = (j_0, j_1)$ に就いて $s(j_0 - x, j_1 + x)$

のこと.

## 入出力

返り値は
$$1, (1, 2), 2, (2, 3), 3, \ldots, n-1, (n-1, n)$$
を中心としたする回文の最大長を収めたベクトル.

@[rust](procon-rs/src/string/manacher.rs)

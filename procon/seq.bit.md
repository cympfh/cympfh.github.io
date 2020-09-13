# 数列 - Binary Indexed Tree (BIT; Fenwick Tree)

## 参考
- [wikipedia/Fenwick tree](http://en.wikipedia.org/wiki/Fenwick_tree)

## 概要

群 $(X, \pm, 0)$ 上の数列について,

- 初期状態
    - 長さ $n$ の数列: $v = \{ v_0, v_1, \ldots, v_{n-1} \} = \{0,0,\ldots,0\}$
- 次の2つの操作が出来る
    1. $v_i \leftarrow v_i + x$
    1. $v_0 + v_1 + \cdots + v_{m-1}$
        - 特に2つ目から、任意区間の総和が算出できる
- 計算量
    - 時間計算量: 共に $O(log(n))$
    - 空間計算量: 数列の長さ $n$ 程度の配列.

@[rust](procon-rs/src/sequence/tree/bit.rs)

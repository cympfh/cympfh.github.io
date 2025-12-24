# 累積和に関する BIT (Fenwick Tree)

## 概要

初めゼロからなる数列 $v = (v_1, v_2, \ldots, v_n)$ について,
その累積和を [BIT](seq.bit) で表現することで, 次のような双対操作が高速（対数時間）で処理が出来る.

1. 区間への加算 $((\ell, r), x)$
    - $v_i \leftarrow v_i + x$ for each $\ell \leq i \lt r$
2. 要素の取得
    - $v_i$

@[rust](procon-rs/src/sequence/tree/bit_cumulative.rs)

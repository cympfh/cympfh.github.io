# 区間加算を処理する BIT (Fenwick Tree)

## 概要

初めゼロからなる数列 $v = (v_0, v_1, \ldots, v_{n-1})$ について,
次の2つの操作を高速（対数時間）に行いたい.

1. 区間への加算 $([\ell, r), x)$
    - $v_i \leftarrow v_i + x$ for each $\ell \leq i \lt r$
2. 要素の取得
    - $v_i$

差分列 $u$ を [BIT](seq.bit) で管理することにする.
つまりある数列 $u$ があって, これの累積和が元の数列 $v$ になるようにする.

- $v_0 = u_0$
- $v_1 = u_0 + u_1$
- $v_k = \sum_{i=0}^{k} u_i$

$v$ の代わりに $u$ について次のよう処理すればよい.
初期値は $u_i = 0$ でよくて,

1. 区間への加算 $([\ell, r), x)$
    - $u_\ell \leftarrow u_\ell + x$
    - $u_r \leftarrow u_r - x$
2. 要素の取得
    - $v_i = \sum_{j=0}^{i} u_j$

これらは BIT で高速に処理できる.

## 実装

@[rust](procon-rs/src/sequence/tree/bit_cumulative.rs)

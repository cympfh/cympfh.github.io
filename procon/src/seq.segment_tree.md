# 数列 - セグメントツリー

[モノイド](algebra.monoid) $(X, \times, 1)$ と $X$ 上の数列
$$(x_1, \ldots, x_N \mid x_i \in X)$$
について, 次の操作がそれぞれ $O(\log N)$ で出来る.

- 区間積の計算
    - 添字区間 $I$ について $\prod_{i \in I} x_i$
- 一点更新
    - $x_i \leftarrow x$

コンストラクタとして, 長さだけ指定して単位元で初期化する `new` と,
数列を `vec` で与える `from` とがある.

@[rust](procon-rs/src/sequence/tree/segment_tree.rs)

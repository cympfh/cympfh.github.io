# 数列 - 遅延セグメントツリー

## 概要

モノイド $X$ とその上のモノイド（右）作用 $M$ があるとする.
このとき次のことが高速に出来る.
$X$ 上の数列 $v$ について,

- 区間取得
    - 添字区間 $I$ について $\prod_{i \in I} x_i$
- 区間更新
    - 添字区間 $I$ と作用 $m \in M$ について
        - 各 $i \in I$ に対して $x_i \leftarrow x_i \ast m$ (作用)

すなわち数列に対する更新操作をモノイド作用だということにしている.
計算量はこの2つの操作がともに $O(\log N)$.

## 例題

- [ABC177/F](https://atcoder.jp/contests/abc177/submissions/16522911)
- [AtCoder Library Practice Contest/L](https://atcoder.jp/contests/practice2/submissions/16577269)

@[rust](procon-rs/src/sequence/tree/lazy_segment_tree.rs)

# 数列 - Range Maximum/Minimum Query (RMQ)

## 概要

[Max/Min モノイド](algebra.monoid.minmax) をセグメントツリーに載せることで次の操作をそれぞれ $O(\log N)$ で出来るセグメントツリーが構成できる.

- 区間最大値/最小値の計算
    - 添字区間 $I$ について $\max_{i \in I} x_i$ / $\min_{i \in I} x_i$ を求める
- 一点更新
    - $x_i \leftarrow x_{\mathrm{new}}$

## 実装

@[rust](procon-rs/src/sequence/tree/rmq.rs)

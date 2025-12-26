# 数列 - 区間代入 RMQ

## 概要

モノイド $X$ 上の数列
$$(x_1, \ldots, x_N \mid x_i \in X)$$
について次の2つが高速に操作できる

- 区間の最大値/最小値の計算
    - 添字区間 $I$ について, $\max \{ x_i \mid i \in I\}$ または $\min \{ x_i \mid i \in I \}$
- 区間への **代入**
    - 添字区間 $I$ について, $x_i \leftarrow x$ for each $i \in I$

## 実装

@[rust](procon-rs/src/sequence/tree/ranged_assign_rmq.rs)

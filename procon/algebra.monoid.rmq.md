# 代数 - RMQモノイド

Range Maximum/Minimum Query を [セグメントツリー](seq.segment_tree) に載せるためのモノイド構造.
適当な整数型を `X` としてこの上に $\min$ または $\max$ を二項演算子とするモノイド.

@[rust](algebra.monoid.rmq.rs)


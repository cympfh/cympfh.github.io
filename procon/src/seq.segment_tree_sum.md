# 数列 - 加法セグメントツリー

## 概要

`i64` の和に関するセグメントツリーの定義を与える.

実装は [セグメントツリー](seq.segment_tree) に [Sum モノイド](algebra.monoid.sum) を載せるだけだが,
直接 `i128` でやり取り出来るAPIを提供している.

@[rust](procon-rs/src/sequence/tree/segment_tree_sum.rs)

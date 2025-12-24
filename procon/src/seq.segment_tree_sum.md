# 数列 - 加法セグメントツリー

`i64` の和に関するセグメントツリーの定義を与える.

以下の `SegmentTreeSum` は直接 `i64` でやり取り出来るAPIを提供しているが,
内部では `Sum` モノイドに包んである.

@[rust](procon-rs/src/sequence/tree/segment_tree_sum.rs)

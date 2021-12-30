# 代数 - Min/Max モノイド

整数は $\min$ または $\max$ を演算にしてモノイドになる.
ただし, それぞれ単位元として $\infty$ 及び $-\infty$ を付け足す必要がある.

これを [セグメントツリー](seq.segment_tree) に載せると RMQ.

@[rust](procon-rs/src/algebra/monoid_min.rs)
@[rust](procon-rs/src/algebra/monoid_max.rs)

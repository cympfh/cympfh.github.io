# 代数 - モノイド - Min/Max モノイド

整数は $\min$ または $\max$ を演算にしてモノイドになる.
ただし, それぞれ単位元として $\infty$ (`Maximal`) または $-\infty$ (`Minimal`) を付け足す必要がある.
これを [セグメントツリー](seq.segment_tree) に載せることで [RMQ](seq.rmq.html) を得る.

@[rust](procon-rs/src/algebra/monoid_min.rs)
@[rust](procon-rs/src/algebra/monoid_max.rs)

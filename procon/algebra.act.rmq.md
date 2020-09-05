# 代数 - RMQ作用

[RMQモノイド](algebra.monoid.rmq) と組み合わせてモノイド作用付きモノイドとして使う.
これを [遅延セグメントツリー](seq.lazy_segment_tree) に載せると, 区間更新の出来る RMQ になる.

@[rust](algebra.act.rmq.rs)

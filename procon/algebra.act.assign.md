# 代数 - 代入作用

値を上書きする作用.

[Min/Max モノイド](algebra.monoid.minmax) と組み合わせてモノイド作用付きモノイドとしたとき,
これを [遅延セグメントツリー](seq.lazy_segment_tree) に載せると, 区間更新の出来る RMQ になる.

@[rust](procon-rs/src/algebra/act_assign.rs)

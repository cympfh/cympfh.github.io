# 代数 - 作用 - 代入作用

代入を表現する **右** モノイド作用を定義する.

集合 $X$ について,
$$A_X = X \sqcup \{ \bot \}$$
は, 代入（値の上書き）という作用 $(\ast)$ を表現する.

- 作用
    - $x \ast a = a$ if $a \ne \bot$
    - $x \ast \bot = x$
- 単位元
    - $x \ast \bot = x$
- 合成
    - $a \times b = b$ if $b \ne \bot$
    - $a \times \bot = a$

[Min/Max モノイド](algebra.monoid.html#2-Min%2FMax%20%E3%83%A2%E3%83%8E%E3%82%A4%E3%83%89)
と組み合わせてモノイド作用付きモノイドとしたとき,
これを [遅延セグメントツリー](seq.lazy_segment_tree) に載せると, 区間更新の出来る RMQ になる.

@[rust](procon-rs/src/algebra/act_assign.rs)

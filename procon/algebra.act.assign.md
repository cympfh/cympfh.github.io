# 代数 - 作用 - 代入作用

代入を表現する **右** 作用を定義する.

集合 $X$ について,
$$A_X = X \sqcup \{ \bot \}$$
は, 代入（または値の上書き）をする作用 $(\ast)$ を表現する.

- 作用
    - $x \ast a = a~~~$ if $a \ne \bot$
    - $x \ast \bot = x$
- 合成
    - $ab = b~~~$ if $b \ne \bot$
    - $a \bot = a$
    - $x \ast (ab) = (x \ast a) \ast b~~$ where $x \in X ,~ a,b \in A_X$

[Min/Max モノイド](algebra.monoid.minmax) と組み合わせてモノイド作用付きモノイドとしたとき,
これを [遅延セグメントツリー](seq.lazy_segment_tree) に載せると, 区間更新の出来る RMQ になる.

@[rust](procon-rs/src/algebra/act_assign.rs)

# 代数 - 作用

集合 $M$ が集合 $X$ 上の作用であるとは, 各元 $m \in M$ が写像 $X \to X$ として機能すること.
以下の実装ではこの写像を `act(&Self, X) -> X` で定義する.

@[rust](algebra.act.rs)

これと [Monoid](algebra.monoid) と組み合わせることで左/右モノイド作用を作れたりする.

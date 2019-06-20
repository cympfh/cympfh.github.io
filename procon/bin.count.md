# bin.count

昇順に整列した整数列 `xs` と整数 `x` が与えられたとき, `x` が何度出現するかを二分探索で調べる.

[二分探索](bin.search.html) を $P(n) = (n \geq x)$ としてやれば, $P(n+1)-P(n)$ が答え.
ただし境界だけ注意.

@[rust](bin.count.rs)

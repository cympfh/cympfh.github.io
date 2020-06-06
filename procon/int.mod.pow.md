# int.mod.pow

整数 $a, n$ と $m$ について
$$a^n \bmod m$$
を $O(\log n)$ で求める.

> __NOTE__
> 特に $m$ が素数の時, $a^{m-2}$ が $a^{-1}$ になる (フェルマーの小定理).

## [int.mod.pow.rs](int.mod.pow.rs)

@[rust](int.mod.pow.rs)

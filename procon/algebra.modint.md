# 代数 - ModInt ($\mathbb Z/p\mathbb Z$, $\mathbb Z_p$)

## 概要

$\def\Z{\mathbb Z}$
剰余類環 $\Z_p$ を定義する.
$$\Z_p = \{ x + p \Z \mid x \in \Z \}$$
ただし, $x + p \Z = y + p \Z \iff (x-y) \in p\Z \iff x \equiv y \pmod p$.

ここで実装を与える `ModInt` は
$x + p\Z \in \Z_p$
を
$(x \bmod p) \in \{ 0,1,\ldots,p-1 \}$
と同一視して後者で計算する.

加算と乗算は整数のものをそのまま使えて環になる.
逆数は一般には存在しないが, $\gcd(x,p)=1$ のとき $x^{-1}$ は存在し,
特に $p$ が素数なら $\Z_p$ は体である.

## 例題

- [ABC130/E - Common Subsequence](https://atcoder.jp/contests/abc130/tasks/abc130_e)
    - [回答例: submissions/6014247](https://atcoder.jp/contests/abc130/submissions/6014247)
- [M-SOLUTIONS プロコンオープン: C - Best-of-(2n-1)](https://atcoder.jp/contests/m-solutions2019/tasks/m_solutions2019_c)
    - [回答例: submissions/6217803](https://atcoder.jp/contests/m-solutions2019/submissions/6217803)

## 実装について

$(x + p \mathbb Z) \in \mathbb Z_p$ をペア $((x \bmod p), p)$ で表現する.
ただし, 計算中で $p$ は定数だとしていて, 演算中に異なる $p$ が混ざるようなことはないと仮定している.

$p$ が素数であることを前提に逆元 (`inv()`) や除算の計算をサポートする.
逆数が存在しない場合は実行時エラーを投げる.

`mint!` マクロは（よく登場する値である） $p = 1,000,000,007$ ということにして,
$x + p \Z$ を `mint!(x)` で宣言できる.
この $p$ の値を変える場合は, 現状では `mint` マクロの定義を直接変更するしかない.

`ModInt` は極力 `i64` との四則演算をサポートしている.

@[rust](procon-rs/src/algebra/modint.rs)

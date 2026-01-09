# 代数 - ModInt ($\mathbb Z/p\mathbb Z$, $\mathbb Z_p$)

## 概要

$\def\Z{\mathbb Z}$
剰余類環 $\Z_p$ を定義する.
$$\Z_p = \{ x + p \Z \mid x \in \Z \}$$
ただし

$$x + p \Z = y + p \Z \iff (x-y) \in p\Z \iff x \equiv y \pmod p.$$

という訳で
$x + p\Z \in \Z_p$
と
$(x \bmod p) \in \{ 0,1,\ldots,p-1 \}$
とは同一視して計算できる.

加算と乗算は整数のものをそのまま使えて環になる.
逆数は一般には存在しないが $\gcd(x,p)=1$ のとき $x^{-1}$ は存在する.
特に $p$ が素数なら $0$ 以外の逆数が常に存在して $\Z_p$ は体である.

## 例題

- [ABC130/E - Common Subsequence](https://atcoder.jp/contests/abc130/tasks/abc130_e)
    - [回答例: submissions/6014247](https://atcoder.jp/contests/abc130/submissions/6014247)
- [M-SOLUTIONS プロコンオープン: C - Best-of-(2n-1)](https://atcoder.jp/contests/m-solutions2019/tasks/m_solutions2019_c)
    - [回答例: submissions/6217803](https://atcoder.jp/contests/m-solutions2019/submissions/6217803)

## 実装

$(x + p \mathbb Z) \in \mathbb Z_p$ をペア $((x \bmod p), p)$ で表現する.
ここで $(x \bmod p)$ とは $x$ を $p$ で割った余りを $[0, p-1]$ の範囲で表したもの.
また $p$ は計算の中で一貫して同じ値を使うことを想定している.

$p$ が素数であることを前提に逆元 (`inv()`) や除算の計算をサポートする.
逆数が存在しない場合は実行時エラーを投げる.

`mint!` マクロは $p$ を決め打ちして $x + p \Z$ を `mint!(x)` で宣言できる.
$p$ の値を変えたい場合は, `mint` マクロの定義を直接書き換える.

`ModInt` は極力 `i64` との四則演算をサポートしている.

@[rust](procon-rs/src/algebra/modint.rs)

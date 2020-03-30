% 確率の定義
% 2019-12-14 (Sat.)
% 測度論 確率論

$\def\F{\mathcal{F}}\def\R{\mathbb{R}}$

## 測度空間

**測度空間** とは,
集合 $X$,
$X$ の部分集合の族 $\F$,
関数 $m \colon \F \to \R$ ($\R$ は実数)
の三組
$$(X, \F, m)$$
であって, $\F$ は次を満たすとする.

1. $\emptyset \in \F$
1. $A \in \F \implies A^c \in \F$ （ここで $A^c$ は $X \setminus A$ のこと）
1. $A, B \in \F \implies A \cup B \in \F$
1. $E_i \in \F \implies \bigcup_{i=1}^{\infty} E_i \in \F$

> ちなみに 1~3 を満たす $\F$ を $X$ の f-集合体という.
> 1~4 を満たす $\F$ を $X$ の $\sigma$-集合体という.

そして更に $m$ は次を満たすとする.

1. $m(\emptyset) = 0$
1. $\forall A \in \F, 0 \leq m(A) \leq \infty$
1. $E_i \in \F \land (i \ne j \implies E_i \cap E_j = \emptyset) \implies m(\bigcup_{i=1}^{\infty} E_i) = \sum_{i=1}^{\infty} m(E_i)$
    - 加算個の和も ok
    - もちろん適切に $n>N \implies E_n=\emptyset$ と設定すれば, 有限個の和も ok であることが分かる

### 性質

導かれる性質として次のようなものがある.

1. $X \in \F$
1. $E_i \in \F \implies \bigcap_{i=1}^{\infty} E_i \in \F$ （加算無限個の積もok）
1. $A, B \in \F \implies A \setminus B \in \F$
1. $m(A^c) = m(X) - m(A)$

### 可測関数

測度空間 $(X, \F, m)$ に対して,
関数 $f \colon X \to \R$ があるとする.

実数 $a \in \R$ について
$\{ x \mid f(x) > a \}$ のことを $[f > a]$ と書く.
全く同様に
$\{ x \mid f(x) \leq a \}$ のことを $[f \leq a]$ とか,
$\{ x \mid f(x) \in E \}$ のことを $[f \in E]$ とか書く.

任意の実数 $a$ について
$$[f > a] \in \F$$
のとき, $f$ を **可測関数** という.

ここで定義中の $[f > a]$ を $[f \geq a]$ とか $[f < a]$ とか $[f \leq a]$ に置き換えても同値である.
ここから $[f = a] \in \F$ を導ける.

## 確率空間

測度空間
$$(\Omega, \F, P)$$
があって, その $P$ が更に

1. $P(\Omega) = 1$
1. $0 \leq P(A) \leq 1 ~ (A \in \F)$

を満たす時, これを **確率空間** という.
また, $\Omega$ を **標本空間**, $\F$ を **事象族**, $P$ を **確率** という.

### 諸概念

確率空間 $(\Omega, \F, P)$ に対して,
関数 $X$ が $\Omega \to \R$ なる関数であってしかも可測関数であるとき,
$X$ を **確率変数** という.

例えば $[X = a] := \{ \omega \in \Omega \mid X(\omega) = a \}$ であるが,
可測関数であることからこれは $\F$ に入ってる.
従って $P([X=a])$ が値を定める.
これを普通 $[]$ を省略して $P(X=a)$ と書く.

特に $X$ に対して $\mu_X(a) = P(X=a)$ で定めた関数 $\mu_X \colon \R \to \R$ を $X$ の **分布** という.

任意の実数区間 $[a,b]$ について
$$P(X \in [a,b]) = \int_a^b f(x) dx$$
を満たすような関数 $f$ があったとする.
このとき $f$ のことを $X$ の **確率密度** という.

確率密度が存在するとき,
$\mu_X(a) = P(X=a) = P(X \in [a,a]) = \int_a^a f(x) dx = 0$
である.
例えば実数区間の一様分布などがそれである.

$$E[X] = \int_\Omega X(\omega) dP(\omega)$$
という積分値が定まるとき, それを $X$ の平均とか **期待値** とかいう.

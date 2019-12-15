% 大数の法則
% 2019-12-15 (Sun.)
% 確率論 測度論

$\def\F{\mathcal{F}}\def\R{\mathbb{R}}\def\BR{\mathcal{B}(\mathbb{R})}$

## 確率変数の独立性

確率空間 $(\Omega, \F, P)$ の上の加算無限個の確率変数
$$X_1, X_2, \ldots$$
について次が成り立つ時, これらは **独立** であるという.

実数の上のボレル集合族 $\BR$ の任意の集合
（要は加算無限個の開区間を和積差で組み合わせて出来る集合）
$$E_1, E_2, \ldots \in \BR$$
に対して
$$P(X_1 \in E_1, X_2 \in E_2, \ldots) = \prod_i P(X_i \in E_i)$$
が成り立つ.

念の為に補足すると, 左辺は
$\{ \omega \in \Omega \mid X_1(\omega) \in E_1 \land X_2(\omega) \in E_2 \land \cdots \}$
の確率測度で,
右辺は個々
$\{ \omega \in \Omega \mid X_i(\omega) \in E_i \}$
の確率測度の積.

## 大数の法則

分布が等しく,
独立な確率変数
$X_1, X_2, \ldots$
があるとき,
$$\frac{1}{n} \left( X_1 + X_2 + \cdots + X_n \right)$$
は $n \to \infty$ のとき $E[X_1]$ を定める.

% 大数の法則
% 2019-12-15 (Sun.), 2020-01-07 (Tue.)
% 確率論 測度論

$\def\F{\mathcal{F}}\def\R{\mathbb{R}}\def\BR{\mathcal{B}(\mathbb{R})}\def\RX{\mathbb R_X}$

## 確率変数

[確率空間](probability.html)
$(\Omega, \F, P)$
について,
関数 $X \colon \Omega \to \R$ が可測であるとき, これを確率変数だという.
関数が可測であるとはすなわち,
任意の実数 $a$ について,
$$[X > a] \equiv \{ \omega \in \Omega \mid X \omega > a \}$$
が $\F$ に属する（つまり可測空間である）こと.
ちなみに $[X > a]$ の代わりに $[X \geq a]$ とか $[X < a]$ とかを使っても同値である.

$X$ の像
$\{ X\omega \mid \omega \in \Omega \} (\subset \R)$
を
$\RX$ と書く.

### 確率変数の分布

確率変数 $X$ に対してその分布を $\mu_X$ と書くが, これは次のような関数 $\RX \to \R$.

$$\mu_X(a) = P(X = a) = P \{ \omega \in \Omega \mid X \omega = a \}$$

以下で確率空間は固定して考える.

## 確率変数の独立性

加算無限個の確率変数
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

## 期待値、分散

確率変数 $X$ の __期待値__ を次で定義してそれを $EX$ と書く.

$$EX = \int_\Omega X \, dP$$

特に $P$ が離散であれば $EX = \sum_{\omega \in \Omega} X \omega \times P(\omega)$ と書ける.

確率変数 $X$ の __分散__ を次で定義しそれを $VX$ と書く.

$$VX = E (X - EX)^2$$

### 性質

- $E(aX + b) = a EX + b \; (a, b \in \R)$
- $V(aX + b) = a^2 VX \; (a, b \in \R)$
- $VX = E(X^2) - (EX)^2$

独立であるが同じ分布を持つ（このことを iid と言う）
$X_1, X_2, \ldots, X_n$
を考える.
これについて次が成り立つ.

- $E (\sum_i X_i) = \sum_i E X_i$
- $E (\prod X_i) = \prod_i E X_i$
- $V (\sum_i X_i) = \sum_i V X_i$

## マルコフの不等式

確率変数 $X$ について次が成り立つ.

$$\forall \epsilon > 0, P(|X| > \epsilon) \leq \frac{1}{\epsilon} E |X|$$

### 証明

$A = [ |X| > \epsilon ] \subset \Omega$ と置くと
$E |X| = \int_\Omega |X| \, dP \geq \int_A |X| \, dP \geq \int_A \epsilon \, dP = \epsilon \times P(A)$
より従う.

## チェビシェフの不等式

$$\forall \epsilon > 0, P(|X - EX| > \epsilon ) \leq \frac{1}{\epsilon^2} VX$$

### 証明

マルコフの不等式と全く同様.
$A = \left[ |X-EX| > \epsilon \right] \subset \Omega$ と置いて,
$VX = E(X-EX)^2 \geq \int_A (X-EX)^2 \, dP \geq \epsilon^2 \times P(A)$
から従う.

## 確率変数の収束

確率変数の列 $\{ X_i \}_{i=1,2,\ldots}$ の収束を次の二通りで定義する.

### 確率収束

次が成り立つとき, $\{X_i\}$ は $X$ に確率収束するという.
$$\forall \epsilon > 0, \lim_{n \to \infty} P(|X_n - X| > \epsilon) = 0$$

### ほとんど確実に収束 (almost surely convergence)

一般に、確率変数 $X$ に関するある命題 $\Phi(X)$ が成立する確率が 1 のとき,
「ほとんど確実に $\Phi(X)$ は成立する」と言い、「$\Phi(X)$ a.s.」と書く.
ここで "a.s." は almost surely の略.

__ほとんど確実に__
確率変数の列 $X_i$ が $X$ に収束するとは
$$P(\lim_i X_i = X) = 1$$
のこと.

一般に「ほとんど確実に収束する」とき確率収束することは従う.
確率収束はほとんど確実の収束より弱い.

## 大数の法則

iid な $X_1, X_2, \ldots$ を考える.
分布が等しいので $m=E X_i$ と置いておく.
期待値 $m$ も分散 $VX_i$ も（発散せず）値を定めるとする.
$n$ 個の平均
$$Y_n = \frac{1}{n} \left( X_1 + X_2 + \cdots + X_n \right)$$
は $n \to \infty$ のとき $m$ に収束する.

この収束の仕方として確率収束を言うのを「弱法則」、ほとんど確実収束を言うのを「強法則」という.

### 弱法則の証明

$\lim_n P(Y_n > \epsilon) = 0$ が成り立つことを言う.

まず先に確認することとして,
$EY_n = E(\frac{1}{n} \sum X_i) = m$,

$$\begin{align*}
VY_n & = E(Y_n)^2 - (EY_n)^2 \\
& = \frac{1}{n^2} E(\sum_i X_i)^2 - m^2 \\
& = \frac{1}{n^2} E(\sum_i X_i^2 + \sum_{i \ne j} X_i X_j) - m^2 \\
& = \frac{1}{n^2} E(n X_i^2 + n(n-1) X_i X_j) - m^2 \\
& = \frac{1}{n} E(X_i^2 - m^2) \\
& = \frac{1}{n} VX_i \\
\end{align*}$$

> $i \ne j$ について $E(X_i X_j) = m^2$ としたところに, 独立性を利用している

チェビシェフの不等式によれば,

$$\begin{align*}
P(|Y_n - m| > \epsilon) & \leq \frac{1}{\epsilon^2} VY_n \\
& = \frac{1}{n\epsilon^2} VX_i \\
\end{align*}$$

最後の右辺は $n \to \infty$ のとき $\to 0$ なので,
$\lim_n P(Y_n > \epsilon) = 0$ が言えた.

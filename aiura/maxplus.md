% 熱帯半環, max-plus 代数
% 2022-01-30 (Sun.)
% 代数

$\def\R{\mathbb R}\def\Re{\mathbb{R}_{\epsilon}}\def\P{\mathbb{P}_{\epsilon}}$

## 半環

集合 $X$ とその上の2つの演算
$\oplus$ と $\otimes$
について,

- $(X, \oplus, 0)$ が可換モノイド
    - ここで $0 \in X$ が単位元
- $(X, \otimes, 1)$ がモノイド
    - ここで $1 \in X$ が単位元
- 分配法則
    - $a \otimes (b \oplus c) = (a \otimes b) \oplus (a \otimes c) = (b \oplus c) \otimes a$
- 零化
    - $0 \otimes a = a \otimes 0 = 0$

が成り立つとき, $(X, \oplus, \otimes)$ を **半環 (semiring)** という.

加えて, $a \oplus a = a$ という冪等性が成り立つ半環を **冪等半環 (dioid)** という.

環と同様に,
$\oplus$ を加法の演算,
$\otimes$ を乗法の演算と呼ぶことにする.
また $x \otimes y$ のことを $xy$ と書く場合がある.

## 熱帯半環

実数とそこに負の無限大 $(-\infty)$ を表す数 $\epsilon$ を付加した集合
$$\Re = \R \cup \{ \epsilon \}$$
これは $\oplus$ を $\max$, $\otimes$ を $+$ とすることで半環になる.
これを **熱帯半環** という.
また, max と plus で構成しているので **max-plus 代数** という.

付加する数を正の無限大として, $\max$ でなく $\min$ を使っても同じ構造が得られるわけだが,
こちらは min-plus 代数と呼んで区別する.

演算を確認すると次の通り.

- 加法
    - $x \oplus y = \max(x,y)$ if $x,y \in \R$
    - $x \oplus \epsilon = x$
    - $\epsilon \oplus x = x$
- 乗法
    - $x \otimes y = x + y$ if $x,y \in \R$
    - $x \otimes \epsilon = \epsilon \otimes x = \epsilon$

また, 加法は冪等性 $x \oplus x = x$ を満たす.
というわけで $(\Re, \max, +)$ は確かに（冪等）半環.

$r$ を自然数として, $r$ 個の $x \in \R$ の（$\otimes$ に関する）積を次のように表す.
$$x^{\otimes r} = x \otimes x \otimes \cdots \otimes x$$
これを $x \in \Re, r \in \R$ に拡張すると次のように定まる.

- $x^{\otimes r} = rx$ if $x \in \R$
- $x^{\otimes 0} = 0$ for all $x \in \Re$
- $\epsilon^{\otimes r} = \epsilon$ if $r > 0$

## 熱帯半環の行列演算

普通に $\Re$ を環のつもりで行列を定義すれば, 演算も定まる.
行列同士の積だけ確認しておくと次の通り.

$A \in \Re^{m \times p}$, $B \in \Re^{p \times n}$ について,
$$(A \otimes B)_{ij} = \bigoplus a_{ik} \otimes b_{kj} = \max \{ a_{ik} + b_{kj} \mid j = 1,2,\ldots,p \}$$

特に単位行列は
$$\left[ \begin{array}{ccc}0 & \epsilon & \epsilon \\ \epsilon & 0 & \epsilon \\ \epsilon & \epsilon & 0 \end{array}\right]$$
ゼロ行列は
$$\left[ \begin{array}{ccc}\epsilon & \epsilon & \epsilon \\ \epsilon & \epsilon & \epsilon \\ \epsilon & \epsilon & \epsilon \end{array}\right]$$

## 対称化

$$\P = \Re \times \Re$$
として, これに次の演算を定める.

- $(a,b) \oplus (c,d) = (a \oplus c, b \oplus d)$
- $(a,b) \otimes (c,d) = (ac \oplus bd, ad \oplus bc)$

とするとやはりこれは（冪等）半環になっている.

> $\Re \to \P$; $x \mapsto (x, \epsilon)$ は準同型の包含射.

またいくつか追加で演算を導入する.

- 絶対値
    - $u = (x_1, x_2)$ について $|u| = x_1 \oplus x_2$
- マイナス
    - $u = (x_1, x_2)$ について $\ominus u = (x_2, x_1)$
    - $u \oplus (\ominus v)$ のことを $u \ominus v$ と書く
- バランス演算
    - $u^\bullet = u \oplus (\ominus u) = (|u|, |u|)$
- バランス関係
    - $u \triangledown v \iff u_1 \oplus v_2 = u_2 \oplus v_1$
    - これは大体同値関係みたいなものを与えるが, 推移率が成り立っていない

そしてバランス関係を使って $\P$ の上の同値関係を次で定める.

$u = (u_1,u_2), v = (v_1,v_2) \in \P$ について,
$$u \equiv v \iff u = v \lor ( u \triangledown v \land u_1 \ne u_2 \land v_1 \ne v_2 )$$

$\P/\equiv$ を対称化 max-plus 代数という.


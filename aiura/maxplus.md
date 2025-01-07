% 熱帯半環, max-plus 代数
% 2022-01-30 (Sun.)
% 代数

$\def\R{\mathbb R}\def\Re{\mathbb{R}_{\epsilon}}\def\S{\mathcal{S}}$

<div id=toc></div>

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

## max-plus 代数の対称化

半環 $\Re$ には $\oplus$ についてマイナスの概念が定義されてないのは不便なので,
これを定めるために対称化と呼ばれる操作を行う.

$$\Re^2 = \Re \times \Re$$
として, これに次の演算を定める.

- $(a,b) \oplus (c,d) = (a \oplus c, b \oplus d)$
    - 単位元 $\epsilon = (\epsilon, \epsilon)$
- $(a,b) \otimes (c,d) = (ac \oplus bd, ad \oplus bc)$
    - 単位元 $0 = (0, \epsilon)$

とするとやはりこれは（冪等）半環になっている.

> $\Re \to \Re^2$; $x \mapsto (x, \epsilon)$ は準同型の包含射.

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

次のような性質がある:

1. $u^\bullet = (\ominus v)^\bullet$
1. $u^\bullet = (u^\bullet)^\bullet$
1. $u (v^\bullet) = (uv)^\bullet$
1. $\ominus (\ominus u) = u$
1. $\ominus (u \oplus v) = (\ominus u) \oplus (\ominus v)$
1. $\ominus (u \otimes v) = (\ominus u) \otimes v$

そしてバランス関係を使って $\Re^2$ の上の同値関係を次で定める.

$u = (u_1,u_2), v = (v_1,v_2) \in \Re^2$ について,
$$u \equiv v \iff u = v \lor ( u \triangledown v \land u_1 \ne u_2 \land v_1 \ne v_2 )$$

これで商集合をとった
$$\S := \Re^2 /\!\! \equiv$$
を対称化 max-plus 代数という.

この商集合 $\S$ には大きく三種類の値しかなくて,

- $[ (w, \epsilon) ] = \{ (w, x) \mid w > x \}$ for each $w \in \R$
- $[ (\epsilon, w) ] = \{ (x, w) \mid x < w \}$ for each $w \in \R$
- $[ (w, w) ] = \{ (w,w) \}$ for each $w \in \Re$

これをそれぞれ, 正数, 負数, バランス数と呼ぶ.
特に $[ (\epsilon, \epsilon) ]$ をゼロと呼ぶ.

標準包含射 $x \mapsto (x,\epsilon)$ を用いて, $\Re$ と $\S$ の正数の部分を同一視する.
$$\Re \simeq \{ (w,\epsilon) \mid w \in \R \}/\!\!\equiv ~~ (\subset \S)$$
マイナス $\ominus$ を取ることで, $(\epsilon, x)$ は $\ominus x$ だと言える.
ただし, $\epsilon = (\epsilon, \epsilon) = \ominus \epsilon$ である.

整理すると, $\S$ にある値は

- 正数
    - $w$ for each $w \in \R$
- 負数
    - $\ominus w$ for each $w \in \R$
- バランス数
    - $w^\bullet$ for each $w \in \Re$
    - この中の $\epsilon^\bullet$ をゼロと言う

という3つに区分される.
そして引き算の結果はこれと対応していて,

- When $a>b$,
    - $a \ominus b = (a,\epsilon) \oplus (\epsilon,b) = (a,b) \equiv (a, \epsilon)$
    - したがって, $a \ominus b = a$
- When $a<b$
    - $a \ominus b = (a,b) \equiv (\epsilon,b)$
    - したがって, $a \ominus b = \ominus b$
- When $a=b$
    - $a \ominus a = a^\bullet$

### バランスの線形性

バランス関係 $\triangledown$ には遷移律こそないが, 良さげな性質がある.

- $u \triangledown u$
- $u \triangledown v \iff v \triangledown u$
- $u \triangledown v \iff (u \ominus v) \triangledown \epsilon$
- $u \triangledown v \land w \triangledown x \implies (u \oplus w) \triangledown (v \oplus x)$
- $u \triangledown v \implies uw \triangledown vw$

### 線形バランス式

- $x \in \Re^n$ に関する線形方程式
    - $A \otimes x \oplus b = C \otimes x \oplus d$
- $x \in \S^n$ に関する **線形バランス式**
    - $(A \ominus C) \otimes x \oplus (b \ominus d) \triangledown \epsilon$
        - ただし $x$ は max 正だとする

この2つの方程式の解集合は一致する.

## 最短経路問題

ここまで $\max$ だったものを $\min$ に置き換えて min-plus 代数 $\Re$ を考える.
$\epsilon$ の扱いは形式上は変わらない（が気持ちは負の無限大だったものを正の無限大に置き換えている）.

エッジに重みのついた有向グラフとは次のようなものである.

- 頂点数を $N$ としたとき, 頂点集合 $V = \{1, 2, \ldots, N\}$
- 辺の集合 $E \subset V \times V \times \mathbb R$

この2つ組 $(V,E)$ をグラフという.
このグラフの隣接行列とは次のようなものである.

- $N \times N$ 行列 $A \in \Re^{N \times N}$ であって,
    - $(A)_{ij} = w$ if $(i,j,w) \in E$
    - $(A)_{ij} = \epsilon$ otherwise

自然数 $m$ について,
$A^{\otimes m}$
は $m-1$ 回, エッジを辿っていけるパスの重みの和の最小値を表す.
$$(A^{\otimes m})_{ij} = \left( i \text{ から } j \text{ まで } m-1 \text{ 回エッジを辿って到達できるならその重みの和の最小値 } \right)$$
到達できないとき, 値には $\epsilon$ が入っている.


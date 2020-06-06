% ルジャンドル変換
% 2019-04-29 (Mon.)
% 最適化

$\def\epi{\mathrm{epi}}\def\dom{\mathrm{dom}}\def\conv{\mathrm{conv}}\def\cl{\mathrm{cl}}$

## 諸定義・抄

### 関数

ここでは $\mathbb R^d \to \mathbb R \cup \{ \infty \}$ なる関数を関数として考える.
ここで $d$ は適当な自然数.

値が有限である領域を, 実効定義域とか有効領域とかいい, $\dom$ で表す.
$$\dom(f) := \{ x \in \mathbb R^d \mid f(x) < \infty \}$$

### エピグラフ, 凸関数

関数 $f$ に対してこれのエピグラフとは次のような図形のことでこれを $\epi(f)$ と書く.
$$\epi(f) := \{ (x, y) \in \mathbb R^{d+1} \mid x \in \mathbb R^d, y \geq f(x) \}$$

関数 $f$ が (下に) 凸関数であることは, $\epi(f)$ が凸集合であることと同値.
$$\forall x_1, x_2 \in \mathbb R^d, \forall t \in [0,1], t f(x_1) + (1-t) f(x_2) \geq f(tx_1+(1-t)x_2)$$
$$\iff$$
$$\forall z_1, z_2 \in \epi(f), \forall t \in [0,1], tz_1+(1-t)z_2 \in \epi(f)$$

明らかに関数とそのエピグラフは一対一対応しているので, しばしば同一視する.

### 閉包, 凸包

集合 $C \in \mathbb R^m$ について,
それを含む最小の閉集合を閉包という.
同様に, それを含む最小の凸集合を凸包という.

関数のエピグラフにこの概念を適用することで, 関数の閉包と凸包を考えることが出来る.
それぞれ $\cl(f), \conv(f)$ と書く (closure, convex hull).
さらに $\cl(\conv(f))$ を閉凸包と言う.

## ルジャンドル変換

$\dom(f) \ne \emptyset$ なる関数 $f$ について,
次のような関数 $f^*$ を $f$ の **共役関数** という.
$$f^* \colon \mathbb R^d \to \mathbb R \cup \{\infty\}$$
$$f^*(y) := \sup_{x \in \mathbb R^d} \left[ \langle x,y \rangle - f(x) \right]$$
ここで $\langle x,y \rangle$ は $x$ と $y$ との内積.
$f$ から $f^*$ を得る操作を **ルジャンドル変換** という.

### 性質

共役関数 $f^*$ は凸関数である.

$\sup$ に関して,
$\sup_x \left[F_1(x) + F_2(x)\right] \leq \sup_x F_1(x) + \sup_x F_2(x)$
である性質から従う.

### 性質

$f^{**}$ ($(f^*)^*$ のこと) は $f$ の閉凸包になっている.
$$f^{**} = \cl(\conv(f))$$

証明...

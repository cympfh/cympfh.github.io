% カーネル法 - 概要
% 2016-09-18 (Sun.)
% 機械学習
% カーネル法によるパターン解析 第3章

## index

<div id=toc></div>

## 特徴空間での線形回帰

### (普通の) 線形回帰

まず普通の線形回帰を考える.
予測関数

$$g(x) = \langle w,x \rangle = \sum_i w_i x_i$$

を用いてパターンは

$$f(x, y; w) = \mathcal{L}(y, g(x)) = |y - g(x)|^2 \approx 0$$

がよく用いられる.
$w$ を行ベクトル、行列 $X$ を列ベクトル $x_1, x_2, \ldots, x_n$ を並べたものとする.

$$\mathcal{L}(y, X; w) = |y - Xw|^2 = (y-Xw)' (y-Xw) ~~(\geq 0)$$

ここで $'$ は行列の転置.
この値は非負であってゼロの場合に $f$ は exact pattern となる.
従って最小化問題を解こうとなる.

$$\frac{\partial \mathcal{L}}{\partial w} = -2X'(y - Xw) = 0$$
$$\iff X'Xw = X'y$$

$(X'X)$ の逆行列が存在するなら

$$w = (X'X)^{-1}X'y$$

が導かれる.
$(X'X)$ はデータ $x$ が $n$ 次元だとすると
$n \times n$ 行列で、逆行列を求めるのが最も高コストで $O(n^3)$.

$(X'X)$ の逆行列が存在するなら

$$w = (X'X)^{-1}y = X' X (X'X)^{-2}y = X' \alpha$$

と書ける.
$X'$ はデータを横に並べたもので、$\alpha$ は実数を縦に並べた列ベクトル.
つまり、この右辺が意味していることは、

$$w = \sum_i \alpha_i x_i$$

ということ.
即ち、超平面 $w$ は結局訓練データの線型結合であるということ.

### リッジ回帰 (Ridge regression)

次を損失関数とする回帰をリッジ回帰という.
ただし $\lambda$ は適当な正実数.

$$\mathcal{L}_\lambda(y,X;w) = \lambda |w|^2 + |y - Xw|^2$$

先ほどと同様にこの最小化をしたいので $w$ で偏微分してゼロなのを解くと

$$\lambda w + X'Xw = X'y.$$

逆行列が存在すれば

$$w = (X'X+\lambda I)^{-1} X'y$$

を導けるが $\lambda > 0$ の時、実はそれはいつも逆行列が存在する.
これもやっぱり次元数 $n$ に関して $O(n^3)$ の計算コスト.

ところで、この $w$ も結局データの線型結合であることは次のようにして確かめられる:

- $\lambda w + X'Xw = X'y$
- $\iff \lambda w = X'(y - Xw)$
- $\iff w = X' (y - Xw) /\lambda = X' \alpha$

$\alpha$ について陽に解く

- $w = (X'X+\lambda I)^{-1} X'y$
- $\iff X'\alpha = (X'X+\lambda I)^{-1} X'y$ (because $w = X'\alpha$)
- $\iff X'y = (X'X+\lambda I) X' \alpha = X' (XX' + \lambda I) \alpha$
- $\Rightarrow \alpha = (XX'+\lambda I)^{-1} y$

また予測は

$$g(x) = \langle w,x \rangle = \langle \sum_i \alpha_i x, x \rangle = \alpha' x = y'(XX' + \lambda I) k$$

ここで $k$ は列ベクトルで $k_i = \langle x_i, x \rangle$.

$G = XX'$ とする.
これはグラム行列 (Gram matrix) と呼ばれ、
ちょうど $G_{i,j} = \langle x_i, x_j \rangle$ となっている.
$G$ の大きさはデータ数 $m$ に対して $m \times m$ 行列.
上の $g$ を計算するコストは 次元数 $n$ とデータ数 $m$ に関して $O(nm)$.

### カーネル拡張

データ $x \in \mathbb{R}^n$ を別な空間 $\phi(x) \in F \subseteq \mathbb{R}^N$ に写す.
この空間でのリッジ回帰は先程の結論の $x$ を $\phi(x)$ に置き換えるだけでよくて

- $g(x) = y' (G+\lambda I)^{-1} k$
- where
    - $G_{i,j} = \langle \phi(x_i), \phi(x_j) \rangle$
    - $k_i = \langle \phi(x_i), \phi(x) \rangle$

次を満たす $\kappa$ をカーネルという:

$$\kappa(x, z) = \langle \phi(x), \phi(z) \rangle.$$

## PCA

PCA は $x \in \mathbb{R}^n$ をより低い次元である
$X'X$ の固有ベクトルが張る $k$ 次元空間に写す.

$X'X$ の固有ベクトルを $v_1, v_2, \ldots, v_k$ とするとき
データ $x$ は

$$\langle x, v_i \rangle_{i=1,2,\ldots,k}$$

に写される.
この内積を $\kappa(x, v_i)$ に置き換えることで特徴空間でのPCAを考えることができる.
これは kernel PCA と言われる.

## クラスタリング (例)

ユークリッド空間上の点集合をユークリッド距離に基づいてクラスタリングすることを考える.

$$|x-z|^2 = \langle x,x \rangle + \langle z,z \rangle - 2 \langle x,z \rangle$$

であることを考えると、ここをカーネルに置き換える拡張が考えられる.

## 集合カーネル (例)

Introduction でも述べたように、$\phi$ によって写した先が実空間 $\mathbb{R}^N$ であれば元は何でも良い.
すなわちカーネル $\kappa$ も、任意のペアを実空間 $\mathbb{R}$ に写しさえすれば何でも良い.
例えば集合に関する $\phi, \kappa$ を設計することができる.

例えば集合 $A_1, A_2 (\subseteq U)$ に関するカーネル

$$\kappa(A_1, A_2) = 2^{|A_1 \cap A_2|}$$

は、積集合 ($A_1 \cap A_2$) の部分集合の数を表す.
これを再現する $\phi$ を作ることはできる.

- $I = \{ D : D \subseteq U \}$ をインデックスとして
- $A \mapsto \phi(A) = \{ D \mapsto \chi(D \subseteq A) : D \in I \}$
    - where
        - $\chi(Prop) = 1$ when $Prop$ holds on
        - $\chi(Prop) = 0$ otherwise

## カーネルのモジュール性

以上見てきたように、多くのパターン解析アルゴリズムがカーネルで拡張できる可能性を持つ.

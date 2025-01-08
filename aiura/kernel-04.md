% カーネル法 - カーネルの特性
% 2016-09-18 (Sun.)
% 機械学習
% カーネル法によるパターン解析 第4章

$$
\def\dim{\mathrm{dim}}
\def\det{\mathop{\mathrm{det}}}
\def\tr{\mathop{\mathrm{tr}}}
$$

## index

<div id=toc></div>

## 内積空間

$\mathbb{R}$ 上のベクトル空間 $X$ が **内積空間 (inner product space)** であるとは

1. $\langle x,z \rangle = \langle z,x \rangle$
1. $\langle x,x \rangle \geq 0$

を満たす二項線形関数 $\langle \cdot, \cdot \rangle: (X, X) \rightarrow \mathbb{R}$ が定められた空間のことで、
この関数を **内積 (inner product)** という.

加えて
$$\langle x,x \rangle = 0 \iff x = 0$$
が成り立つ内積を狭義の内積 (strict inner product) という.

また $x \in X$ のノルムを

$$|x| = \sqrt{\langle x,x \rangle}$$

で定義する.

## ヒルベルト空間

狭義の内積空間であって可分 (separable) かつ完備 (complete) なものヒルベルト空間 $\mathcal{F}$ という.

空間 $\mathcal F$ が完備であるとは、任意のコーシー列 $\{ h_i \in \mathcal{F} : i \in \mathbb{N} \}$ がある値 $h \in \mathcal{F}$ に収束すること.
ここでコーシー列とは
$$\sup_{m \gt n} | h_n - h_m | \rightarrow 0 ~ (n \rightarrow \infty)$$
であった.

また、空間 $\mathcal F$ が可分であるとは、可算な部分集合が稠密であること. すなわち、
$$\forall \epsilon \gt 0, \exists \{h_1,\ldots,h_N,\ldots\} \subset \mathcal{F}, \forall h \in \mathcal{F}, \min_{i=1,\ldots,N} | h_i - h | \lt \epsilon$$
となること.

### 例. $L_2$ 空間

$X$ を次のような実数の可算無限個からなる列の集合とする.

- $x \in X$
- $x = \left(x_1, x_2, \ldots, x_n, \ldots\right)$
    - s.t. $\sum_{i=1}^\infty x_i^2 \lt \infty$

内積を次のように定める:

$$\langle x,y \rangle = \sum_{i=1}^\infty x_i y_i.$$

この空間を $L_2$ 空間という.
これはヒルベルト空間らしい.

### 例. $L_2(X)$ 空間

先の $L_2$ の連続バージョン.
$\mathbb{R}^n$ のコンパクトな部分集合 $X$ について

$$L_2(X) = \left\{ f : \int_X f(x)^2 dx \lt \infty \right\}$$

とする. $L_2(X)$ 上の内積を次で定める.

$$\langle f,g \rangle = \int_X f(x) g(x) dx$$

これもヒルベルト空間.

## コーシー・シュワルツの不等号 (Cauchy-Schwarz inequality)

内積について次が成立する.

$$\langle x,z \rangle^2 \leq |x|^2 |z|^2$$

内積が strict なとき、等号が成り立つのは $x = az$ ($a$ はスカラー) のときに限る.

### 証明

正の微小量 $\epsilon$ を考える.

- $0 \leq | (|z| + \epsilon)~x \pm (|x| + \epsilon)~z |^2$
    - $= \langle \_,~\_ \rangle$
    - $= (|z| + \epsilon)^2~|x|^2 + (|x| + \epsilon)^2~|z|^2 \pm 2 (|x|+\epsilon) (|z| + \epsilon) ~ \langle x, z \rangle$
    - $\leq (|z| + \epsilon)^2 (|x| + \epsilon)^2 + (|x| + \epsilon)^2 (|z| + \epsilon)^2 \pm 2 (|x|+\epsilon) (|z| + \epsilon) ~ \langle x, z \rangle$
    - $= 2 (|z| + \epsilon)^2 (|x| + \epsilon)^2 \pm 2 (|x|+\epsilon) (|z| + \epsilon) ~ \langle x, z \rangle$

$|x| + \epsilon > 0$, $|z| + \epsilon > 0$ だから

$$\mp\langle x,z \rangle \leq (|x| + \epsilon) \cdot (|z| + \epsilon)$$

左辺に関して $\langle x,z \rangle$ または $-\langle x,z \rangle$ のどちらかは非負であることに註意すれば、
両辺自乗して $\epsilon \rightarrow 0$ の極限を取ることで

$$\langle x,z \rangle^2 \leq |x|^2 |z|^2$$

strict なとき、$x=az$ のときにこれが成り立つのは自明.
逆にこれが成り立つとき、今の証明を逆に辿って

- $0 = \left|~ (|z|~x - |x|~z) ~\right|^2$
- $\iff 0 = |z|~x - |x|~z$ (strict)

すなわち
$$x = \frac{|x|}{|z|} z$$
の関係 (rescaling) を得る.
以上から、等号成立と、$x=az$ とが同値であることが示された.

## 偏角

2つのベクトル $x, z$ について偏角 $\theta$ は次で定められる.
ただし内積は strict とする.

$$\cos \theta = \frac{\langle x,z \rangle}{|x|~|z|}$$

偏角が $\cos \theta = 0$ のとき、2つのベクトルは直交するという.

集合 $S = \{x_1, \ldots, x_m\}$ が $X$ 上の **正規直交系 (orthonormal)** であるとは、

$$\forall i, j ~(1 \leq i, j \leq m), \langle x_i, x_j \rangle = \delta_{i,j}$$

とあること.
ここで $\delta_{i,j}$ はクロネッカーのデルタ.

正規直交系 $S$ に関する $z \in X$ のフーリエ級数 (Fourier series) とは

$$\sum_{x \in S} \langle x, z \rangle x$$

のこと. この値が $z$ と常に等しくなるような $S$ を **基底 (basis)** とも言う.


行列 $X \in \mathbb{R}^{n \times m}$ の **rank** とは、列ベクトルが張る空間の次元のこと.
rank が今 $r$ だとすると、行列 $T \in \mathbb{R}^{n \times r}$, $S \in \mathbb{R}^{r \times m}$ を用いて
$X = TS$ とできる.
ただし $T$ の列ベクトルは線形独立.
註意すべき点としては列ベクトルに注目する代わりに行ベクトルで考えても rank $r$ は変わらないこと.
即ち転置 $X'$ のrankは $X$ に等しい.
また、$r = \min(n,m)$ のとき、$X$ は full rank であるという.

## グラム行列

あるベクトルの集合 $S = \{ x_1, \ldots, x_\ell \}$ の **グラム行列** $G$ とは
$\ell \times \ell$ 行列であって
$$G_{i,j} = \langle x_i, x_j \rangle$$
のこと.
$x \in X$ を特徴空間に写す $\phi$ に対応するようなカーネル関数 $\kappa$ を考慮するとき、これに関するグラム行列 $G$ とは
$$G_{i,j} = \kappa(x_i, x_j)$$
だと再定義する.
グラム行列が対称行列 ($G_{i,j} = G_{j,i}$) であることは自明.

### 特異行列

行列 $A$ が **特異 (singular)** であるとは、$A$ の行ベクトルの非自明な線型結合で $0$ にできること.
すなわち $0$ でない列ベクトル $x$ を右から掛けて
$$Ax=0$$
とできること.

行列 $A$ が **正則 (non-singular)** のとき、なんやかんやあって $A$ の逆行列 $A^{-1}$ が存在する.

### 固有値

行列 $A$ について、$Av=\lambda v$ を満たす実数 $\lambda$ を固有値 (eigenvalue)、列ベクトル $v$ を固有ベクトル (eigenvector) という.
行ベクトルを左から掛けた $v' v$ が実数であることに註意すると

$$\frac{v'Av}{v'v} = \frac{\lambda v'v}{v'v} = \lambda.$$

この値を **レイリー商 (Rayleigh quotient)** という.
この式からも固有値は固有ベクトルのスカラー倍に関して普遍であることは自明なので、これ以降、固有ベクトルの大きさは $|v| = 1$ だとする.

行列 $A$ を対称行列とする. すなわち $A' = A$ だとする.
$A$ の2つの固有値 $\lambda_1$, $\lambda_2$ と、それぞれに対応する固有ベクトル $v_1$, $v_2$ があるとするとき、

$$\begin{align*}
\lambda_1 \langle v_1, v_2 \rangle
& = (\lambda_1 v_1)' \cdot v_2 \\
& = (A v_1)' \cdot v_2 \\
& = v_1' A' v_2\\
& = v_1' A v_2\\
& = v_1' (\lambda_2 v_2)\\
& = \lambda_2 \langle v_1, v_2 \rangle
\end{align*}$$

従って $\lambda_1 \ne \lambda_2 \implies \langle v_1, v_2 \rangle = 0$ を得る.
即ち、対称行列の異なる2つの固有ベクトルはいつも直交する.
このことは、$n \times n$ 行列の相異なる固有ベクトルは高々 $n$ 個だということも示す.

行列 $A$ の一つの固有ベクトル $v$ と対応する固有値 $\lambda$ を以って

$$A \mapsto \tilde{A} = A - \lambda v v'$$

という操作を **deflation** という.
$\tilde{A}v=Av-\lambda v'vv=0$ より、$v$ は $\tilde{A}$ の固有ベクトルではなくなった.
$A$ が full rank であったとしても $\tilde{A}$ は線形従属な列ベクトルを持つので確実に full rank ではなくなった.
一方で$A$ の他の固有ベクトル $v_2$ は尚も $\tilde{A}$ の固有ベクトルである.
なぜなら $\tilde{A}v_2 = Av_2 - \lambda v \langle v, v_2 \rangle = Av_2$ だから.

非決定的にただひとつ固有ベクトルを探すアルゴリズムがあるとき、deflation という操作を繰り返すことで、全ての固有ベクトルを列挙することが可能.

対称行列 $A \in \mathbb{R}^{n \times n}$ が full rank で $n$ 個の固有ベクトルを持つとする.
固有ベクトル (列) を並べた行列 $V$ を以って

$$AV = V\Lambda$$

と書ける. $\Lambda$ は対角成分に固有値を並べたものになる.
対称行列なら固有ベクトルが互いに直交するから
$V' = V^{-1}$
なので

$$A = V\Lambda V'$$

$A$ をこの形に記述することを固有値分解という.
$A$ の逆行列は次のように容易に求められる:

$$A^{-1} = V' \Lambda^{-1} V$$

これは $A$ の逆行列が存在することをも示す.

あと $A$ の固有ベクトル $v_i$、固有値 $\lambda_i$ に対して、
$A^2$ の固有ベクトルは $v_i$ 固有値 $\lambda_i^2$ なのはすぐ確かめられて

$$A^2 = V \Lambda^2 V'.$$

### Thm. Courant-Fisher 定理

対称行列 $A \in \mathbb{R}^{n \times n}$ の固有値を大きい順に
$\lambda_1, \lambda_2, \ldots, \lambda_n$
とする.
$k$ 番目の固有値は次のように求まる.

$$\begin{align*}
\lambda_k
& = \max_{\dim(T)=k~} ~ \min_{v \in T, v \ne 0} \frac{v'Av}{v'v} \\
& = \min_{\dim(T)=n-k+1~} ~ \max_{v \in T, v \ne 0} \frac{v'Av}{v'v} \\
\end{align*}$$

### 半正定値行列 (positive semi-definite matrices)

対称行列 $A \in \mathbb{R}^{n \times n}$ が **半正定値行列** であるとは、
全ての固有値が非負であること.
これは、Courant-Fisher 定理を用いると、任意のベクトル $v$ に対して

$$v' A v \geq 0$$

が成り立つことと同値.

同様に、正定値行列であるとは、全ての固有値が正であること. すなわち
任意のベクトル $v$ に対して

$$v' A v > 0$$

が成り立つこと.

### Prop 3.7

グラム行列は半正定値行列.

#### 証明

$$\begin{align*}
v'Gv
& = \sum_i \sum_j v_i v_j G_{i,j} \\
& = \sum_i \sum_j v_i v_j \langle \phi(x_i), \phi(x_j) \rangle \\
& = \langle \sum_i v_i \phi(x_i), \sum_j v_j \phi(x_j) \rangle \\
& \geq 0 \\
\end{align*}$$

### Prop 3.8

行列 $A$ が半正定値行列であることは、ある実行列$B$ が存在して $A=B'B$ と書けることと同値.

#### 証明
$A=B'B$ を仮定したとき、
任意のベクトル $v$ を以って
$v'Av = v'B'Bv = |Bv|^2 \geq 0$
なので $A$ は半正定値.

$A$ が半正定値行列のとき、
固有値分解して $AV = V\Lambda$ と書いて $B = \sqrt{\Lambda} V'$ とすれば $A=B'B$ を得る.
ここで対角行列 $\Lambda$ に対して $\sqrt{\Lambda}$ は対角成分の $\sqrt{\_}$ を取るもので、今、固有値は $\geq 0$ を仮定してるので.

行列 $A$ を $A = B'B$ に書きなおすような分解を考える.
これを満たす $B$ は一般に一意ではない.
上三角行列 $R$ を以って $A = R' R$ と書くのを Cholesky 分解という.

### Prop 3.9

(半) 正定値行列 $A$ iff $A$ の任意の主小行列 (principal minor) は (半) 正定値行列.

#### 証明

$A \in R^{n \times n}$ についてその主小行列 $M \in R^{m \times m}$ とは、$1 \leq k_1 \lt k_2 \lt \ldots \lt k_m \leq n$ を選んで
$M_{i,j} = A_{k_i, k_j}$.

証明はほとんど自明.
($\Rightarrow$)
$u'Mu$ について、ベクトル $u$ に適切にゼロを挿入して出来る $v$ を用いて、 $u'Mu = v'Av$.
$v'Av \geq 0$ より $u'Mu \geq 0$.

($\Leftarrow$)
右矢印が成り立つなら、 $A$ 自体が $A$ の主小行列であることから明らか.

### 行列式とトレース

正方行列 $A$ の **行列式 (determinant)** $\det(A)$ とは $A$ の固有値の積であると定義する.
従って正定値の行列式は必ず正となる.
また特異行列の行列式はゼロになる.

また、定義から頑張れば次が導ける:

$$\det(AB) = \det(A) \det(B).$$

$A$ の対角成分の和を **トレース (trace)** $\tr(A)$ という.

$$\tr(A) = \sum_i A_{i,i}$$

自明に次が成立:
$$\tr(AB) = \tr(BA).$$

これを用いると
$\tr(V^{-1}AV) = \tr((AV) V^{-1}) = \tr(AI) = \tr(A)$
が分かる.

### Def 3.10

二項関数 $\kappa: X \times X \rightarrow \mathbb{R}$ が **有限半正定値関数 (finitely positive semi-definite)** であるとは、
任意の有限集合 $X' \subseteq X$ を以って、$(A)_{x, y} = \kappa(x, y)$ ($x, y \in X'$) が半正定値行列であること.

### Thm 3.11

ある関数 $\kappa: X \times X \rightarrow \mathbb{R}$ が連続である、またはドメインが有限であるとする.
この関数が$X$ をヒルベルト空間 $F$ に写すような写像 $\phi$ によって
$$\kappa(x,z) = \langle \phi(x), \phi(z) \rangle$$
と分解できることの必要十分条件は、 $\kappa$ が有限半正定値関数であること.

カーネル関数 $\kappa$ と (可算無限以下の) 集合 $X$ を以って、次の関数空間を考える:

$$\mathcal{F} = \left\{ \sum_{i=1}^\ell \alpha_i \kappa(x_i, \cdot) : \ell \in \mathbb{N}, x_i \in X, \alpha_i \in \mathbb{R} \right\}$$

例えば、線形分類器の学習とは、学習データ $X$ に就いて適切な $\kappa$ を選んで出来る $\mathcal{F}$ から適切な関数を一つ選択する作業にほかならない.

$\mathcal{F}$ は自明にベクトル空間である.
すなわち、 $f \in \mathcal{F} \Rightarrow \beta f \in \mathcal{F}$ や
$f, g \in \mathcal{F} \Rightarrow f + g \in \mathcal{F}$ が成立する.

この空間に内積を定める.

- $f(x) = \sum_{i=1}^\ell \alpha_i \kappa(x_i, x) \in \mathcal{F}$
- $g(x) = \sum_{j=1}^n \beta_j \kappa(z_j, x) \in \mathcal{F}$

に対して

$$\langle f, g \rangle \equiv \sum_{i=1}^\ell \sum_{j=1}^n \alpha_i \beta_j \kappa(x_i, z_j)
= \sum_{i=1}^\ell \alpha_i g(x_i)
= \sum_{j=1}^n \beta_j f(z_j)$$

これは内積の公理を満たしている.


$g = \kappa(x, \cdot)$ との内積を考えると
$\langle f, g \rangle = \sum_i^\ell \alpha_i \kappa(x, x_i) = f(x)$
を得る.
この性質を reproducing property という.

関数のコーシー列 $(f_n)_{n=1}^\infty$ を考える.
先ほどの reproducing producty 及び内積の線形性を用いると次を得る.

$$(f_n(x) - f_m(x))^2 = \left\langle f_n - f_m, \kappa(x, \cdot) \right\rangle^2$$

さらにコーシー・シュワルツの不等式は次を言う.

$$\left\langle f_n - f_m, \kappa(x, \cdot) \right\rangle^2 \leq \| f_n - f_m \|^2 \kappa(x, x)$$

というわけで任意の $x$ について $f(x)$ 自体もある値に収束することが分かる.

$x$ を先ほど言ったような関数に写す (高階) 関数
$\phi(x) = \kappa(x, \cdot)$
を用いると、先程書いたのは改めて

$$\langle f, \phi(x) \rangle = \langle f, \kappa(x, \cdot) \rangle = f(x)$$

と書き直せる.

内積が strict で、今 $\| f \|^2 = \langle f, f \rangle = 0$ なとき、
$f(x) = \left\langle f, \phi(x) \right\rangle \leq \|f\| \|\phi(x)\| = 0$
ゆえに、任意の $x$ について $f(x) \leq 0$ を得る.

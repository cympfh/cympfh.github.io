% 坪井 多様体 &sect;8 - 多様体の上のベクトル場
% 2017-09-30 (Sat.)
% 幾何学 微分幾何

## index

<div id=toc></div>
$\def\Ker{\mathrm{Ker}}\def\grad{\mathrm{grad}}$

## ベクトル、ベクトル場に沿う偏微分

多様体 $M$ の上の実関数 $f : M \to \mathbb{R}$ とあるベクトル
$X \in T_xM$
があり、
$X$ を成分表示すると
$X = \sum_i \xi_i \frac{\partial}{\partial x_i}$
であるとき、
$f$ の (点 $x$ での) $X$ での微分を
$$Xf \equiv \sum_i \xi_i \frac{\partial f}{\partial x_i}$$
と定める.

同様に、ベクトル場 $X(x)$ での微分を
$X(x) = \sum_i \xi_i(x) \frac{\partial}{\partial x_i}$
に対して
$$Xf \equiv \sum_i \xi_i(x) \frac{\partial f}{\partial x_i}$$
で定める.

個々の値は座標のとり方で変わるが、全体 ($Xf$) は変わらないことに註意.

### 定理

$Xf$ に就いて、次が成立する.
<div class=thm>
$$\frac{d}{dt} f(F_t(x)) = Xf(F_t(x))$$
</div>

右辺に定義の式を代入することで確認する.
$y=F_t(x)$
とおくと、
$$\begin{align*}
X(y)
& = \left( \frac{dF_t}{dt} \circ F_t^{-1} \right) (y) \\
& = \frac{dF_t}{dt} \left( F_t^{-1}(y) \right) \\
& = \sum_i \left( \frac{dF_t}{dt} \left( F_t^{-1}(y) \right) \right)_{.i} \frac{\partial}{\partial y_i} \\
& = \sum_i \left( \frac{dF_t}{dt} (x) \right)_{.i} \frac{\partial}{\partial y_i}
\end{align*}$$
ここで $\_.i$ はタプルの第 $i$ 成分への射影関数.

とベクトルは表現されるので、これに対して
$$\begin{align*}
Xf(y)
& = \sum_i \left( \frac{dF_t}{dt} (x) \right)_{.i} \frac{\partial f}{\partial y_i}(y) \\
& = \sum_i \left( \frac{d y_i}{dt} \right) \frac{\partial f}{\partial y_i}(y) \\
& = \frac{d f(y)}{dt} \\
& = \frac{d f(F_t(x))}{dt}
\end{align*}$$

と確認できた.
この定理を座標を決めない場合の $Xf$ の定義とする.

### 問 8.1.2

コンパクト多様体の上のベクトル場 $X$ と実関数 $f$ について
$Xf=f$
が成り立っているとする.

まず、コンパクト性故 $f(X) \subset \mathbb{R}$ もまたコンパクトであるが、
実空間のコンパクト部分集合は有界である.
すなわち、最小元と最大元を持つ.

次に $Xf=f$ について調べる.
これもコンパクト性故 $X$ によって生成されるフロー $F_t$ が存在する.
点 $x=F_t(y)$ について、
$$\begin{align*}
f(F_t(y))
& = Xf(F_t(y)) \tag{仮定より} \\
& = \frac{d}{dt}f(F_t(y)) \tag{定理}
\end{align*}$$

今、点 $y$ を固定して $f(F_t(y))$ を $t$ の関数 $g(t)$ とみなせば、
$$g(t) = \frac{d}{dt}g(t)$$
を得たことになる.
この微分方程式を解けば
$$g(t) = A \exp(t)$$
ちなみに初期値は $g(0)=f(F_0(y))=f(y)$.
以上から
$$f(F_t(y)) = f(y) \exp(t)$$
を得る.
ところで $t$ は $\mathbb{R}$ 全体を取り得るが、このままだと
$f(F_t(y))$
の取り得る値の範囲は $f(y)>0$ なら $(0,\infty)$ となる.
これは先程の $f$ は最大元を持つという事実と反する.
同様に最小限を持つ事実も考慮すると、結局
$f(y)=0$
である必要があり、
$$f(F_t(y)) = 0$$
が言える.

任意の $y$ について同じことが言えるので結局
$$f(x)=0$$
が言える.

## フローとベクトル場

普通の偏微分
$\frac{\partial}{\partial x_i}$, $\frac{\partial}{\partial x_j}$
は可換で、
$\frac{\partial^2 f}{\partial x_i \partial x_j} = \frac{\partial^2 f}{\partial x_j \partial x_i}$
が一般に成立する.
先程見たベクトル場に沿う偏微分について同じことは言えるだろうか.
すなわち、
$$X(Yf) =^? Y(Xf)$$
だろうか.

### ブラケット積

$M$ 上の2つのベクトル場 $X,Y$ がそれぞれ $F_t, G_s$ というフローを生成するとする.
$(F_t)_*$ は単に $TM\to TM$ の接写像だが、
次のようなベクトル場への作用
$$(F_t)_*Y : M \to TM$$
$$x \mapsto (F_t)_* ( Y( F_{-t}(x) ))$$
を定める.
すなわち、
$$((F_t)_* Y)(x) = (F_t)_*(Y(F_{-t}(x))).$$
$t$ を $-t$ に置き換えて、
$$((F_{-t})_* Y)(x) = (F_{-t})_*(Y(F_t(x))).$$
右辺をよく見るとこのベクトルは $x$ から生えているので
$\in T_xM$
である.

適当な座標を与えて、

- $X(x) = \sum_i X_i(x) \frac{\partial}{\partial x_i}$
- $Y(x) = \sum_i Y_i(x) \frac{\partial}{\partial x_i}$
- $F_t = (x_1^t, \ldots, x_m^t)$
    - $x_i^t : \mathbb{R}^m \to \mathbb{R}$

と書き直す.

$$\begin{align*}
((F_{-t})_* Y)(x)
& = (F_{-t})_*(Y(F_t(x))) \tag{先の式} \\
& = (F_{-t})_* \sum_i \left( Y_i(F_t(x)) \frac{\partial}{\partial x_i} \right) \tag{$Y$ の座標表示} \\
& = \sum_i \left( Y_i(F_t(x)) (F_{-t})_*\left(\frac{\partial}{\partial x_i} \right)\right) \tag{ベクトル線形性} \\
& = \sum_i Y_i(F_t(x)) \sum_j \left(D(F_{-t})\right)_{i,j} \frac{\partial}{\partial x_j} \tag{ヤコビアン行列} \\
& = \sum_i Y_i(F_t(x)) \sum_j \frac{\partial x_j^{-t}}{\partial x_i} \frac{\partial}{\partial x_j} \\
& = \sum_{i,j} Y_i(F_t(x)) \frac{\partial x_j^{-t}}{\partial x_i} \frac{\partial}{\partial x_j}
\end{align*}$$

$x$ を固定して、$t$ で微分する

$$\begin{align*}
\frac{d}{dt} ((F_{-t})_* Y)(x)
& = \sum_{i,j} \left[
\frac{d}{dt} Y_i(F_t(x)) \frac{\partial x_j^{-t}}{\partial x_i} \frac{\partial}{\partial x_j}
+
Y_i(F_t(x)) \frac{d}{dt}\frac{\partial x_j^{-t}}{\partial x_i} \frac{\partial}{\partial x_j}
\right] \\
& = \sum_{i,j} \left[
\sum_k \frac{\partial Y_i}{\partial x_k} \frac{\partial x_k^t}{\partial t} \frac{\partial x^{-t}_j}{\partial x_i} \frac{\partial}{\partial x_j}
+
Y_i(F_t(x)) \frac{\partial}{\partial x_i} \frac{\partial x_j^{-t}}{\partial t} \frac{\partial}{\partial x_j}
\right] \\
\end{align*}$$

$\frac{\partial x_j^{-t}}{\partial t}$
について.
$F_t$ は $X$ のフローなので、
$X = \frac{\partial F_t}{\partial t} \circ F_{-t}$
(生成するフローの定義).
逆向きのフローを考えれば ($F_t \mapsto F_{-t}$)、
$-X = \frac{\partial F_{-t}}{\partial t} \circ F_{t}$.
$-X \circ F_{-t} = \frac{\partial F_{-t}}{\partial t}$.
$j$ 番目の成分だけ取って
$-X_j \circ F_{-t} = \frac{\partial x^{-t}_j}{\partial t}$.

これを用いて、

$$\frac{d}{dt} ((F_{-t})_* Y)(x) =
\sum_j\left[
\sum_{i,k}
\frac{\partial Y_i}{\partial x_k} \frac{\partial x_k^t}{\partial t}
\frac{\partial x^{-t}_j}{\partial x_i}
-
\sum_i
Y_i(F_t(x)) \frac{\partial}{\partial x_i}(X_j(F_{-t}(x)))
\right]\frac{\partial}{\partial x_j}$$

この $t=0$ での微分値を考える.
$$\left.\frac{\partial x^t_k}{\partial t} \right|_{t=0}=X_j$$
$$\left. F_t(x) \right|_{t=0}=x,
\left. F_{-t}(x) \right|_{t=0}=x$$
なので

$$\begin{align*}
\left.\frac{d}{dt}\right|_{t=0} ((F_{-t})_* Y)(x)
&=
\sum_j\left[
\sum_{i,k}
\frac{\partial Y_i}{\partial x_k} X_k(x)
\delta_{i,j}
-
\sum_i Y_i(x) \frac{\partial X_j}{\partial x_i}
\right]\frac{\partial}{\partial x_j}
\\
&=
\sum_j\left[
\sum_k
\frac{\partial Y_j}{\partial x_k} X_k(x)
-
\sum_i Y_i(x) \frac{\partial X_j}{\partial x_i}
\right]\frac{\partial}{\partial x_j}
\\
\end{align*}$$

この値を $\left[X,Y\right]$ と書いて、
$X,Y$
のブラケット積 (括弧積) と呼ぶ.

<div class=thm>
#### 定義
2つのベクトル場 $X,Y$ の **ブラケット積** とは
$X$ が生成するフローを $F_t$ とするとき、
$$\begin{align*}
\left[ X,Y \right]
& \equiv
\left.\frac{d}{dt}\right|_{t=0} ((F_{-t})_* Y)(x) \\
& =
\sum_j\left[
\sum_k \frac{\partial Y_j}{\partial x_k} X_k(x)
- \sum_i Y_i(x) \frac{\partial X_j}{\partial x_i}
\right]\frac{\partial}{\partial x_j}
\end{align*}$$
</div>

ブラケット積もまたベクトル場になっている.

<div class=thm>
#### 諸性質
- 交代性: $\left[ X,Y \right] = - \left[ Y,X \right]$
- 線形性: $\left[ kX,Y\right] = k\left[ X,Y \right]$

これらは定義から容易にわかる.
</div>

関数 $f: M \to \mathbb{R}$ に対して $M$ 上のベクトル場 $X$ で
$$Xf : M \to \mathbb{R}$$
が定まることは前の章で述べた.

<div class=thm>
#### 定理
$$\left[X,Y\right]f = X(Yf) - Y(Xf)$$

これは正に初めに述べた、
ベクトル場に沿った微分の可換性についての答えになっている.

#### 証明
ほぼほぼ、定義のまま.

$$\begin{align*}
\left[X,Y\right]f
& =
\sum_j\left[
\sum_k \frac{\partial Y_j}{\partial x_k} X_k
- \sum_i Y_i \frac{\partial X_j}{\partial x_i}
\right]\frac{\partial f}{\partial x_j} \\
& =
\sum_k X_k \frac{\partial}{\partial x_k} (Yf)
- \sum_i Y_i \frac{\partial}{\partial x_i} (Xf) \\
& =
X(Yf)-Y(Xf)
\end{align*}$$
</div>

<div class=thm>
#### ヤコビ恒等式:
$$\left[\left[ X,Y \right], Z \right] +\left[\left[ Y,Z \right], X \right] +\left[\left[ Z,X \right], Y \right]=0$$

#### 証明
ベクトル場 $K$ がゼロであることを示すのに、一般の関数 $f$ に対して
$$Kf=0$$
であるのを示せばよい.
直前の定理を用いて
$$\left[\left[ X,Y \right], Z \right]f+\left[\left[ Y,Z \right], X \right]f+\left[\left[ Z,X \right], Y \right]f = 0$$
を言えばよい.
式展開するだけなので略.
</div>

### 例

多様体 $M=\mathbb{R}^2$ の上の2つのベクトル場
$X=\frac{\partial}{\partial x_1}$,
$Y=x_1 \frac{\partial}{\partial x_2}$
を考える.
2つが生成するフローはそれぞれ

- by $X$
    - $F_t(x_1, x_2) = (x_1 + t, x_2)$
- by $Y$
    - $G_s(x_1, x_2) = (x_1, x_2 + x_1s)$

ブラケット積を定義どおり素朴に算出してみる.
$$\begin{align*}
Y(F_t(x)) & = Y(x_1+t, x_2) \\
          & = (x_1+t) \frac{\partial}{\partial x_2} \\
(F_{-t})_* (Y(F_t(x))) & = (x_1+t) \frac{\partial}{\partial x_2} \\
\left.\frac{d}{dt}\right|_{t=0} & = \frac{\partial}{\partial x_2}
\end{align*}$$
というわけで
$X,Y = \frac{\partial}{\partial x_2}$
が確認できた.

次に交代した
$[Y,X]$
を今度も定義から素朴に計算してみる.

$$\begin{align*}
X(G_s(x)) & = \frac{\partial}{\partial x_1} \\
(G_{-s})_* (X(G_s(x))) & =
    \left[\begin{array}{cc} 1 & 0 \\ -s & 1 \end{array}\right]
    \left[\begin{array}{c} 1 \\ 0 \end{array}\right] \\
    & =
    \left[\begin{array}{c} 1 \\ -s \end{array}\right] \\
    & =
    \frac{\partial}{\partial x_1} -s \frac{\partial}{\partial x_2} \\
\left.\frac{d}{dt}\right|_{t=0}
    & = -\frac{\partial}{\partial x_2}
\end{align*}$$
というわけで確かに
$[Y,X] = - [X,Y]$
であることが確認できた.

## 例題 8.2.6

Lie群 $G$ について.

### (1)

$G$ 上の左不変ベクトル場とは、
$$\forall g \in G, (L_g)_* \xi = \xi$$
なる $\xi$ である.
ただしここで
$L_g$ とは $L_g(h)=gh : G \to G$ なる関数のことであった.

また、接写像のベクトル場への作用とは、次のようなものであった.
$$\color{red}{((L_g)_* \xi)} \left( L_g(h) \right) \equiv (L_g)_* \left( \xi(h) \right)$$
この $\xi$ が左不変ベクトル場であるとき、
$$\begin{align*}
(L_g)_* \left( \xi(h) \right)
& = \color{red}{((L_g)_* \xi)} \left( L_g(h) \right) \\
& = \xi (L_g(h)) \\
& = \xi(gh)
\end{align*}$$

ここで $h$ に単位元 $1\in G$ を代入することで
$$\xi(g) = (L_g)_* (\xi(1)) \tag{1.1}$$
を得る.
ここで右辺を見ると、$\xi$ に依存して存在する値は
$\xi(1)$
のみであるから、
結局、任意の $\xi(g)$ の値は $\xi(1)$ だけに依存して決定する.

すなわち、
この等式 (1.1) によって、
左不変ベクトル場について、
$\xi \mapsto \xi(1)$
という写像が単射であることが言える.

逆に、等式 (1.1) によって、$\xi(1)$ の値と $L_g$ で、ベクトル場 $\xi$ を構成することが出来る.
そしてそうやって構成したベクトル場は左不変である.

$$\begin{align*}
\color{red}{((L_g)_* \xi)} \left( L_g(h) \right)
& = (L_g)_* \left( \xi(h) \right) \\
& = (L_g)_* \left( (L_h)_* \xi(1) \right) \\
& = (L_{gh})_* \left( \xi(1) \right) \\
& = \xi(gh) \\
& = \xi(L_g(h)) \\
\end{align*}$$

これが任意の $L_g(h) (=gh)$ の値に対して成り立つので
$(L_g)_* \xi = \xi$
が成り立つ.
即ち $\xi$ は左不変である.

このような左不変ベクトル場全体を
Lie 環 (或いは Lie 代数) $\mathfrak{g}$ という.

左不変ベクトル場は今見てきたように、$1 \in G$ でのベクトルで決まるから、
$\mathfrak{g}$ は $T_1G$ と同型であることが分かる.

<div class=thm>
#### Remark
$$\mathrm{dim}~\mathfrak{g} = \mathrm{dim}~G$$
</div>

### Thm

左不変ベクトル場 $\xi$ が生成するフローを $\varphi_t$ とする.
このとき、
$L_g \circ \varphi_t \circ L_g^{-1}$
というフローは実は $\varphi_t$ と一致する.
これを確認するため、逆にこれを生成するベクトル場を算出する.

$$\begin{align*}
\left( \left. \frac{d}{dt} \right|_{t=0} L_g \circ \varphi_t \circ L_g^{-1} \right)
\left( L_g \circ \varphi_t \circ L_g^{-1} \right)^{-1} (h)
& =
\left( \left. \frac{d}{dt} \right|_{t=0} L_g \circ \varphi_t \circ L_g^{-1} \right)
\left( L_g \circ \varphi_t^{-1} \circ L_g^{-1} \right) (h) \\
& =
\left( \left. \frac{d}{dt} \right|_{t=0} L_g \circ \varphi_t \right)
\varphi_t^{-1}(g^{-1}h) \\
& =
(L_g)_* \frac{d \varphi_t}{dt}
\varphi_t^{-1}(g^{-1}h)
\tag{接射像の定義} \\
& =
(L_g)_* \left( \xi (g^{-1}h) \right)
\tag{フローの生成} \\
& =
\xi(h) \tag{左不変性} \\
\end{align*}$$

一番最後のは、
$\xi(h) = ((L_g)_* \xi)(h) = (L_g)_* (\xi (L_g^{-1}(h)))$
を用いた.

というわけで、
2つのフロー $\varphi_t$ と $L_g \circ \varphi_t \circ L_g^{-1}$ を生成するベクトル場はどちらも $\xi$ である.
従って２つは一致する.

<div class=thm>
$$L_g \circ \varphi_t \circ L_g^{-1} = \varphi_t \tag{$\ast$}$$
</div>

### (2)

2つの左不変ベクトル場
$\xi, \eta \in \mathfrak{g}$
が生成するフローをそれぞれ
$\varphi_t, \psi_t$
とする.
ブラケット積 $[\xi, \eta]$ を考える.

$$\begin{align*}
[\xi, \eta]
& = \left.\frac{d}{dt}\right|_{t=0} \left( (\varphi_{-t})_* \eta \right) \\
(L_g)_* [\xi, \eta]
& = (L_g)_* \left.\frac{d}{dt}\right|_{t=0} \left( (\varphi_{-t})_* \eta \right) \\
& = \left.\frac{d}{dt}\right|_{t=0} (L_g)_* \left( (\varphi_{-t})_* \eta \right) \tag{$(L_g)_*$ は $t$ に依存しないので} \\
\end{align*}$$

定理 (*) より
$L_g \circ \varphi_{-t} = \varphi_{-t} \circ L_g$
で、これを微分して接写像にした版
$(L_g)_* \circ (\varphi_{-t})_* = (\varphi_{-t})_* \circ (L_g)_*$
も得られる.
これを使うと

$$\begin{align*}
(L_g)_* [\xi, \eta]
& = \left.\frac{d}{dt}\right|_{t=0} (\varphi_{-t})_* ((L_g)_* \eta) \\
& = [\xi, (L_g)_* \eta]
\end{align*}$$

を得る.
次に $\eta$ の左不変性から
$(L_g)_* \eta=\eta$
を代入し、結局次を得る.

<div class=thm>
$$(L_g)_* [\xi, \eta] = [\xi, \eta]$$
</div>

次のように言い換えられる.

<div class=thm>
#### Thm
2つの左不変ベクトル場のブラケット積もまた、左不変ベクトル場である.
</div>

### (3)

定理 (*) は
$$L_g \circ \varphi_t \circ L_g^{-1} = \varphi_t \tag{$\ast$}$$
というものだった.
両辺を $g$ に適用すると
$$g \varphi_t(1) = \varphi_t(g)$$
を得る.

従ってフロー $\varphi_t$ という値は $\varphi_t(1)$ だけ決めれば決まる.
($g$ を左から掛けるという操作はベクトル場には依存しないので.)

$\varphi_t(1)$ を $\exp(t\xi)$ と書いて **指数関数** と呼ぶ.

ベクトル場をスカラー倍するのと、フローの時刻パラメータをスカラー倍するのは一致するので.

### (4)

$\exp$ はベクトル場をフローの値、すなわち点に写す.
$$\exp : \mathfrak{g} \to G$$
また $\exp(0) = id(1)=1$ であるので、その周りでは接写像
$$T\exp : T_0\mathfrak{g} \to T_1G$$
がある.

$$T_1G \cong^{(1)} \mathfrak{g} \cong T_0\mathfrak{g} \to T_1G$$

実際に $T\exp$ を計算してみる.
(1) で示したように、左不変ベクトル場は $\xi(1)$ での値さえ決めればよかった.
すなわち、
あるベクトル $v \in T_1G$ を選んで
$\xi(g) = (L_g)_* v$
によってベクトル場 $\xi \in \mathfrak{g}$ が構成できるのだった.

$T_0\mathfrak{g}$ におけるベクトル $xi$ に対応する曲線は、
$c(t)=t\xi$
である
($\frac{dc}{dt}(0)=\xi$).
これを $\exp$ で写して得る曲線が
$\exp(c(t)) = \exp(t\xi) = \varphi_t(1)$.
この曲線に対応するベクトルは、$t=0$ での微分値であって
$\left. \frac{d}{dt} \varphi_t(1) \right|_{t=0} = \xi(1)=v$.

以上から、$T\exp(\xi) = v$ が分かった.
結局、$\xi$ を $\xi(1)$ に写している.

<div class=thm>
$\exp$ は $0 \in \mathfrak{g}$ の近傍を $1 \in G$ の近傍に写す微分同相写像.
</div>

## 行列群の計量

正規行列の集合
$G = \mathrm{GL}(n;\mathbb{R})$
は、
$n^2$ 次元ユークリッド空間の開部分集合なので簡単に多様体であるが、
ここに適当なリーマン計量を入れてみる.

曲線 $c(t) \in G$, ベクトル $dc/dt (\in G)$ (実数の微分なので) に対して
$$q\left( \frac{dc}{dt} \right) \equiv
\mathrm{tr}\left[
\left( c^{-1} \frac{dc}{dt} \right)^\top
\left( c^{-1} \frac{dc}{dt} \right)
\right]$$
によってリーマン計量 $q$ を与える.
ここで
$\mathrm{tr}\left[ - \right]$ は行列のトレース、
$-^\top$ は転置.

転置を分解すると
$$q\left( \frac{dc}{dt} \right) \equiv
\mathrm{tr}\left[
\frac{dc}{dt}^\top (c^{-1})^\top c^{-1} \frac{dc}{dt}
\right]$$
であるが、ここで $c(t) = 1 \in G$ のところを考えると、
これは
$\mathrm{tr}\left[
\frac{dc}{dt}^\top \frac{dc}{dt}
\right]
= \sum_i \left( \frac{dc_i}{dt} \right)^2$
となり、普通のユークリッド空間での計量と一致する.

さてこの計量での測地線を考える.
定義から追って計算する.

$c(0)=1, c(1)=A$ なる曲線 $c$ に任意の曲線 $\epsilon$ を僅かに加える変分法を行う.
すなわち、
$$0 = \left.\frac{d}{ds}\right|_{s=0}
\int_0^1 dt~~
\mathrm{tr}\left[
\frac{d(c+s\epsilon)}{dt}^\top ((c+s\epsilon)^{-1})^\top (c+s\epsilon)^{-1} \frac{d(c+s\epsilon)}{dt}
\right]$$
を解く.
$s$ での微分と $t$ での積分とを交換して、$\mathrm{tr}$ の中身を先に $s$ で微分する.

注意深く解くと
$$-\frac{d}{dt} \left[ (c^{-1})^\top c^{-1} \frac{dc}{dt} \right]
-(c^{-1})^\top c^{-1}
\left(\frac{dc}{dt}\right)
\left(\frac{dc}{dt}\right)^\top (c^{-1})^\top =0$$
を得る.
これが、この空間での測地線の方程式である.

#### 例題 8.3.1

曲線 $c(t) = \exp(tA)$ はある条件下で測地線になる.

ただし $\exp(tA) = \sum_i (tA)^i / i!$ で定義されるもので、
$A \exp(tA) = \exp(tA) A$
という交換ができる.
また $\exp(tA)$ の逆行列としていつも $\exp(-tA)$ が存在する ($A\ne 0$ とする).

先程得た方程式に代入してみる.
$$\begin{align*}
0 & =
-\frac{d}{dt} \left[ (\exp(-tA))^\top \exp(-tA) (A \exp(tA)) \right]
- (\exp(-tA))^\top \exp(-tA)
(A \exp(tA))
(A \exp(tA))^\top
(\exp(-tA))^\top \\
& =
- \frac{d}{dt} \left[\exp(-tA)^\top A\right]
- (\exp(-tA))^\top A A^\top \\
& =
(\exp(-tA))^\top A^\top A - (\exp(-tA))^\top A A^\top \\
\iff 0 & = A^\top A - A A^\top \\
\end{align*}$$
というわけで、

$A^\top A = AA^\top$ のとき ($A$ が正規行列のとき)
$c(t)=\exp(tA)$
はこの計量空間の測地線となる.

## 行列群の計量 2

$G = \mathrm{GL}(n;\mathbb{R})$
に今度はリーマン計量ではない計量を与える.
すなわち、距離が負を取り得る.

$$q\left( \frac{dc}{dt} \right) \equiv
\mathrm{tr}\left[
\left( c^{-1} \frac{dc}{dt} \right)^2
\right]
=
\mathrm{tr}\left[
c^{-1} \frac{dc}{dt}
c^{-1} \frac{dc}{dt}
\right]$$

先ほどと同様にこの計量について測地線の方程式を求めるとそれは
$$\frac{d}{dt} \left[ c^{-1} \frac{dc}{dt} \right] = 0$$
となる.

$c(t)=\exp(tA)$ なる曲線をこれに代入すると
$\frac{d}{dt} \left[ \exp(-tA) (A \exp(tA)) \right] = \frac{d}{dt} A = 0$
となって常に満たされるので、この曲線はこの計量の下ではいつも測地線である.

> !! このように、多様体の上で測地線を与える関数を **指数関数** という !!

## $k$-枠場 ($k$-frame field)

多様体 $M$ の上の $k$ 個のベクトル場の組
$(\xi_1, \xi_2, \ldots, \xi_k)$
であって、各点 $x\in M$ で
$(\xi_1(x), \xi_2(x), \ldots, \xi_k(x))$
が一次独立であって、どのベクトルもゼロにならないようなものを、
**k-枠場**
という.

$k$-枠場は常に存在するとは限らない.
球面上 ($S^2$) に 2-枠場は存在しない.
これは地球上で無風地点が存在する (ベクトルがゼロになる) という事実に依る.

$n$ 次元多様体であって $n$-枠場が存在するとき、 **平行化可能** であると表現する.

## 勾配ベクトル場 (grad)

リーマン多様体 $(M,g)$ とその上の実ベクトル $f: M \to \mathbb{R}$ について.
勾配 (grad) を次のように定める.

<div class=thm>
#### 定義
$$\mathrm{grad}f(x) \in T_xM$$
任意の $X \in T_xM$ に対して
$$Xf = g(X, \mathrm{grad}f(x))$$
</div>

陽に定義していないが、実際に成分表示してみるとわかる.

- $X = \sum_i a_i \partial/\partial x_i$
- $\mathrm{grad}f = \sum_i k_i \partial/\partial x_i$

$a=(a_i), k=(k_i)$ とすると、

- $g(X, \mathrm{grad}f) = a^\top G k$
    - $G$ は $g$ 相当の行列
- $Xf = a (\partial f/\partial x_i)$

この2つが任意の $a$ に対して成立するには
$$(\partial f/\partial x_i) = G k$$
$$\iff k = G^{-1} (\partial f/\partial x_i)$$
grad とは単にこれのことである.

<div class=thm>
#### 補題

多様体 $M$ とその上の実関数 $f: M \to \mathbb{R}$.
$f^{-1}(a) (= \{x: f(x)=a\})$
が $M$ の部分集合であるとする.

このとき
$$v \in T_xf^{-1}(a) \iff f_* v = 0.$$

#### 証明 $(\Rightarrow)$

$v \in T_xN$ であるとは, $N$ の上の曲線 $c$ があって
$\left. \frac{d}{dt} \right|_{t=0} c$
で同値類を取った代表元を $v$ だと呼ぶのであった
(実際には座標を取って $\mathbb{R} \to \mathbb{R}$ にしてから微分する).

今の場合、
ベクトル $v$ に対して曲線
$c, \{c(t) : -\epsilon < t < \epsilon\} \subset f^{-1}(a)$
がある.

$f_*v$ とは $c$ を $f(c(t))$ に写すものなので
$f(c(t)) = f(f^{-1}(a)) = a$
の一点に写す.
従って $f_*v$ は $\left. \frac{d}{dt} \right|_{t=0} a = 0$ に相当する.

```dot
digraph {
    rankdir=LR;
    bgcolor=transparent;
    node [shape=plaintext];

    subgraph cluster_1 {
        TxM -> TxR [label="f*"];
        TxM -> "Tx(f^-1(a))" [dir=back];
        TxR -> 0 [dir=back];
        "Tx(f^-1(a))" -> 0 [label="f*"];
        {rank=same TxM "Tx(f^-1(a))"}
        {rank=same TxR 0}
    }

    subgraph cluster_0 {
        M -> R [label=f];
        M -> "f^-1(a)" [dir=back];
        R -> a [dir=back];
        "f^-1(a)" -> a [label=f];
        {rank=same M "f^-1(a)"}
        {rank=same R a}
    }

}
```

実は $T_x$ の関手性からも明らか.
$f_*v$ は $f^{-1}(a) \to \mathbb{R}$ を $T_x$ で写したものだけど途中で
$T_xa = 0$
を通るから.

#### 証明 $(\Leftarrow)$

$f_*$ が常にゼロ写像のとき.
$Df$ がゼロなので $f$ は定数関数.
従って $f^{-1}(a)=M$.
従って任意のベクトル $v$ は $v \in T_xf^{-1}(a)$.

$f_*$ がゼロ写像でないとする.
$Df$ が正則だから、$T_xf^{-1}(a)$ は $M$ からちょうど $a$ の分だけ落ちて $n-1$ 次元.
$\Ker f_*$ を考える.
先ほどの $(\Rightarrow)$ は示されてるので、その結果より、
$\Ker f_* \supseteq T_xf^{-1}(a)$.

$\Ker f_*$ が $T_xM$ そのものと一致すると $f_*$ がゼロ写像であることになるから、$T_xM$ の真の部分集合.
従って $n-1$ 次元以下.
$\supseteq$ の関係で、左が $n-1$ 次元以下で右が $n-1$ 次元ちょうどなので、方眼関係を満たすために両方 $n-1$ 次元である.
部分ベクトル空間であって、次元が元のと一致してるので、結局一致して、
$\Ker f_* = T_xf^{-1}(a)$.


#### 補足

2つのベクトル空間 $V \supseteq W$ の次元が共に同じなら、2つは同じ空間である.
$W$ の方が例えば $n$ 次元なら、$n$ 個のベクトルからなる基底が取れる.
包含関係より、それらはそのまま $V$ の基底となる.

</div>

<div class=thm>
#### 定理

多様体 $M$ とその上の実関数 $f: M \to \mathbb{R}$.
$f^{-1}(a) (= \{x: f(x)=a\})$
が $M$ の部分集合であるとする.

$N = f^{-1}(a)$
の上の任意のベクトル $v$ と
$\mathrm{grad}(f)$
は直交する. すなわち、
$$g(v, \mathrm{grad}(f)) = 0$$
が成立する.

定義より
$\mathrm{grad}(f) = G^{-1} = \sum_{i,j} g^{ij} \frac{\partial f}{\partial x_j} \frac{\partial}{\partial x_i}$
であるのでこれを代入すると

$$g(v, \mathrm{grad}(f))
= \sum_{i,j,k} v_i g_{ij} g^{jk} \frac{\partial f}{\partial x_k}
= \sum_{i,j,k} v_i \frac{\partial f}{\partial x_k}$$

補題の $(\Rightarrow)$ より
$\sum_{i,j,k} v_i \frac{\partial f}{\partial x_k} = 0$
である.
</div>

## 例 8.5.1: 勾配ベクトル場、勾配フロー

球面 $S^2$ の2次元パラメータ表示
$$(x,y,z) = (\cos \theta \cos \phi, \sin \theta \cos \phi, \sin \phi)$$
の上の関数
$$f(x,y,z) = z = \sin \phi$$
この grad を考える.

計量を入れる必要があって、普通にユークリッド空間由来のリーマン計量を
$(\theta, \phi)$ 座標に対して求めると
$$g = \left[\begin{array}{cc}
\cos^2 \phi & \\ & 1
\end{array}\right]$$
である.

grad はこの逆行列を使って、
$$\begin{align*}
\grad f & = g^{-1} \left[\begin{array}{c}
\frac{\partial f}{\partial \theta} \\
\frac{\partial f}{\partial \phi}
\end{array}\right] \\
& = \left[\begin{array}{c}
0 \\ \cos \phi
\end{array}\right] \\
& =
\cos \phi \frac{\partial}{\partial \phi}
\end{align*}$$
と求まる.

この grad は一般に座標 $(\theta, \phi)$ に対して計算したが、これを引数と見做すことで、
**勾配ベクトル場** $\grad f$ と呼ぶ.
また、勾配ベクトル場が生成するフローを **勾配フロー** と呼ぶ.

ところで $\grad f=0$ なる点のことを **臨界点** という.
臨界点においてのみ勾配フローは恒等写像になっている.

## 例 8.5.2

二次元ユークリッド空間 $M=\mathbb{R}^2$ 上の実関数 $f$ と、曲線 $c(t) = (x(t), y(t))$ について次の式が成り立っているとする.
$$\frac{d}{dt}
\left[\begin{array}{c}x\\y\end{array}\right] =
\left[\begin{array}{c}
\frac{\partial}{\partial x}\\
\frac{\partial}{\partial y}
\end{array}\right]$$
この曲線上の $f$ の値を考える.

$$\frac{d}{dt} f(c(t)) =
\frac{\partial f}{\partial x} \frac{dx}{dt} +
\frac{\partial f}{\partial y} \frac{dy}{dt}
=
\left(\frac{\partial f}{\partial x}\right)^2 +
\left(\frac{\partial f}{\partial y}\right)^2$$

実数の自乗の和なので、
$f(c(t))$ という値は $t$ に関して (広義) 単調増加することが分かる.

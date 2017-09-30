% 坪井 多様体 &sect;8 - 多様体の上のベクトル場
% 2017-09-30 (Sat.)
% 数学 幾何学

## index

<div id=toc></div>

## ベクトル場に沿う偏微分

多様体 $M$ の上にフロー
$F_t: M \to M$
及び、それを生成するようなベクトル場
$X = \frac{dF_t}{dt} \circ F_t^{-1}$
があるとする.

$M$ 上の実関数
$f: M \to \mathbb{R}$
に就いて、
$Xf$
を次で定義する.

$X(x)$ はベクトルなので一般に
$$X(x) = \sum_i \xi_i(x) \frac{\partial}{\partial x_i}$$
と書ける.
これに対して
$$Xf(x) := \sum_i \xi_i(x) \frac{\partial f}{\partial x_i}(x)$$
と定める.

ここに出現する
$\frac{\partial f}{\partial x_i}$
は点を座標に移してから実数として微分するもので、
$\frac{\partial (f \circ \varphi^{-1})}{\partial x_i}$
のことである.
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

$M$ 上の2つのベクトル場 $X,Y$ がそれぞれ $F_t, G_s$ というフローを生成するとする.
$(F_t)_*$ は単に $TM\to TM$ の接写像だが、
$$(F_t)_*Y : M \to TM$$
$$x \mapsto (F_t)_* ( Y( F_{-t}(x) ))$$
と定める.
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
& = \sum_i Y_i(F_t(x)) \sum_j \frac{\partial x_j^{-t}}{\partial x_i} \frac{\partial}{\partial x_j}
\end{align*}$$

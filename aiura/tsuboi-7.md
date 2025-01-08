% 坪井 多様体 &sect;7 - 多様体の計量
% 2017-07-17 (Mon.)
% 幾何学 微分幾何

## index

<div id=toc></div>

## ユークリッド空間の長さ

まずはユークリッド空間の中の多様体だけを考える.

### 曲線の長さの定義

曲線
$$c : [0, 1] \to \mathbb{R}^m$$
の長さを
$$L(c) = \int_0^1 \left\| \frac{dc}{dt} \right\| dt$$
で与える.

次は長さではないけど長さの上限を与える.
$$A(c) = \int_0^1 \left\| \frac{dc}{dt} \right\|^2 dt$$

一般に
$\int f(t)^2 dt \geq \left[ \int f(t) dt \right]^2$
だから
$$A(c) \geq L(c)^2$$
という上界を与える.
それにノルムは自乗の方が計算がしやすいので.

### 定理

<div class=thm>
ユークリッド空間の2点 $x_0, x_1$ を通る曲線で
$c(0)=x_0$, $c(1)=x_1$
となるようなもので、
$L(c)$ に最小を与える曲線は2点をつなぐ直線
$c(t) = x_0 + t (x_1 - x_0)$
である.</div>

<div class=thm>
同様に2点をつなぐ直線で $A(c)$ に最小を与える直線は、
やはり
$c(t) = x_0 + t (x_1 - x_0)$
である.</div>

### 距離の定義

多様体 $M$ の2点 $x_0, x_1$ の距離を、これらをつなぐ曲線の長さの下限で定める.
$$d(x_0, x_1) = \inf \{ L(c) : c(0)=x_0, c(1)=x_1 \}$$
最小値じゃなくて下限になってるのは距離そのものを与える曲線が存在しなくても良いから.

## リーマン計量

### 多様体のパラメータ表示

$m$ 次元多様体 $M \subseteq \mathbb{R}^m$
にパラメータ表示
$$\Phi : W \to \mathbb{R}^m$$
$$W \subseteq \mathbb{R}^p$$
$$\text{rank} \Phi = p$$
を与える.
このときに曲線
$c : [0, 1] \to M$
の
$$\left\| \frac{dc}{dt} \right\|$$
を次のように計算する.

$$c = \Phi \circ \Phi^{-1} \circ c$$
$$\frac{dc}{dt}(t) = (D\Phi)(x) \frac{d (\Phi^{-1} \circ c)}{dt}(t)$$
ただしここで $x = (\Phi^{-1} \circ c)(t)$.

> このようにわざわざ $W$ を経由することの意義は、
> 後でいつか $M$ をユークリッド空間とは限らない空間の多様体にしたいから.
> $M$ がユークリッド空間でなくても、
> $(D\Phi)(x)$ は接写像の行列だし、
> $\frac{d (\Phi^{-1} \circ c)}{dt}(t)$
> は $[0,1]$ からユークリッド空間 $\mathbb{R}^p$ への写像の微分なので問題なく計算できる.


$$\left\| \frac{dc}{dt}(t) \right\|^2 =
\left(\frac{d (\Phi^{-1} \circ c)}{dt}(t)\right)^T
(D\Phi)(x)^T
(D\Phi)(x) \frac{d (\Phi^{-1} \circ c)}{dt}(t)$$

こんな風に書ける.
ここで

- $(D\Phi)(x)^T (D\Phi)(x)$ は $p\times p$ 行列でしかも転置を掛けてるから正値対称行列
    - $\Rightarrow$ $A = A(x)$ と置く
- $\frac{d (\Phi^{-1} \circ c)}{dt}(t)$ は長さ $p$ の列ベクトル
    - $\Rightarrow$ $v = v(t)$ と置く

$$\left\| \frac{dc}{dt}(t) \right\|^2 = v^T A v$$
と書き直せる.

コレは正に内積 (や双一次形式) と呼ばれる
$$(u,v) \to u^TAv$$
という形をしている.

行列 $A=(A_{ij})$ と列ベクトル $v=(v_i)$ について
$$v^TAv = \sum_{i,j} A_{ij} v_i v_j$$
であるが、正値行列の固有値は全て正で、その最小値を $\lambda$ とすると
$$v^TAv = \sum_{i,j} A_{ij} v_i v_j \geq \lambda v_i^2 = \lambda v^T v$$
となる.
つまり $v(t)$ を $W$ の上のベクトルだと思って、そのノルム自乗が元のノルム自乗 $(v^TAv)$ の下界を与えている.

### リーマン計量の定義

<div class=thm>
多様体 $M$ について、
正値対称双一次形式
$$g(x) : T_x \times T_x \to \mathbb{R}$$
これを **リーマン計量** と呼ぶ.

ついでにノルムの自乗に相当する
$$q(x) : T_xM \to \mathbb{R}$$
$$q(x)(v) = g(x)(v, v)$$
も定義しておく.
</div>

リーマン計量 $g$ は先ほどの行列 $A=A(x)$ に相当していて、
$T_x$ は行列のインデックスに相当している.
つまり
$$A(x)_{ij} = g(x) \left( \frac{\partial}{\partial x_i}, \frac{\partial}{\partial x_j} \right)$$
ということ.

便利なので
$$g_{ij}(x) = g(x) \left( \frac{\partial}{\partial x_i}, \frac{\partial}{\partial x_j} \right)$$
で
$$g_{ij} : U \to \mathbb{R}$$
を定める.

## リーマン多様体

リーマン計量 $g$ を導入した多様体のことを **リーマン多様体** という.

### リーマン多様体の上の曲線の長さ

要するにノルムの大きさを
$\|\frac{dc}{dt}\|^2 = q\left(\frac{dc}{dt}\right) = g\left(\frac{dc}{dt}, \frac{dc}{dt}\right)$
とすればよい.

$$L(c) = \int_0^1 \sqrt{ q\left(\frac{dc}{dt}\right) } dt = \int_0^1 \sqrt{ g\left(\frac{dc}{dt}, \frac{dc}{dt}\right) } dt$$

実際には $g$ は $U_i$ ごとに定められるので、曲線を適当に分割して各 $g$ で積分した値を足して計算する.

### 距離の定義

やはり同様に2点間の距離を
$$\mathrm{dist}(x, y) = \inf \{ L(c) \}$$
で定める.

これは対称律、三角不等式とかの距離の公理を満たしている.

前回の
$v^TAv = \sum_{i,j} A_{ij} v_i v_j \geq \lambda v_i^2 = \lambda v^T v$
から
$\mathrm{dist}(x, y) = \inf \{L(c)\} \geq \lambda \| \varphi(x) - \varphi(y) \|$
と、ユークリッド空間上での距離を下界にできる.
これを使うと
$\mathrm{dist}(x,y)=0 \implies \| \varphi(x) - \varphi(y) \| =0 \implies x=y$
とできて対称律を確かめられる.


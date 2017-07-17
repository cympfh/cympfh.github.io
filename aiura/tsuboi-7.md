% 坪井 多様体 &sect;7 - 多様体の計量
% 2017-07-17 (Mon.)
% 数学 幾何学

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
$$dist(x, y) = \inf \{ L(c) \}$$
で定める.

これは対称律、三角不等式とかの距離の公理を満たしている.

前回の
$v^TAv = \sum_{i,j} A_{ij} v_i v_j \geq \lambda v_i^2 = \lambda v^T v$
から
$dist(x, y) = \inf \{L(c)\} \geq \lambda \| \varphi(x) - \varphi(y) \|$
と、ユークリッド空間上での距離を下界にできる.
これを使うと
$dist(x,y)=0 \implies \| \varphi(x) - \varphi(y) \| =0 \implies x=y$
とできて対称律を確かめられる.

## 測地線

2点 $x_0, x_1$ を繋ぐもので、
長さ $L(c)$ の最小 (極小) を与えるような曲線を考える.

### 速度パラメータ

連続で $d\tau/dt>0$ であるような関数
$\tau : [0, 1] \to [0, 1]$
を用いて、
曲線 $c$ を $c \circ \tau$ とすることで同じ像を持つが速度が異なるような曲線を作ることができる.
この長さを考えると
$$\begin{align*}
L(c \circ \tau)
& = \int_0^1 \sqrt{ q\left(\frac{d(c \circ \tau)}{ds}\right) } ds \\
& = \int_0^1 \sqrt{ q\left(\frac{dc}{dt} \frac{d\tau}{ds} \right) } ds \\
& = \int_0^1 \sqrt{ q\left(\frac{dc}{dt} \right) } \frac{d\tau}{ds} ds \\
& = \int_0^1 \sqrt{ q\left(\frac{dc}{dt} \right) } dt \\
& = L(c)
\end{align*}$$

$L$ は曲線の像のみによって決まり、その速度には依らないことを示している.
ただし $A$ の方はそんなことはない.

特に $\tau$ を上手く作ることで等速の曲線を作ることが出来る.
曲線 $c$ に対して
$$\tau(t) = \frac{1}{L(c)} \int_0^t \sqrt{q\left(\frac{dc}{dt}\right)} dt$$
こうすれば $c' = c \circ \tau$ の速度
$\| \frac{dc'}{dt} \}$ は等速で $t$ に依らない.

$t$ に非依存ということは積分の中の自乗と外の自乗を入れ替えられて
$$\int_0^1 q\left(\frac{dc}{dt}\right)dt = \left[ \int_0^1 \sqrt{ q\left(\frac{dc}{dt}\right) } dt \right]^2$$
となるんで
$$L(c')^2 = A(c')$$
と出来る.
しかも $L(c) = L(c')$.

以上から、
曲線 $c$ が与えられた時、その像を変えずに長さの自乗と一致する $A(c')$ を与える $c'$ を構成することが出来る.
これを使うと次が言える.

<div class=thm>
$A$ に最小を与える曲線 $c$ は同時に $L$ にも最小を与える.
</div>

初めにも述べたように $L$ を直接計算するよりも $A$ を計算するほうが式が ($\sqrt{}$ が付かない分) 簡単なので、
こちらを使う.

### 測地線

多様体 $M \subset \mathbb{R}^m$ に就いて、
その上にある 2 点 $x_0, x_1$ を繋ぐもので、
$A$ の極小を与えるような曲線を考える.

変分法を使う.

$c(0)=x_0, c(1)=x_1$ なる曲線に対して、
任意の曲線 $\epsilon$ 、ただし
$\epsilon(0) = \epsilon(1) = 0$
なるもので僅かに変化させて
$$c + h\epsilon$$
という曲線を考える.
多様体はユークリッド空間の中にあるので曲線同士が足せる.

で、
$$\frac{\delta}{\delta h} \left. A(c + h\epsilon) \right|_{h=0} = 0$$
を満たすような $c$ が正に $A$ に極小を与える曲線である.
このような曲線を **測地線** という.

> 測地線であることは $L, A$ が最小であるための必要条件であり、
> 単に極小であることしか言っていないことに註意.

先の方程式を具体的に解いていく.

$g(x)$ の行列表示 $(g_{ij})$ を使って
$$A(c + h\epsilon) = \int_0^1 \sum_{i,j} g_{ij}\left(c + h\epsilon\right) \frac{d(c_i + h\epsilon_i)}{dt} \frac{d(c_j + h\epsilon_j)}{dt}$$

右辺を実際に $h$ で微分する.
各部品の微分を予め計算しておくと

$$\left. \frac{\delta}{\delta h} \right|_{h=0} g_{ij}\left(c + h\epsilon\right) = \sum_k \frac{\partial g_{ij}(c(t))}{\partial x_k}\epsilon_k$$
$$\left. \frac{\delta}{\delta h} \right|_{h=0} \frac{d(c_i + h\epsilon_i)}{dt} = \frac{d \epsilon_i}{dt}$$
(微分の線形性に註意)

あとはなんか部分積分とか駆使すると

$$\begin{align*}
\frac{\delta}{\delta h} \left. A(c + h\epsilon) \right|_{h=0}
& = \int_0^1
\left[
\sum_{i,j} \sum_k \frac{\partial g_{ij}(c(t))}{\partial x_k} \epsilon_k \frac{dc_i}{dt} \frac{dc_j}{dt}
+ 2 \sum_{i,j} g_{ij}(c) \frac{dc_i}{dt} \frac{d\epsilon_j}{dt}
\right] dt \\
& = \int_0^1
\left[
\sum_{i,j} \sum_k \frac{\partial g_{ij}(c)}{\partial x_k} \epsilon_k \frac{dc_i}{dt} \frac{dc_j}{dt}
- 2 \sum_{i,j} \frac{d}{dt} \left( g_{ij}(c(t)) \frac{d c_i}{dt} \right) \epsilon_j
\right] dt
+ 2 \sum_{i,j} \left[ g_{ij}(c) \frac{dc_i}{dt} \epsilon_j \right]_0^1 \\
& = \int_0^1
\left[
\sum_{i,j} \sum_k \frac{\partial g_{ij}(c)}{\partial x_k} \epsilon_k \frac{dc_i}{dt} \frac{dc_j}{dt}
- 2 \sum_{i,j} \frac{d}{dt} \left( g_{ij}(c(t)) \frac{d c_i}{dt} \right) \epsilon_j
\right] dt
\end{align*}$$

$\epsilon$ の添字を合わせれば
$$\frac{\delta}{\delta h} \left. A(c + h\epsilon) \right|_{h=0}
= \int_0^1 \sum_k \epsilon_k
\left[
\sum_{i,j} \frac{\partial g_{ij}(c)}{\partial x_k} \frac{dc_i}{dt} \frac{dc_j}{dt}
- 2 \sum_{i} \frac{d}{dt} \left( g_{ik}(c(t)) \frac{d c_i}{dt} \right)
\right]$$

これの $=0$ を考えるわけだが、$\epsilon_k$ は任意の曲線なので、これが成立するためにはその $[]$ の中がゼロである必要がある.
つまり、
$$\begin{align*}
0
& = \sum_{i,j} \frac{\partial g_{ij}(c)}{\partial x_k} \frac{dc_i}{dt} \frac{dc_j}{dt}
- 2 \sum_{i} \frac{d}{dt} \left( g_{ik}(c(t)) \frac{d c_i}{dt} \right) \\
& = \sum_{i,j} \frac{\partial g_{ij}(c)}{\partial x_k} \frac{dc_i}{dt} \frac{dc_j}{dt}
- 2 \sum_{i,j} \frac{\partial g_{ik}}{\partial x_j} \frac{dc_j}{dt} \frac{dc_i}{dt}
- 2 \sum_{i} g_{ik}(c(t)) \frac{d^2 c_i}{dt^2} \\
\end{align*}$$

$$
\iff
\sum_i g_{ik}(c(t)) \frac{d^2 c_i}{dt^2}
=
\sum_{i,j}
    \left( \frac{1}{2} \frac{\partial g_{ik}}{\partial x_j} - \frac{\partial g_{ik}}{\partial x_j} \right)
    \frac{dc_j}{dt}
    \frac{dc_i}{dt}
$$

とこうなる.

行列 $(g_{ij})$ の逆行列を $(g^{ij})$ と書くことにすると

$$
\frac{d^2c_\ell}{dt^2}
=
\sum_k g^{k\ell}
\sum_i g_{ik} \frac{d^2 c_i}{dt^2}
=
\sum_k g^{k\ell}
\sum_{i,j}
    \left( \frac{1}{2} \frac{\partial g_{ik}}{\partial x_j} - \frac{\partial g_{ik}}{\partial x_j} \right)
    \frac{dc_j}{dt}
    \frac{dc_i}{dt}
$$

これを満たす曲線が測地線.

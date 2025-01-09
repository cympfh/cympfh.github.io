% 坪井 多様体 &sect;7.3 - 測地線
% 2017-09-23 (Sat.)
% 幾何学 微分幾何

[7章](tsuboi-7.html) の続き

## index

<div id=toc></div>

## 概要

2点 $x_0, x_1$ を繋ぐもので、
長さ $L(c)$ の最小 (極小) を与えるような曲線 $c$ を考える.

## 速度パラメータ

まず $L$ と $A$ の関係について考える.

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
$\| \frac{dc'}{dt} \|$ は等速で $t$ に依らない.

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

## 測地線

多様体 $M \subset \mathbb{R}^m$ に就いて、
その上にある 2 点 $x_0, x_1$ を繋ぐもので、
$A(c)$ の極小を与えるような曲線 $c$ を考える.

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
    \left( \frac{1}{2} \frac{\partial g_{ij}}{\partial x_k} - \frac{\partial g_{ik}}{\partial x_j} \right)
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
    \left( \frac{1}{2} \frac{\partial g_{ij}}{\partial x_k} - \frac{\partial g_{ik}}{\partial x_j} \right)
    \frac{dc_j}{dt}
    \frac{dc_i}{dt}
$$

移項して、

<div class=thm>
測地線の方程式:
$$
\frac{d^2c_\ell}{dt^2}
-
\sum_k g^{k\ell}
\sum_{i,j}
    \left( \frac{1}{2} \frac{\partial g_{ij}}{\partial x_k} - \frac{\partial g_{ik}}{\partial x_j} \right)
    \frac{dc_j}{dt}
    \frac{dc_i}{dt}
=0$$
これを満たす曲線 $c(t)$ を正に **測地線** と呼ぶ.
</div>

ここからこの方程式の簡略化を行う.

まず
$\frac{1}{2} \frac{\partial g_{ij}}{\partial x_k} - \frac{\partial g_{ik}}{\partial x_j}$
の部分であるが、$i,j$ の対称式になっていない.
ただ、どうせ $\sum_{ij}$ を取るのだから、

$$\sum_{ij}
\frac{\partial g_{ik}}{\partial x_j}
=
\sum_{ij}
\frac{1}{2} \left(
\frac{\partial g_{ik}}{\partial x_j}
+
\frac{\partial g_{jk}}{\partial x_i}
\right)$$

これを使うと
$$
\sum_k g^{k\ell}
\sum_{i,j}
    \left( \frac{1}{2} \frac{\partial g_{ij}}{\partial x_k} - \frac{\partial g_{ik}}{\partial x_j} \right)
    \frac{dc_j}{dt}
    \frac{dc_i}{dt}
$$
は、
$$
\sum_k g^{k\ell}
\sum_{i,j}
\frac{1}{2}
\left(
\frac{\partial g_{ij}}{\partial x_k}
- \frac{\partial g_{ik}}{\partial x_j}
- \frac{\partial g_{jk}}{\partial x_i}
\right)
    \frac{dc_j}{dt}
    \frac{dc_i}{dt}
$$
と出来る.
個々の項は $i,j$ に関して対称式になっているのでキレイ.
そこで
$$\Gamma^\ell_{ij} = -
\frac{1}{2}
\sum_k g^{k\ell}
\left(
\frac{\partial g_{ij}}{\partial x_k}
- \frac{\partial g_{ik}}{\partial x_j}
- \frac{\partial g_{jk}}{\partial x_i}
\right)
$$
を定めて (符号に註意) 、測地線の方程式を次のように書き改める.

<div class=thm>
測地線の方程式:
$$\frac{d^2c_\ell}{dt^2}
+ \sum_{i,j} \Gamma^\ell_{ij} \frac{dc_j}{dt} \frac{dc_i}{dt}
= 0$$
</div>

この $\Gamma^\ell_{ij}$ のことを、
**クリストッフェルの記号**
とゆう.

> __註意__:
> $c(t)$ がこの解のとき、$t$ をスケールした $d(t)=c(at)$ もまた解である.

## 平行移動

測地線の方程式に就いて、一旦測地線のことを忘れて

曲線 $c$,
点 $c(t)$ からのベクトルを与える関数 $v(t)$ ($v(t) \in T_{c(t)}M$)
に関する微分方程式
$$\frac{dv_\ell}{dt}
+ \sum_{i,j} \Gamma^\ell_{ij} \frac{dc_i}{dt} v_i
= 0$$
を考える.

> これに更に条件 $v_i = \frac{d c_i}{dt}$ を付け加えれば測地線の方程式そのものである.
> あるが、一旦このことは忘れる.

リーマン計量 $g$ を与えれば $\Gamma^\ell_{ij}$ は定まり、
さらに曲線 $c$ を与えた時、この方程式を満たす $v$ が解として求まる.
このとき、
$$v_0 \in T_0M \mapsto v(t) \in T_{c(t)}M$$
を **平行移動** という.

これはベクトル $v(t)$ が曲線に沿って、(そのリーマン計量の下で) 平行に移動している様子である.

### 例

$M=\mathbb{R}^2$, $g(x)=1_2$ での平行移動を考える.
$g$ が $x$ に依らず定数ならクリストッフェルの記号はいつもゼロである.
$\Gamma^\ell_{ij}=0$.
これを代入すると微分方程式は
$$\frac{dv_\ell}{dt}=0$$
従って $v(t)=Const$.

このリーマン計量の下では平行移動とは想像通りの平行移動のことを指す.
ベクトルとして全く固定のものが $c(t)$ から生えてる感じ.

### 問 7.3.1

ベクトルのノルム $q(v)=g(v,v)$ を考える.
平行移動の中でベクトル $v(t)$ のノルム $q(v(t))$ は $t$ に関して一定である.

> ベクトルの平行移動の中でその大きさは不変

まず $g,q$ の定義から
$$q(v)=g(v,v)=\sum_{ij} g_{ij}(x) v_i v_j$$
これが $t$ に関して不変なので
$$\frac{d}{dt} q(v) = \sum_{ij} \frac{d}{dt} \left[ g_{ij}(x) v_i v_j \right]$$
これがゼロであることを示せばいい.
$x$ とあるが $x=c(t)$ のことなので、これについても微分する必要があることに註意.
あの微分方程式を代入して頑張れば求まるj

<!-- 2017/08/23 -->

## 指数関数

$TM$ の元は点 $x$ の上のベクトル $\sum_i X_i \partial/\partial x_i$ として表現される.
これを単に $2m$ 次元の
$$(x_1,\ldots,x_m, X_1,\ldots,X_m)$$
と書くことで、$TM$ は多様体
$M \times \mathbb{R}^m$
と見做せる.

測地線の方程式は $c$ に関する方程式であったが、それを
$M \times \mathbb{R}^m$
の上の一階微分方程式

<div class=thm>
$$
\sum_\ell X_\ell \frac{\partial}{\partial x_\ell}
+
\sum_\ell
\sum_{i,j} \Gamma^\ell_{ij} X_i X_j
\frac{\partial}{\partial X_\ell}
= 0$$
</div>

に等価なものとして書き換えられるらしい.
この書き換えかたはわからない. 謎.
注意点として、
$M \times \mathbb{R}^m$
を多様体としているので、ベクトルとして
$\frac{\partial}{\partial x_i}$
と
$\frac{\partial}{\partial X_i}$
というものが並んで出現している.

この左辺は単に $M \times \mathbb{R}^m$ の上のベクトルなので、
これをベクトル場だと見なすことが出来る.
そしてそれが生成するフロー
$$F : \epsilon \times K \times V \to M \times \mathbb{R}^m$$
$$\epsilon \subset \mathbb{R}$$
$$K \subset M$$
$$V \subset \mathbb{R}^m$$
がある.
$\epsilon, K, V$ は初期値を含むような十分小さい定義域.
このフローを **測地流** という.

フロー $F$ の簡単な性質を2つ示す.

1. $X_i=0$ のときベクトル場はゼロになるのでフローは流れず自明に
$$F(t,x,0)=(x,0)$$
($(x,0) \in K \times V$ とする.)

2. $c(t)$ が測地線の解なら $c(at)$ もそうであることを言ったが、
その初期値は $c(0)=c(a\cdot0)$ で $x$ は一致するが、
$X$ の方は、
$\frac{dc}{dt}(0)$ と
$\frac{dc(at)}{dt}(0) = a\frac{dc}{dt}(0)$
なので、$a$ 倍違う.
このことから
$$F(at,x,v)=F(t,x,av)$$

<div class=thm>
次のような関数を定義する
$$E_x(v) = F(1, x, v).0$$
ここで $.0$ はタプルの $0$ 個目 (0-indexed) へのアクセス.
つまり
$$E_x : T_xM \to M$$
</div>

まとめておくと次のような流れ

1. 多様体 $M$ にリーマン計量を入れる
1. ベクトル場を定める
1. フローが流れる (測地流)
1. $E_x(v)$ が定まる

この $E_x(v)$ は **指数関数** と呼ばれる.
次のような性質がある.

微分値 $D(E_x)(0)$ を調べる.

$$\begin{align*}
v \frac{d E_x(a)}{da}(0)
& = \frac{d E_x(av)}{da}(0) \\
& = \lim_{a \to 0} \frac{1}{a} \left( F(1,x,av) - F(1,x,0) \right)
& = \lim_{a \to 0} \frac{1}{a} \left( F(a,x,v) - F(0,x,v) \right)
& = \frac{d F(t,x,v)}{dt}(0) \\
& = v
\end{align*}$$
ここで $F(1,x,0)=x=F(0,x,v)$ を使ってる.
というわけで
$$v \frac{d E_x(a)}{da}(0) = v$$
なので
$$D(E_x)(0) = id$$

$E_x(0)=x$ であるが、その付近で微分同相であることがわかる.

> 指数関数が何であるかを非形式的に説明すると、次のようなものである.
> 初期値として $x \in M$ 及び $X \in T_xM$ を与えた時、
> $x$ から $X$ の方向にその大きさだけ進んだ曲線 $c$ がある.
> ここで $c$ は $c(0)=x$ で、
> そして $0 < t \leq 1$ について、2点 $x, c(t)$ を結ぶ測地線は
> $c$ そのもの (を $t$ に関してスケールしたもの, $d(s)=c(s/t)$) である.
> そのようなときに、$c$ のもう片方の端点 $c(1)$ が、正に $E_x(X)$ である.

### 問題 7.4.3

<div class=thm>
$$F : TM \to M \times M$$
$$F(x, X) = (x, E_x(X))$$
を定める.

ところで **零切断** とは
$$s_0 : M \to TM$$
$$s_0(x) = (x, 0)$$
のこと.
また $M$ の **対角集合** とは
$$\Delta = \{(x,x) : x \in M\}$$
のこと.

$F$ は零切断の像から対角集合の微分同相写像である.
</div>

微分同相であるとは、その接写像 $TF$ のヤコビアン行列が正則であることだった.
定義域から適当な点 $(x,0)$ での接写像は
($F(x,0)=(x,x)$ だから)
$$TF : T_{(x,0)} (TM) \to T_{(x,x)} (M \times M)$$
で,
$$T_{(x,x)} (M \times M) \cong T_{(x,x)} M \times T_{(x,x)} M$$
である.

$F$ の定義域の第1成分から値域の第1成分への写像 $F_{1,1}$ は
$x \mapsto x$
なので、その
$$DF_{1,1}=E.$$

$F$ の定義域の第2成分から値域の第2成分への写像 $F_{2,2}$ は
$$(X=\sum_i a_i \frac{\partial}{\partial x_i})
\mapsto
E_x(X)$$
で、
$$\left.
\frac{\partial E_x(X)}{\partial a_i}
\right|_{x=0}
=
\left.
\frac{\partial E_x(X)}{\partial X}
\right|_{x=0}
\frac{\partial}{\partial a_i}
=
\frac{\partial}{\partial a_i}$$

数ベクトル
$(a_1,\ldots,a_m)$ から
$\frac{\partial}{\partial a_1} \ldots \frac{\partial}{\partial a_m}$
への行列表示を考えることで
$$DF_{2,2}(x=0) = E$$
を得る.

第1成分から第2成分へ、第2成分から第1成分への相互作用は零なので、
結局
$$DF(x=0)=E.$$

### 例 7.5.2

$\mathbb{R}^3$ に埋め込んだ球面
$S^2 = \{(x,y,z) : x^2+y^2+z^2=0\}$
を考える.
リーマン計量は $\mathbb{R}^3$ から自然に与える.
つまり二点が与えられたら球面の上に線を引いて長さを与える.
幾何的知見から、測地線は大円 (球の中心を通る円) の孤であることがわかる.
ということは、$E_x(X)$ が描く軌跡は大円になりそうだ.

簡単のためにベクトル
$TS^2$
を大きさが1のものに限る.
位置ベクトル $x$ とベクトル $X \in T_xS^2$ は直交するものだから、
$(x,X) \in TS^2$
は3次の正規直交行列
$SO(3)$
と同型であることがわかる.
つまり、
$$\left(a_1,a_2,a_3\right) \in SO(3)$$
について、
$$x = a_1 / \|a_1\|$$
$$X = a_2 / \|a_2\|$$
とすればよい.
$E_x$ の軌跡は、この2つを回転させるものだから、
$$\left[\begin{array}{ccc}
\cos \theta & \sin \theta & \\
-\sin \theta & \cos \theta & \\
& & 1
\end{array}\right]$$
という行列で表示できる.

### 例

二次元の単位円 (から都合上、一点を除いた図形) を多様体 $M$ として考える.
$$\theta \in (-\pi,\pi) \mapsto (\cos \theta, \sin \theta)$$
という座標を入れる. $M$ は一次元.
($\theta=\pm \pi$ の点を除いている.)

$M$ にリーマン計量を $\mathbb{R}^2$ から入れる.
これはつまり次の様なこと.

簡単に $\theta$ が単調増加しないような曲線
$$c(t) = (\cos \theta(t), \sin \theta(t))$$
を考える.
$t \in [0,1]$
での $c$ の距離を $\mathbb{R}^2$ から与える.
これは
$$L(c) = \int_0^1 d\theta = \theta(1) - \theta(0)$$
である (弧の長さ).
これが
$$L(c) = \int_0^1 dt \sqrt{ q\left(\frac{dc}{dt}\right) }$$
を満たすような $q$ 及び、正値対称一次形式 $g(u,v)$ (; $q(u) = g(u,u)$) を見つけるのだった.
実際は距離の $t$ 微分を考えたほうがいい.
つまり
$$\frac{d\theta}{dt} = \sqrt{ q\left(\frac{dc}{dt}\right) }$$
この成立を考える.

$$\begin{align*}
\frac{dc}{dt}
& = \frac{d\theta}{dt} \frac{\partial}{\partial\theta} \\
\sqrt{q\left(\frac{dc}{dt}\right)}
& = \frac{d\theta}{dt} \sqrt{q\left(\frac{\partial}{\partial\theta}\right)} \\
\end{align*}$$
したがって
$$q\left(\frac{\partial}{\partial\theta}\right) = 1$$
$$g\left(
a \frac{\partial}{\partial\theta},
b \frac{\partial}{\partial\theta}
\right) = ab$$
が $M$ のリーマン計量である.

これらを測地線の方程式に代入する.
まずクリストッフェルの記号を求めると、$g$ が座標に依らず定数な時点で
$\Gamma^\ell_{ij}=0$
がわかる.
これを代入すれば測地線の方程式は
$$\frac{d^2c}{dt^2}=0$$
いわゆる等速運動.

測地線を生成するフローは **指数関数** の章で出てきた一階微分方程式に
$\Gamma = 0$
だけ代入すると
$$X \frac{\partial}{\partial x}$$
というベクトル場 ($TM \to T(TM)$ であることに註意) が生成するフローのことである.
$X$ 方向には流れてないので一定、 $x$ 方向には $X$ だけ流れてるので、フローは
$$F_t: (\theta, X) \mapsto (\theta + tX, X)$$
というもの.
指数関数は
$$E_\theta(X) = \left( F_1(\theta,X) \right).0 = \theta + X$$
である.

### 例 7.5.3

トーラス $T^2=\mathbb{R}^2/\mathbb{Z}^2$ に計量を、その割る前の
$\mathbb{R}^2$
で入れる.
いつもどおり $\Gamma^\ell_{ij}=0$ になり、測地線が生成するフローは
$$F_t ((x_1,x_2), (v_1,v_2)) \mapsto ((x_1+tv_1, x_2+tv_2), (v_1, v_2))$$

点 $(x_1,x_2)$ から出た測地線が自分自身に戻ってくるかどうかは

- $x_1 + m = x_1 + tv_1$
- $x_2 + n = x_2 + tv_2$

と書けるので、$\frac{v_1}{v_2}$ が有理数かどうかが必要十分条件になる.

### 例 7.5.4

これまでの計量は単純な埋め込みで考えてた.
次はトーラスにより複雑な計量を入れる.

$$\varphi : \mathbb{R}^2 \to \mathbb{R}^3$$
$$\left[\begin{array}{c}
x_1 \\ x_2
\end{array}\right]
\mapsto
\left[\begin{array}{c}
(2+ \cos x_2) \cos x_1 \\
(2+ \cos x_2) \sin x_1 \\
\sin x_2
\end{array}\right]$$
($x_1,x_2$ はトーラスの内部のある角度に対応している.)

行き先の $\mathbb{R}^3$ で元の $\mathbb{R}^2$ に計量を入れる.
これは
$$g = (D\varphi)^t (D\varphi) =
\left[\begin{array}{c}
(2+\cos x_2)^2 & \\
& 1 \\
\end{array}\right]$$
という計算で得られる.
$$g(v_1, v_2) = (2+\cos x_2)^2 v_1^2 + v_2^2$$

今、長さ 1 のベクトルに限定して考える.
$$(2+\cos x_2)^2 v_1^2 + v_2^2 = 1$$
これを眺めていると、

- $\cos \theta (2 + \cos x_2) v_1$
- $\sin \theta = v_2$

と置きたくなる.
$(x_1, x_2), (v_1, v_2), \theta$ が $t$ の関数だということにして測地流を考える.

突然だけど $\frac{d}{dt} \cos \theta$ を計算する.
2通りの計算がある.

$$\begin{align*}
\frac{d}{dt} \cos \theta
& = -\sin \theta \frac{d\theta}{dt} \\
\end{align*}$$

$$\begin{align*}
\frac{d}{dt} \cos \theta
& = \frac{d}{dt} (2+\cos x_2) v_1 \\
& = \frac{d v_1}{dt} (2+\cos x_2) - v_1 \sin x_2 \frac{dx_2}{dt} \\
& = \frac{d v_1}{dt} (2+\cos x_2) - v_1 v_2 \sin x_2
\end{align*}$$

ここで、測地線の方程式から
$$\frac{dv_1}{dt} = \frac{2 \sin x_2}{2+\cos x_2} v_1v_2$$
が得られるので、これを代入すると、

$$\begin{align*}
\frac{d}{dt} \cos \theta
& = \frac{d}{dt} (2+\cos x_2) v_1 \\
& = \vdots \\
& = v_1 v_2 \sin x_2
\end{align*}$$

実は $\theta$ と $x_2$ との方程式にしたいので、$v_1,v_2$ にも色々代入して

$$\begin{align*}
\frac{d}{dt} \cos \theta
& = \frac{d}{dt} (2+\cos x_2) v_1 \\
& = \vdots \\
& = v_1 v_2 \sin x_2 \\
& = \frac{\sin x_2}{2 + \cos x_2} \cos \theta \sin \theta
\end{align*}$$

結局
$$-\sin \theta \frac{d\theta}{dt}
= \frac{\sin x_2}{2 + \cos x_2} \cos \theta \sin \theta$$
を得る.
両辺を $\sin \theta$ で割りたい.
ゼロ除算があり得るので厳密には誤りだが、結果的に正しいのでやってしまうと
$$\frac{d\theta}{dt} = - \frac{\sin x_2}{2 + \cos x_2} \cos \theta$$
を得る.
この微分方程式から、 $\theta$ の挙動はその初期値と $\theta$ 自身と $x_2$ で表現できる.
$x_2$ の方は、
$$\frac{dx_2}{dt}=v_2=\sin \theta$$
なので、その初期値と $\theta$ で表現できる.
従ってこの2式から、$\theta, x_2$ の挙動は完全に把握できる.

2式から
$$\frac{\sin \theta}{\cos \theta}\frac{d\theta}{dt}
+
\frac{\sin x_2}{2+\cos x_2} \frac{dx_2}{dt}
=0$$
を得る.
これはやや強引に2式を足して$=0$ にしただけだが、$\theta,x_2$ の項が完全に分離されている.
しかも
$$f(t) = f(x_2(t), \theta(t)) = (2+\cos x_2) \cos \theta$$
と置くと、ちょうど
$$\frac{df}{dt}=0$$
になっている.
従って
$$f(t)= \mathrm{Const}$$
を得る.

```gnuplot
set xrange [-pi: pi]
set yrange [-pi: pi]
f(x, y) = (2 + cos(x)) * cos(y)
splot f(x,y) title 'f(x_2, theta)'
```

```gnuplot
set contour  # http://graph.pc-physics.com/contourline1.html
set view 0, 0
unset surface
set cntrparam cubicspline  # http://dsl4.eee.u-ryukyu.ac.jp/DOCS/gnuplot/node134.html
set cntrparam points 200
set cntrparam levels incremental -2, 0.5, 2
set sample 3000
set key right out

set xrange [-pi: pi]
set yrange [-pi: pi]
f(x, y) = (2 + cos(x)) * cos(y)
splot f(x,y) title 'f(x_2, theta)'
```

## 等長変換

### 定義
<div class=thm>
2つのリーマン多様体 $(M,g_M), (N,g_N)$ の間の微分同相写像
$F : M \to N$
が等長変換であるとは、
$$g_M(u, v) = g_N(F_*u, F_*v)$$
とあること.
</div>

ここで $F_*$ は接写像であった.
つまり $M$ 上の2つのベクトルと、
それらが $F$ (が導く接写像) によって写った先の $N$ 上の2つのベクトルとについて、
それぞれの計量で測ったときの内積が等しいこと.

例えば $M$ 上の曲線を $F$ で写すて出来る曲線の長さは元の曲線の長さと等しい.
従って測地線は測地線に写る.

逆に、この定義式を見た時、右辺にある $g_N$ と $F$ があれば、左辺の $g_M$ が導かれることになる.
このことを
$$F^* g_N = g_M$$
と書く.
元の $F$ の方向と逆 (反変) なので $*$ が右上.
<center>
```dot
digraph {
    rankdir=LR;
    bgcolor=transparent;
    node [shape=plaintext];
    gM -> gN [dir=back label="F^*"];
    TM -> TN [label="F_*"];
    M -> N [label=F];
}
```
</center>

さらに詳細を書くと、次の様
($g_N:(TN,TN)\to\mathbb{R}$ とかそういう細かいことは省略してるけど).

<center>
```dot
digraph {
    rankdir=LR;
    bgcolor=transparent;
    node [shape=plaintext];

    TM -> TN [label="F_*"];
    TN -> R [label=gN];
    TM -> R [label="F^*"];

    {rank=same; TM R}
}
```
</center>

### 等長変換群

$n$ 次元リーマン多様体
$(M,g)$ 自身への等長変換を考えるとこれは群であり、多様体である.
これを $\mathrm{Isom}(M)$ (Isometry) という.
その次元を考える.

各 $T_xM$ に正規直交基底を導入する.
1つの $n$ 次元正規直交は $O(n)$ ($n$ 次直交行列全体) と同型.
$$M \times \text{(正規直交基底)} \cong M \times O(n) \subset TM$$
のことを $\mathrm{Fr}M$ (frame bundle) と呼ぶ.
$\mathrm{dim}(\mathrm{Fr}M) = \mathrm{dim}(M) + \mathrm{dim}(O(n))
= n + \frac{n(n-1)}{2}
= \frac{n(n+1)}{2}$.

さて
$(x_0, E_0) \in \mathrm{Fr}M$
について
$$\mathrm{Isom}(M) \to \mathrm{Fr}(M)$$
$$F \mapsto F_* E_0$$
という写像が単射であることを示す.

値が同じなら引数が同じであることを示せば良い.
2つの $F,G\in\mathrm{Isom}M$ について
$F_*E_0=G_*E_0$ とする.
基底が同じなので任意のベクトルについて値が同じである.
$$\forall v, F_*v = G_*v$$
また、$TM$ の上のベクトルが同じということなんで、暗に
$F(x_0)=G(x_0)$
であることも言っていることに註意.

指数関数
$E_{x_0}(v)$
を考える.
これの全射が成立するような部分に限るが、
任意の $y$ について
$y=E_{x_0}(v)$
となるような $v$ があって、
等長変換は測地線を測地線に写すので
$t \mapsto E(tv)$ という曲線を考えると
$$F(E_{x_0}(tv)) = E_{x_0}(F(tv))$$
仮定から
$$E_{F(x_0)}(tF_*v) = E_{G(x_0)}(tG_*v)$$
なので結局
$$F(E_{x_0}(tv)) = G(E_{x_0}(tv))$$
$$F(y) = G(y)$$
$$F=G$$

## リーマン計量の存在

### Thm 7.7.1

<div class=thm>
$n$ 次元コンパクト多様体にはリーマン計量を与えることが出来る
</div>

コンパクトなので有限個数の被覆で
$$M = \bigcup_I U_i$$
と出来る.
各 $U_i$ について
$M = \bigcup_I V_i$
となるように
$$U_i \supset \overline{V_i} \supset V_i$$
を取る.

$V_i$ 上では正で $U_i$ より外ではゼロな関数 $\mu_i$ を作れるのは前に示した.

- $\mathrm{supp} \mu_i \subseteq U_i$
- $x \in V_i, \mu_i(x) > 0$

これを用いてベクトル
$$v = \sum v_i \frac{\partial}{\partial x_i}$$
に計量を次のように定めることが出来る.

- $q_i(v) = \mu_i(x) \sum v_i^2$
- $q(v) = \sum_i q_i(v)$

## 超曲面上の運動

物体の運動を考える.

$n+1$ 次元上の超曲面
$f(x)=0 (x \in \mathbb{R}^n)$
上の運動は
$x=x(t)$
で記述される.

まず点が曲面上に限定されていることは
$$f(x(t))=0$$
と表される.
これを $t$ で微分すると
$$\sum_i \frac{\partial f}{\partial x_i} \frac{dx_i}{dt}=0 \tag{1}$$
再びこれを $t$ で微分すると
$$\sum_{i,j} \frac{\partial^2 f}{\partial x_i \partial x_j} v_i v_j + \sum_i \frac{\partial f}{\partial x_i} a_i = 0
\tag{2}$$
を得る.
ここで
$$v_i = \frac{dx_i}{dt}$$
$$a_i = \frac{dv_i}{dt}$$
と置いた.

$f(x)=0$ の $x$ における法線方向は
$$\left( \frac{\partial f}{\partial x_i} \right)_i$$
で表される.
今、力が法線方向にのみ加わっているとする.
物理学の知見からこれは、加速度が法線方向のスカラー倍であることに等しい.
すなわち、$i$ に依存しないある係数 $a(x,t)$ があって、
$$a_i = a(x, t) \frac{\partial f}{\partial x_i}$$
である.

<div class=thm>
力が法線方向のみに加わる時、物体は等速運動をする</div>

速度一定であるとは
$$\sum_i v_i^2$$
が時間に依らず一定であること.
すなわち時間微分を調べれば良い.
$$\begin{align*}
\frac{d}{dt} \sum_i v_i^2
& = 2 \sum_i v_i a_i \\
& = 2 a(x,t) \sum_i v_i \frac{\partial f}{\partial x_i} \\
& = 0
\end{align*}$$
最後の $=0$ は式 $(1)$ による.
時間微分がゼロなので、時間に依らず一定の値であることが分かった.

式 $(2)$ に加速度の仮定を代入すると、
$$\sum_{i,j} \frac{\partial^2 f}{\partial x_i \partial x_j} v_i v_j + a(x,t) \sum_i \frac{\partial f}{\partial x_i} \frac{\partial f}{\partial x_i} = 0$$
これを移項すると
$$a(x, t) = F(f, x) v_i v_j$$
という形式になっている. $F$ はでかい分数みたいな形の式.
従って
$$a_i = F(f, x) \frac{\partial f}{\partial x_i} v_i v_j$$
となる.
以上をまとめた

$$\begin{cases}
v_i & = \frac{\partial x_i}{\partial t} \\
\frac{\partial v_i}{\partial t} & = F(f, x) \frac{\partial f}{\partial x_i} v_i v_j
\end{cases}$$

これは実はユークリッド空間の曲面が計量を与える場合の測地線の方程式になる.

% 微分可能多様体の定義から接写像まで
% 2017-05-06 (Sat.)
% 数学 幾何学

おさらいをやっていく.

## 微分可能多様体の定義

微分可能多様体とは次のように定義する図形のことである.

<div class=thm>
ある位相空間 (ハウスドルフ空間であること) と、ある自然数 $n$ があって、空間の上の開集合の族
$$\{U_i\}_{i \in I}$$
がある. $U_i$ は一般には無限個あることを想定する.
各 $U_i$ に対しては写像

$$\varphi_i : U_i \to \mathbb{R}^n$$

が定められているものとする.
ここで $\mathbb{R}^n$ は $n$ 次元ユークリッド空間のこと.

ここで次のような性質 (微分可能性) を要請する:

$$U_i \cap U_j \ne \emptyset \Rightarrow
\varphi_i \circ \varphi_j^{-1} ~\text{is}~ C^r \text{-class }$$

大抵は $C^\infty$ 級のことを考える (簡単なので).
またここでは、式を簡単にするために単に合成関数として書いているが、
実際は $\varphi_i$ の入力を $U_i \cap U_j$ に制限するために $\varphi_j^{-1}$ の定義域を制限する必要があるが、省略した.

以上の時、
$$\{ (U_i, \varphi_i) \}_{i \in I}$$
によって図形を表現し、これを
$n$ **次元微分可能多様体**
と呼ぶ.
</div>

各 $U_i$ のことを近傍とかいう.
特に $x \in U_i$ の関係のとき「$U_i$ は $x$ の (一つの) 近傍である」とかいう.
また $\varphi_i$ のことを $U_i$ の局所座標という.
実際、単に位相空間にすぎない $U_i$ に $n$ 次元の座標を与えている.

## 接ベクトル

### 多様体上の曲線

適当な開区間から多様体への写像のことを多様体上の曲線と定める.
区間はなんでも良いがここでは $[-\epsilon, \epsilon]$ ということにする.
すなわち多様体 $M$ 上の曲線 $c$ とは

$$c: [-\epsilon, \epsilon] \to M$$
$$c: (-\epsilon \leq t \leq \epsilon) \mapsto (x \in M)$$

> __N.B.__
> $x \in M$ と書いた場合の $M$ は点の集合としての図形であって、$x$ は図形の中のある一つの点のことである.
> 先の定義に従って忠実に述べると $x$ とは、ある $i$ があって $x \in U_i$ である.

### 点 $x$ の接ベクトル

$M$ のある点 $x$ の接ベクトルを定義する.
話をすっ飛ばすと、$x$ の接ベクトルとは $x$ を通る曲線のことである (これは正確ではない).
便宜上、$0 \in [-\epsilon, \epsilon]$ を $x$ に写すものに限ることにする (ここは本質ではない).

$$c: [-\epsilon, \epsilon] \to M$$
$$c(0) = x$$

ある $i$ があって $x \in U_i$ なわけだが、定義域 (すなわち $\epsilon$) を十分小さくすることで、
$c$ の値域が $U_i$ に完全に含まれることにしておく.
$U_i$ に寄り添って局所座標 $\varphi_i$ があるわけだが、これは点 $x$ に対して一つ決めればいいだけなので、
添字を無視して単に $\varphi$ とだけ書く.

なんやかんやあって曲線そのものを接ベクトルと見做すのは都合が悪いので、次のような写像

$$\varphi^* : \mathcal{C}_x \to \mathbb{R}$$
$$\varphi^*(c) = \frac{d \varphi \circ c}{dt}(t=0)$$

を使って同値関係を定めるのが良い.
ここで $0 \mapsto x$ な曲線全体のことを $\mathcal{C}_x$ と書いた.

> __N.B.__
> $t=0$ での微分値を求めてるのは、今、$t=0$ で $x$ を通ると仮定しているからであって、一般にはその値を代入する.

すなわち、

$$c \sim c'  \overset{\text{def}}{\Longleftrightarrow} \varphi^*(c) = \varphi^*(c')$$

なる曲線同士の同値関係 $\sim$ を定める.

この同値関係は $\phi_i$ を (もしあるならば) $\phi_j$ と取り替えても不都合がないという点で都合がよい.

$\mathcal{C}_x/\!\sim$ のことを $T_xM$ と書いて **接空間** と呼ぶ.
接空間の元を ($x$ の上の) **接ベクトル** という.

### 接空間はベクトル空間である

接空間は足し引き、スカラー倍ができる空間である.
それは曲線の足し引きとスカラー倍から類推できるだろう.

- $u, v \in T_xM$ について
    - $au + bv = \lambda t. au(t) + bv(t)$ ($a, b$ は実数)

というわけで、接空間といったとき、暗にベクトル空間としての性質を仮定することにする.
その方が便利なので.

<div class=thm>
接空間の基底ベクトルは実は次のようである.

$m$ 次元多様体 $M$ 上のある点 $x$ 上の接空間 $T_xM$ の基底ベクトルは、
$m$ 次元ユークリッド空間の基底ベクトルを

$$e_1, e_2, \ldots, e_m$$

としたとき、

$$c_i = \lambda t.~ \varphi^{-1}(t e_i) ~~(i=1,2,\ldots,m)$$

である (すなわち接空間は $m$ 次元ベクトル空間である).

これは基底の一つのとり方に過ぎないわけだが、このとり方の便利さは次の性質にある:
$$\varphi^*(c_i) = e_i$$
これは $\varphi^*$ の全射性を示すのにも使われる.
</div>

## 多様体の上の写像

ユークリッド空間そのものが多様体の一例であることを考えると、
曲線はある多様体からある多様体への写像の例になっている.

$m$ 次元多様体 $M$ から $n$ 次元多様体 $N$ への写像

$$F: M \to N$$

とは、(普通に) $x \in M$ を $y \in N$ に写す写像のことである.

普通、大抵、どんな写像でも良いとするわけではなくて、ここでは連続な写像 $F$ のことを考えたい.
連続であることを $C^r$ 級 (すなわち微分可能性) で表現したい.
しかし、 $F$ の定義域/値域は単に位相空間の上の図形にすぎないので微分をすることはできない.

(常套手段であるが) このために$M, N$ には局所座標が設けられている.
すなわち、次のようにする.

<div class=thm>
まずある点 $x \in M$ の周りで微分可能であることを調べる.
$x$ の近傍 $U_i$ を持ってきて、その中の十分小さい領域 $U'$ を取って

$$F : U' (\subseteq U_i) \to V' (\subseteq V_j)$$

に制限する.
$F$ の両端にそれぞれの局所座標 ($U_i$ に対して $\varphi_i$、$V_j$ に対して $\psi_j$) を合成することで

$$\psi_j \circ F \circ \varphi_i^{-1} : \mathbb{R}^m \to \mathbb{R}^n$$

を得る.
これはおなじみの実関数であるので自由に微分が可能.
これが $C^r$ 級であるとき、$F$ は $x$ の周りで $C^r$ 級であると定義する.

全ての $x \in M$ の周りで $F$ が $C^r$ 級であるとき、$F$ 自体を単に $C^r$ 級であると定義する.
</div>

## 接写像

### Introduction

さて考える.

- $M$ を $m$ 次元多様体、
- $N$ を $n$ 次元多様体とし、
- $C^\infty$ 級の写像 $F: M \to N$ があるとする.

$M$ 上のある点 $x$ を通る曲線の集合 $\mathcal{C}_x$ があって、そこに同値関係を導入したものが
$T_xM$ であった.

写像 $F$ は $x$ を $y = F(x)$ に写すとする.

写像 $F$ は点を点に写すものであるが、曲線の像に注目すれば、$M$ 上の曲線を $N$ 上の曲線に写すことができる.
曲線とは写像のことであったが、写像の像を更に移せばよい.
それはつまり関数合成のことである.

- $M$ 上の曲線 $c \in \mathcal{C}_x$ に対して
- $c' = F \circ c$ は $N$ 上の曲線である.
- $c$ が $t=0$ で $x$ を通るような曲線であったことに対して、
- $c'$ は $t=0$ で $y$ を通るような曲線である.
    - すなわち $c' \in \mathcal{C}_y$.

<center>
```dot
digraph {
    rankdir=LR;
    bgcolor=transparent;
    M -> N [label=F];
    TxM -> TyN [label="??"];
    M -> Cx -> TxM [style=dotted];
    N -> Cy -> TyN [style=dotted];
    Cx -> Cy [label="F.c"];
    {rank=same; M TxM Cx}
    {rank=same; N TyN Cy}
}
```
</center>

以上話したことを一言で述べると、
写像 $M \to N$ から写像 $\mathcal{C}_x \to \mathcal{C}_y$ を導いた.
では、これを $\sim$ で割って $T_xM \to T_yN$ を導くことはできるだろうか?

### 同値類の写像

<div class=thm>
ある関数 $f: X \to Y$ がある.
$X, Y$ 上の同値関係 $\sim$ によって関数

$$f' : X/\!\sim \to Y/\!\sim$$

を自然に導くとは、次のように関数 $f'$ を定められること.

1. $f'([x]) = [f(x)]$ (写像の構成)
1. $x \sim x'$ のとき $f'([x]) \sim f'([x'])$ (同値関係の保存)

ただしここで $x \in X, y \in Y$ に対してそれらの代表元を
$[x] \in X/\!\sim, [y] \in Y/\!\sim$ と書いた.
</div>

「導くことはできるか」を確認するにはこれを確認すればよい.
すなわち、

$$F \circ c :~ \mathcal{C}_x \to \mathcal{C}_y$$

から

$$T_xM \to T_yN$$

を自然に導くことはできるか??

### 関手

もし導くことができるのなら、
$T$ (添字とか細かいことは気にしないで) というのは次のようなオペレータと見做せないだろうか.
すなわち、
定義域の $M$ を $T_xM$ に写し、
値域 $N$ を $T_yN$ に写し、
写像 $F: M \to N$ を $T_xM \to T_yN$ に写す.

こうなると、写像 $F$ を写した先の写像のことは $T_xF$ と書くのが妥当に思えてくる.
(この文書の中においてはほんと添字はあんま気にせんで.)

<center>
```dot
digraph {
    rankdir=LR;
    bgcolor=transparent;
    M -> N [label=F];
    TxM -> TyN [label=TxF];
    M -> TxM [style=dotted];
    N -> TyN [style=dotted];
    {rank=same; M TxM}
    {rank=same; N TyN}
}
```
</center>

先章まで述べてきたことを言い直すと、こうだ.
接空間を考えることで、 写像 $F$ から $T_xF$ を導くことはできるだろうか???

### やっていく.

出来る.

具体的な写像の構成は、次のようである.
代表元を取る操作とかはいちいち書かないが、察して.

$$T_xF : T_xM \to T_y N$$
$$T_xF(u) = (F \circ c)(u)$$

次に同値性を保存していることを確認する.

$u \sim v$ を仮定する.
$u, v$ は $T_xM$ の元なので $M$ の上の適当な局所座標を取って定義される $\varphi^*: U_i \to \mathbb{R}$ によって同値性は定義される.
すなわち $\varphi^*(u) = \varphi^*(v)$ である.

このときに、

$$T_xF(u) \sim T_xF(v)$$

であることを確認できればよい.
$T_xF(u), T_xF(v)$ は $T_yN$ の元であるので、そこでの適当な局所座標から定義される関数
$\psi^*$ によって同値性を確認する必要があることに註意.

すなわち、
$$\psi^*(F \circ u) = \psi^*(F \circ v)$$
を確認したい.

やっていく:

$$\begin{align*}
\psi^*(F \circ u)
& = \frac{d \psi \circ F \circ u}{dt}(0) \\
& = \frac{d \psi \circ F \circ \varphi^{-1} \circ \varphi \circ  u}{dt}(0) \\
& = \frac{d \psi \circ F \circ \varphi^{-1}}{d x}(x=x_0) \cdot \frac{d \varphi \circ  u}{dt}(t=0)
\\
\end{align*}$$

最後の式変形では微分のチェーンルールを用いている.
また、
分母の $dx$ は $M$ の局所座標 ($\varphi$ の値域) 上での微分であって、$x_0 = \varphi(u(0))$ としている.
これは $\psi \circ F \circ \varphi^{-1}$ が実関数であるから書けることに註意.
同様に $\varphi \circ u$ も実関数であるからこれも $t$ で微分できている.

さて今、
$\varphi^*(u) = \varphi^*(v)$ を仮定しているので、
$\frac{d \varphi \circ  u}{dt}(t=0) = \frac{d \varphi \circ  v}{dt}(t=0)$
である.
従って、

$$\begin{align*}
\psi^*(F \circ u)
& = \frac{d \psi \circ F \circ \varphi^{-1}}{d x}(x=x_0) \cdot \frac{d \varphi \circ  u}{dt}(t=0) \\
& = \frac{d \psi \circ F \circ \varphi^{-1}}{d x}(x=x_0) \cdot \frac{d \varphi \circ  \color{red}{v}}{dt}(t=0) \\
\end{align*}$$

加えてこの一項目の
$\frac{d \psi \circ F \circ \varphi^{-1}}{d x}(x=x_0)$
が、もはや $u, v$ に依存してないことに註意すれば、結局

$$\begin{align*}
\psi^*(F \circ u)
& = \psi^*(F \circ v)
\end{align*}$$

となる.
というわけで同値性の保存が成立していることが確認できた.

以上で、
写像 $F$ から $T_xF$ を導けることが示された.
この $T_xF$ のことを **接写像** という.

## 接写像の行列表示

接写像はベクトル空間 $T_xM$ から ベクトル空間 $T_yN$ への写像であるから、
写す値をベクトル表示することで、関数 $T_xF$ を行列表示することができるはずである.
やっていく.

具体的には基底がどう写るかを調べる.

- $c_i = \lambda t.~ \varphi^{-1}(te_i)$
- $\varphi^*(c_i) = \left. \frac{d}{dt} \varphi(\varphi^{-1}(te_i)) \right|_{t=0} = e_i$

ただし $e_i = (0, \ldots, 0, 1, 0, \ldots, 1) \in \mathbb{R}^m$ (または $\mathbb{R}^n$).
これを $T_xF$ で写す

- $T_xF(c_i) = F \circ c_i$
- $\psi^*(F \circ c_i) = \left. \frac{d}{dt} \psi(F (\varphi^{-1} (te_i))) \right|_{t=0}$

ここで $\psi \circ F \circ \varphi^{-1}$ という関数は $F$ を通して
$M$ の上の局所座標 $(x_1, x_2, \ldots, x_m)$ から
$N$ 上局所座標 $(y_1, y_2, \ldots, y_n)$ へ写しているものだと解釈できる.

$$(y_1, y_2, \ldots, y_n) = (F_1(x_1), F_2(x_2), \ldots, F_n(x_n))$$

しかも $x$ の上の $e_i$ 方向に (i.e. $x_i$ 成分を) 動かしたときの微分値であるから、これは、
$F$ を $x_i$ で偏微分した値だと言える.
したがって、

$$\frac{d}{dt} \psi(F(\varphi^{-1}(x_1, x_2, \ldots, x_m))) =
\left(
\frac{\partial F_1}{\partial x_i},~
\frac{\partial F_2}{\partial x_i},~
\ldots,~
\frac{\partial F_n}{\partial x_i} \right)$$

というわけで、
$$\psi^*(F \circ c_i) =
\left.
\left(
\frac{\partial F_1}{\partial x_i},~
\frac{\partial F_2}{\partial x_i},~
\ldots,~
\frac{\partial F_n}{\partial x_i} \right)
\right|_{x=x_0}$$
となる.

<div class=thm>
さて、ベクトル表示をすることは、$\varphi^*, \psi^*$ で写すことに相当する.
なぜなら今用いている基底ベクトル
$c_i \in T_xM$
は、
$\varphi^*(c_i) = e_i (i=1,2,\ldots,m)$
となるようなものだからである.

これは $N$ 上でも同様で、
$\varphi^*(d_i) = e_i (i=1,2,\ldots,n)$
となるような $d_i$ を $T_yN$ の基底ベクトルと定める.

というわけで、
$\sum_i a_i c_i$
は $\varphi^*$ によって自然にユークリッド空間上の点
$(a_1, a_2, \ldots, a_m)$
に写せる.

逆に
$(b_1, b_2, \ldots, b_m) \in \mathbb{R}^n$
を
$\sum_j b_j d_j$
に戻すことも容易だろう.
</div>

では先程求めた

1. $\varphi^*(c_i) = \left. \frac{d}{dt} \varphi(\varphi^{-1}(te_i)) \right|_{t=0} = e_i$
1. $\psi^*(F \circ c_i) =
\left.
\left(
\frac{\partial F_1}{\partial x_i},~
\frac{\partial F_2}{\partial x_i},~
\ldots,~
\frac{\partial F_n}{\partial x_i} \right)
\right|_{x=x_0}$

これらを $T_xM, T_yN$ に引き戻すことをしよう.

1. $\varphi^*(c_i) = e_i \mapsto c_i$
1. $\psi^*(F \circ c_i) \mapsto \sum_{j=1}^n \left. \frac{\partial F_j}{\partial x_i} \right|_{x=x_0} d_j$

この一つ目から二つ目に $F$ によって移されたわけである.
$\mapsto$ の左が行列表示で右が基底の線形結合の形で書き表したものである.

行列表示ができそうに思えてくる.
すなわち、

$$\left[ \begin{array}{c}
0\\ \vdots\\ 0\\ 1\\ 0\\ \vdots\\ 1
\end{array} \right]
\mapsto
\left.
\left[ \begin{array}{c}
\frac{\partial y_1}{\partial x_i} &
\frac{\partial y_2}{\partial x_i} &
\cdots,
\frac{\partial y_n}{\partial x_i}
\end{array} \right]
\right|_{x=x_0}$$

というわけで $F$ を次のように行列表示することができる.

$$\left.
\left[ \begin{array}{c}
\frac{\partial y_1}{\partial x_1} & \frac{\partial y_2}{\partial x_1} & \cdots & \frac{\partial y_n}{\partial x_1} \\
\frac{\partial y_1}{\partial x_2} & \frac{\partial y_2}{\partial x_2} & \cdots & \frac{\partial y_n}{\partial x_2} \\
\vdots & \vdots & \vdots & \vdots \\
\frac{\partial y_1}{\partial x_m} & \frac{\partial y_2}{\partial x_m} & \cdots & \frac{\partial y_n}{\partial x_m}
\end{array} \right]
~
\right|_{x=x_0}$$

これはいわゆるヤコビアン ($DF$) のことである.


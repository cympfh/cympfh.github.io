% 坪井 多様体 &sect;6 - 多様体上のフロー
% 2017-05-28 (Sun.)
% 数学 幾何学

## 諸定義

### アイソトピー

多様体 $M$ に関して
$M \to M$ なる写像自体が時刻 $t \in [0, 1]$ に関して連続に写るとする.
すなわち
$C^\infty$ 級の
$$F : \mathbb{R} \times M \to M$$
があるとき、これを
$$F : [0,1] \times M \to M$$
に制限し、
$F_t(x) = F(t, x)$
と定めることで、
時刻 $t$ をパラメータとして取る
$$F_t : M \to M$$
を得る.

このような $F_t$ が微分同相であり、かつ $F_0 = id_M$ のとき、$F_t$ のことをアイソトピーという.

### フロー

$t$ の定義域を $[0,1]$ に制限する前の
$$F : \mathbb{R} \times M \to M$$
であって、やはり
$$F_0 = id_M$$
であって、加えて次のような、群の作用性

- $F_{-t} = F_t^{-1}$
- $F_s \circ F_t = F_{s + t}$

が満たされている $F_t(x) = F(t,x)$ のことを $M$ 上の **フロー** という.

### ベクトル場

多様体 $M$ の上のベクトル場とは点 $x \in M$ にベクトルを与えるものである.
すなわちベクトル場 $X$ とは
$$X : M \to TM$$
$$X : x \mapsto (u \in T_xM)$$
なる写像のこと.

## アイソトピーを生成するベクトル場

アイソトピー $F_t$ からベクトル場 $X_t$ を導くことが出来る.
流れとしては逆だけど「ベクトル場 **が** アイソトピーを生成する」と表現する.
また以下の議論はフローについても全く同様に出来、従ってフローからベクトル場を導くことが出来る.

アイソトピー $F_t$ についてある基点
$$F(t_0, x_0) = y_0$$
を1つ定める.

直感的には下図のようである.
即ち、基点から $t$ だけをほんの少し動かすと、$F$ の先もほんの少し動く ($y_1$ とする).
$M$ の上で正にベクトル $\vec{y_0~y_1}$ が作られたことに成る.
これを各点 $x$ について用いれば ($t_0$ は固定して)、$M$ の上のあらゆるところでベクトルが作られ、従ってベクトル場が出来る.

<center>

```dot
digraph {
    node [shape=plaintext];
    bgcolor=transparent;
    rankdir=LR;
    x0 -> y0 [label=F];
    x1 -> y1 [label=F];
    x0 [label="t_0, x_0"];
    x1 [label="t_1, x_0"];
    y0 [label="y_0"];
    y1 [label="y_1"];
    y0:se -> y1:ne [color=red];
    {rank=same x0 x1}
    {rank=same y0 y1}
}
```

</center>

形式的には次のように書ける.
今 $x=x_0$ を固定し、$t$ を動かすとき、これは軌道 (曲線)
$$y(t) = F(t, x_0)$$
を描く.

これは $y_0$ を通る曲線であるので、 $y_0$ の上のベクトル
$$\frac{d}{dt} y(t) = \frac{d}{dt} F(t, x_0)$$
と見なせる.

> $t \mapsto (x \in M)$ な関数 $g$ に対して
> $\frac{d}{dt}g(t)$
> は $M$ の上のベクトルを指す.
> この $\frac{d}{dt}$ は実関数の (偏) 微分のことではない.
> [4章](tsuboi-4.html) の内容であるが、
> これは
> $\frac{d}{dt} (\phi \circ g)(t)$
> の値 (これは微分値) によって同一視して出来る多様体の上のベクトルのことである.
> なので $g$ が $g(t, x)$ といった多変数関数であっても
> $\frac{\partial}{\partial t}g$
> ではなく
> $\frac{d}{dt}g$
> と書く.

ベクトル場としては、$M$ の上の点 $y$ を与えた時に $y$ を通るベクトルを返す関数である必要がある.
そこで
$x_0 = F_{t_0}^{-1}(y_0)$
を前に挟む必要がある.
$$X_{t_0}(y) = \frac{dF}{dt} (t_0, F_{t_0}^{-1}(y))$$
すなわち、
$$X_{t_0} = \frac{dF}{dt} (t_0) \circ F_{t_0}^{-1}.$$

紛らわしいが次のように書くこともある:
$$X_{t} = \frac{dF_t}{dt} \circ F_{t}^{-1}.$$

#### 展開

次を使う.

<div class="thm">
**復習**

$m$ 次元多様体 $M$ の上の曲線 $\gamma : [0,1] \to M$ を局所座標を用いて成分表示をする.
すなわち、
$$f = \phi \circ \gamma$$
$$f_i = \phi_i \circ \gamma ~~(i=1,2,\ldots,m)$$
ここで $f_i$ は $\mathbb{R}^m \to \mathbb{R}$ なる実関数に過ぎないことに註意.
これを用いて、$\gamma$ が表現するベクトルは

$$\left[\gamma\right] = \sum_{i=1}^m \frac{df_i}{dt}(t_0) \frac{\partial}{\partial x_i}$$
</div>

$X_t$ にこれを適用する.
$$f(t, y) = (\phi \circ F_t \circ F_{t_0}^{-1})(y)$$
と置くとき、
$$X_{t_0} = \sum_i \frac{d f_i(t, y)}{dt}(t_0) \frac{\partial}{\partial x_i}.$$

ただし、$y \in M$ を引数にするよりも、その局所座標 $y_1, y_2, \ldots, y_m$ を引数にする方が便利かもしれない.
だって上の $f_i$ は $[0,1] \times M \to \mathbb{R}$ であって陽に書けず、微分の計算をするときに想像力が必要となるから.

そのときは
$$f(t, y_1, \ldots, y_m) = (\phi \circ F_t \circ F_{t_0}^{-1} \circ \psi^{-1})(y_1, \ldots, y_m)$$
に対して
$$X_{t_0} = \sum_i \frac{d f_i(t, y_1, \ldots, y_m)}{dt}(t_0) \frac{\partial}{\partial x_i}.$$
と出来る.

#### 例

局所座標でいきなり書く (或いはユークリッド空間の上の多様体を考える).
$$F_t : \mathbb{R}^2 \to \mathbb{R}^2$$
$$F_t(x, y) = (e^t x, e^{-t}y)$$
が導くベクトル場がどんなものか考える.

1. $f = \varphi \circ F_t \circ F_{t_0}^{-1} \circ \varphi^{-1} = (e^{t - t_0} x, e^{t_0 - t}y)$.
1. $X_{t_0} = \left( e^{t - t_0}(t_0) ~ x, e^{t_0 - t}(t_0) ~ y \right) = (x, y)$.

ベクトル場 $X_{t_0}$ を求めた時点でパラメータ $t_0$ を改めて $t$ と置いて $X_t$ などと書くが、
この例では $X_t = (x, y)$ となって $t$ に依存しない形に偶然なった.

## フローの時刻非依存性

上の議論から、フロー $F_t$ からベクトル場 $X_t$ を導くこともできるのだが、重要な性質として、
フローを生成するようなベクトル場 $X_t$ は $t$ に依存しない.

### 証明

フローの性質から
$$F_t(x_0) = F_{t - t_0}(F_{t_0}(x_0))$$
$$\iff F(t, x_0) = F(t - t_0, F_{t_0}(x_0)).$$
両辺を $t$ についての軌道と見做し $t=t_0$ の時のベクトルを取る.
$$\frac{dF}{dt}(t_0, x_0) = \frac{dF}{dt}(0, F_{t_0}(x_0)).$$
ここで、$F_{t_0}(x_0) = y_0 \iff x_0 = F_{t_0}^{-1}(y_0)$ と置けば、
$$\frac{dF}{dt}(t_0, F_{t_0}^{-1}(y_0)) = \frac{dF}{dt}(0, y_0)$$
を得る.
更に更に $F_0$ が恒等写像であることを思い出して、
$$\frac{dF}{dt}(t_0, F_{t_0}^{-1}(y_0)) = \frac{dF}{dt}(0, F_0^{-1}(y_0)).$$
ここで $dF/dt=X_t \circ F$ のあの式を適用すると
$$X_{t_0}(y_0) = X_0(y_0)$$
を得る.
$y_0$ は $t_0$ と独立に決められるので一般に
$$X_{t_0} = X_0$$
となる. $t_0$ も自由に決められるので、結局、ベクトル場 $X_t$ は $t$ に依存しない形になっている.

### 例

フロー
$$F_t : \mathbb{R} \to \mathbb{R}$$
$$F_t(x) = x + t$$
が導くベクトル場を考える.
$F_t$ の成分を与える実関数は

- $f(t, x) = (\psi \circ F_t \circ F_{t_0}^{-1} \circ \phi^{-1})(x) = x + t - t_0$

局所座標としてはそのまんまの座標を与えた.
$\frac{\partial f}{\partial t}(t, x) = 1$
から
$X_{t_0}(x) = 1 \cdot \frac{\partial}{\partial x}$.
確かに $t$ に依存しない.

### 例

フロー
$$F_t : \mathbb{R}^2 \to \mathbb{R}^2$$
$$F_t(x, y) = (x \cdot \exp(t), y \cdot \exp(t))$$

- $f_1(t, x) = x \cdot \exp(t - t_0)$
    - $\frac{\partial}{\partial t}f_1(t, x) = x \cdot \exp(t - t_0)$
- $f_2(t, y) = y \cdot \exp(t - t_0)$
    - $\frac{\partial}{\partial t}f_2(t, y) = y \cdot \exp(t - t_0)$

$t=t_0$ の時の微分値を成分にするので、結局
$$X_{t_0} = x \frac{\partial}{\partial x} + y \frac{\partial}{\partial y}$$
となる.
やはり確かに $X_t$ は $t$ に依存しない.

## フローの軌道

多様体 $M$ 上のフロー $F_t$ と、ある点 $x \in M$ について
$$\{ F_t(x) : t \in \mathbb{R} \}$$
を、$x$ を通る軌道 (orbit) という.

### 定理

<div class="thm">
多様体 $M$ のフロー $F_t$ 及び点 $x \in M$ について、
$F_t(x)$ が $t$ についての定値関数ではないとする.
つまり $x$ を通る軌道が点ではないとする.
ある $T (>0)$ が存在して次が成立する.
異なる2時刻 $t_1, t_2$ で
$$F_{t_1}(x) = F_{t_2}(x)$$
が成り立つならば
$$\exists n \in \mathbb{N}, |t_1 - t_2| = nT.$$

つまり、軌道がある一点 $F_t(x)$ を複数回通るならば、周期 $T$ で何度もその点を通っている.
</div>

#### 証明

その点を通る時刻について考える.
ただその前に
$$F_{t_1}(x) = F_{t_2}(x)$$
について、$F_{ - t_1}$ を掛ければ
$$x = F_0(x) = F_{t_2 - t_1}(x)$$
となるので、「軌道が点 $F_t(x)$ を通る」とか言わずに「点 $x$ を何度も通る」という状態を考えればいい.

軌道が $x$ を通る時刻の集合
$$A = \{ t : F_t(x) = x \}$$
を考える.
これは実は群になっていて、

- $0 \in A$
- $t \in A \implies -t \in A$
    - $\because F_{-t}(x) = F_{-t}(F_t(x)) = x$
- $s, t \in A \implies s + t \in A$
    - $\because F_{s + t}(x) = F_s(F_t(x)) = F_s(x) = x$

こんな感じ.
加えて $A$ は閉集合である.
そのことを示すために前に [この記事](http://cympfh.cc/taglibro/2017/06/11.html) で書いたことを使う.
つまり、

> $A$ の元からなる一様収束する列の収束値が常に $A$ に属するとき、$A$ は閉集合

これを使う.
今の場合これは自明で、収束する列 $\{a_i \in A\}$ の収束値を $a = \lim a_i$ とすると、
$F_a(x) = \lim F_{a_i}(x) = \lim x = x$ より、$a \in A$.

というわけで $A$ は $\mathbb{R}$ の閉部分群.

- 正の元 $a \in A$ が存在しないとき、
    - 負の元も存在しない ($-t \in A \implies t \in A$ なので)
    - 従って $A = \{0\}$
    - この場合、異なる2時刻で軌道が重なることが無いので自然に定理は成立
- $A \ne \{0\}$ すなわちある正の元 $a \in A$ が存在するとき

$$T = \inf \{a \in A : a > 0 \}$$

- とする
    1. $T>0$ のとき、 $A = \{nT : n \in \mathbb{N}\}$ が成立する
        - $\because$
            - $T \in A$ 及び $\{nT\} \subseteq A$ は自明
            - $\exists a \in A \setminus \{nT\}$ とすると、$\exists n, 0 < |a - nT| < T$
            - $A$ の群性より $|a - nT| \in A$
            - $T$ より小さい正の元があるということは $T$ を $\inf$ で定めたことに違反
            - というわけで、 $\emptyset = A \setminus \{nT\} \iff A \subseteq \{nT\}$
    2. $T=0$ のとき、 $A=\mathbb{R}$
        - $\because$
            - $\inf=0$ より、$0$ に収束する列 $\{a_i\}$ が作れる
            - これを用いて $\mathbb{R}$ に稠密な $\{ n a_i : n \in \mathbb{N} \}$ が作れる (有理数が実数に稠密なのと同様)
            - $A$ は閉集合でかつ $\mathbb{R}$ に稠密なんで、$A=\mathbb{R}$ である
                - でなければ開集合 $\mathbb{R} \setminus A \subseteq \mathbb{R}$ が存在して稠密であることに反するから
            - ただし、$A=\mathbb{R}$ であるというのは要するにフローが $t$ に関して定値関数ということ
            - 今、このケースは除外しているので、無視してよい

## ベクトル場からフローの導出

先程はアイソトピーからベクトル場を導いた.
従ってフローからベクトル場を導くこともできる.
ここでは逆に、一定の条件下でベクトル場 $X_t$ からフロー $F_t$ を導けることを言う.

> 言ってしまえばこれは
> $F(t_0, x) = x$ の初期条件下で
> $\frac{d}{dt} F(t, x) = X_t(t, F(t, x))$
> という微分方程式の解 $F$ を求めることに他ならない

### 存在と一意性

一定の条件下で解 $F$ は存在して一意である.

<div class=thm>
開区間 $(a,b) \subset \mathbb{R}$ と
$\mathbb{R}^n$ の中の開集合 $U$ に関する有界連続関数
$$X : (a,b) \times U \to \mathbb{R}^n$$
があって $X(t, x)$ は $x$ に関してリプシッツ連続だとする.
すなわち
$$\exists L>0, \forall t,x_1,x_2, \|X(t,x_1)-X(t,x_2)\| < L \|x_1-x_2\|$$
だとする. このとき、
適当な十分小さい $\epsilon$ があって
$$F: (t - \epsilon, t + \epsilon) \times K \to U$$
であって

- $F(t_0, x) = x$
- $\frac{dF}{dt}(t, x) = X(t, F(x, t))$

なるものが存在する.
ただし $K$ は任意の $U$ の部分コンパクト集合.
($\forall K, \exists \epsilon, \exists F$.)
</div>

証明は略.
微分方程式を頑張って解くだけ.

### 導出

実際に導く過程は、フローからベクトル場を導いた過程の逆をするだけ.

ベクトル場 $X_t : M \to M$ について、これを
$$X_t(x) = \sum_i \xi_i(t, x) \frac{\partial}{\partial x_i}$$
という成分表示する.

求めたいフロー $F_t$ について、適当な局所座標で挟んで
$$\left(\psi \circ F_t \circ F_{t_0}^{-1} \circ \phi^{-1}\right) = f(t, x) =
\left[ \begin{array}{c} f_1(t, x) \\ \vdots \\ f_m(t, x) \\ \end{array} \right]$$
とする.
$f_i$ は $[0, 1] \times \mathbb{R}^m \to \mathbb{R}$ という実関数である.

このとき、
$$\frac{\partial}{\partial t} f_i(t, \xi_i(t, x)) = \xi_i(t, x)$$
ただし初期条件 $f_{t_0}^i(x) = x$ の下で解いて更に $f_i$ から $F_t$ を求める.

割と気合だけど、
一意性だけは保証されているので、頑張って1つ見つければよい.

### 例

例題として、$\mathbb{R}$ の上のベクトル場
$$X_t(x) = \frac{\partial}{\partial x}$$
を考える.

$X_t$ を成分表示すると $\xi(t, x) = 1$ なる定数関数なので
$\frac{\partial}{\partial t} f(t, \xi(t, x)) = \frac{\partial}{\partial t} f(t, x)$.
従って $f(xt, ) = t + C$ (積分定数).
初期条件より $f(t, x) = t - t_0 + x$.
$F_t(x) = t + x$ とすると (天啓)、
$F_t(F_{t_0}^{-1}(x)) = F_t(- t_0 + x) = t - t_0 + x = f(t, x)$ と合ってるのでこれが解.

### (出来ない) 例

あくまでも一定の条件下でしかフローは導けない.
次は出来ない例.
$$X_t(x) = x^2 \frac{\partial}{\partial x}$$

成分表示をして
$$\xi(t, x) = x^2.$$

$\frac{\partial}{\partial t} f(t, \xi(t, x)) = \xi(t, x)$
すなわち
$\frac{\partial}{\partial t} f(t, x^2) = x^2$
の解は実は
$$f(t, x) = \frac{x}{1 - xt} + C$$
である.

これを用いてフロー $F_t(x)$ を探したいが、
それよりも $f$ が $t=1/x$ の時に定義されてないのでダメ.


% 坪井 多様体 - 多様体上のフロー
% 2017-05-28 (Sun.)
% 数学 幾何学

## ベクトル場

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

### ベクトル場

多様体 $M$ の上のベクトル場とは点 $x \in M$ にベクトルを与えるものである.
すなわちベクトル場 $X$ とは
$$X : M \to TM$$
$$X : x \mapsto (u \in T_xM)$$
なる写像のこと.

## アイソトピーを生成するベクトル場

アイソトピー $F_t$ からベクトル場 $X_t$ を導くことが出来る.
流れとしては逆だけど「ベクトル場 **が** アイソトピーを生成する」と表現する.

```dot
digraph {
    node [shape=plaintext];
    bgcolor=transparent;
    rankdir=LR;
    x0 -> y0 [label=F];
    x1 -> y1 [label=F];
    x0 [label="t0, x"];
    x1 [label="t1, x"];
    y0:se -> y1:ne [color=red];
    {rank=same x0 x1}
    {rank=same y0 y1}
}
```

すなわち、アイソトピーとは写像が時刻に関して変化するものだと言えるが、
定義域の点 $x$ を固定すると、時刻の変化に伴って点 $y$ が移動するものである.
とすると、これは曲線のことであり、それは正にベクトルのことである.

基準点として $F(t_0, x) = y_0$ を取る.

これを $t$ の関数と見做し、すなわち
$$y(t) = F(t, x) = F_t(x)$$
と思ってこれを $t$ で微分した導関数の $t=t_0$ での値が、いま述べたベクトルである.
そのベクトルを $X_{t_0}$ と書く.
立式すると次の通り:
$$X_{t_0}(x) = \frac{\partial F_t}{\partial t} (t_0, x)$$

ただしこれはベクトル場としては誤っている.
ベクトル場は $x \in M$ を引数にし、$x$ から生えるベクトルを返す関数である.
今の場合で言うと引数は $x$ ではなくて $y$ である必要がある.
なぜなら返すベクトル (曲線) が通るのは $y$ だから.
そこで $F_{t_0}(x) = y$ の逆関数を合成することで修正する:
$$X_{t_0}(y) = \frac{\partial F_t}{\partial t} (t_0, F_{t_0}^{-1}(y))$$
注意深くη変換すると次を得る.

$$X_{t_0} = \frac{\partial F_t}{\partial t} (t_0) \circ F_{t_0}^{-1}$$
$t_0$ を一般にパラメータ $t$ と書きなおして
$$X_{t} = \frac{\partial F_s}{\partial s} (t) \circ F_{t}^{-1}$$

#### 展開

これをより分解した形に展開することを考える.

$t$ を $(t_0 - \epsilon, t_0 + \epsilon)$ の範囲で動かした時に
$F(t, x)$
が描く曲線は
$$\gamma(t) = F(t, x) = F_t(x)$$
で、これは $y_0 = F(t_0, x)$ を通る.

この $\gamma$ は暗にパラメータ $x$ を取ってるがベクトル場を作ることを見越して、
パラメータ $y$ を取るようにしておくと先ほどと同様に
$$\gamma_y(t) = \gamma(t, y) = F(t, F_{t_0}^{-1}(y)) = F_t \circ F_{t_0}^{-1}$$
とする.

<div class="thm">
**復習**

多様体 $M$ の上で、
値が局所座標 $(U, \varphi=(x_1, x_2, \ldots, x_m))$ に収まってるような曲線 $\gamma$
($\gamma(t_0) = x_0$ とする) があるとする.
これをベクトル $u \in T_{x_0}M$ とするとき、基底表示すると次のようになる.

- $f = \varphi \circ \gamma : [0,1] \to \mathbb{R}^m$ とおく
    - 値の第$i$成分へのみの写像を $f_i$ で書く

$$u = \sum_i \frac{d f_i}{dt}(t\!=\!t_0) \frac{\partial}{\partial x_i}$$
</div>

$\gamma_y(t)$ をベクトル場として書く.
$f(t, y) = \varphi \circ F_t \circ F_{t_0}^{-1}$
と置いて
$$X_{t_0} = \sum_i \frac{d f_i(t;y)}{dt}(t_0) \frac{\partial}{\partial x_i}.$$

> ただし $f_i(t;y)$ は $y$ を与えた下で $t$ 1引数の関数というニュアンスで書いたけど、要するに
> $\frac{d f_i(t;y)}{dt} = \frac{\partial f_i(t, y)}{\partial t}$ です.

というわけで、アイソトピー $F_t$ があって、適当な $t_0$ を与えると、そこからベクトル場 $X_{t_0}$ を導ける.

これは $y \in M$ が与えられた時に $X_{t_0}(y) \in T_yM$ となる形で書いているが、
$y$ はその局所座標 $y_1, y_2, \ldots, y_m$ で与えられることが普通なので、次の形で書くほうが便利かもしれない.

$f = \varphi \circ F_t \circ F_{t_0}^{-1} \circ \varphi^{-1}$
について
$$X_{t_0} = \sum_i \frac{d f_i(t; y_1, y_2, \ldots, y_m)}{dt}(t\!=\!t_0) \frac{\partial}{\partial x_i}.$$

#### 例

局所座標でいきなり書く (或いはユークリッド空間の上の多様体を考える).
$$F_t : \mathbb{R}^2 \to \mathbb{R}^2$$
$$F_t(x, y) = (e^t x, e^{-t}y)$$
が導くベクトル場がどんなものか考える.

1. $f = \varphi \circ F_t \circ F_{t_0}^{-1} \circ \varphi^{-1} = (e^{t - t_0} x, e^{t_0 - t}y)$.
1. $X_{t_0} = \left( e^{t - t_0}(t\!=\!t_0) ~ x, e^{t_0 - t}(t\!=\!t_0) ~ y \right) = (x, y)$.

ベクトル場 $X_{t_0}$ を求めた時点でパラメータ $t_0$ を改めて $t$ と置いて $X_t$ などと書くが、
この例では $X_t = (x, y)$ となって $t$ に依存しない形に偶然なった.

## フロー

アイソトピー $F_t$ のパラメータ $t$ を $[0,1]$ に制限していたが $\mathbb{R}$ 全体で考える.
$F_t$ が群 $\mathbb{R}$ の $M$ への作用になっているとする.
すなわち、 $F_0$ が恒等写像で (これは定義から既に成立している)、
$F_s \circ F_t = F_{s + t}$ となっていること.
特に $F_{-t}$ が $F_{t}$ の逆写像.
このような $\mathbb{R}$ の作用のことをフローと呼ぶ.

フローはやはり先程と同様にあるベクトル場によって生成される.

<div class="thm">
フローの性質から
$$F_t(x_0) = F_{t - t_0}(F_{t_0}(x_0)).$$
両辺を $t$ で偏微分すると
$$\frac{\partial F(t, x_0)}{\partial t} = \frac{\partial F(t - t_0, F_{t_0}(x_0))}{\partial t}.$$
これに $t=t_0$ を代入すると
$$\frac{\partial F}{\partial t}(t_0, x_0) = \frac{\partial F}{\partial t}(0, F_{t_0}(x_0)).$$
ここで、$F_{t_0}(x_0) = y_0 \iff x_0 = F_{t_0}^{-1}(y_0)$ と置けば、
$$\frac{\partial F}{\partial t}(t_0, F_{t_0}^{-1}(y_0)) = \frac{\partial F}{\partial t}(0, y_0)$$
を得る.
更に更に $F_0$ が恒等写像であることを思い出して、
$$\frac{\partial F}{\partial t}(t_0, F_{t_0}^{-1}(y_0)) = \frac{\partial F}{\partial t}(0, F_0^{-1}(y_0)).$$
これに前の章の一番最後の「ところで」を適当することで
$$X_{t_0}(y_0) = X_0(y_0)$$
を得る.
$y_0$ は $t_0$ と独立に決められるので一般に
$$X_{t_0} = X_0$$
となる. $t_0$ も自由に決められるので、結局、ベクトル場 $X_t$ は $t$ に依存しない形になっている.

これがフローの重要な性質.
</div>

## ベクトル場からフローの導出

先程はアイソトピーからベクトル場を導いた.
従ってフローからベクトル場を導くこともできる.
ここでは逆に、一定の条件下でベクトル場 $X_t$ からフロー $F_t$ を導けることを言う.

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
- $\frac{\partial F}{\partial t}(t, x) = X(t, F(x, t))$

なるものが存在する.
ただし $K$ は任意の $U$ の部分コンパクト集合.
($\forall K, \exists \epsilon, \exists F$.)
</div>


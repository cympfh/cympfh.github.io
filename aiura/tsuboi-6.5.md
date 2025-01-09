% 坪井 多様体 &sect;6.5 - 連結多様体上のフロー
% 2017-07-16 (Sun.)
% 幾何学 微分幾何

## 連結の定義

$M$ が連結でないとは、2つの開集合 $U_1, U_2$ で

- $M = U_1 \cup U_2$
- $U_1 \cap U_2 = \emptyset$

とできることを言う. 連結であるとはこれの否定.

## 単球中のフロー

$\mu$ を $C^\infty$ 級の $\mathbb{R}^m \to \mathbb{R}$ なる関数であって
$$\begin{cases}
\mu(x) \gt 0 & \text{when} & \|x\| \lt 1 \\
\mu(x) = 0 & \text{when} & \|x\| \geq 1 \\
\end{cases}$$

下図のような関数

```@gnuplot
set grid
set xrange [-1.2:1.2]
set yrange [-0.001:0.4]
rho(x) = exp(-1 / x)
mu(x) = abs(x) > 1 ? 0 : rho(1 - x ** 2)
plot mu(x)
```

これを使って、多様体 $\mathbb{R}^m$ の上にベクトル場
$$X = \mu \frac{\partial}{\partial x_1}$$
が定まる. これが生成するフローを $F_t$ とする.
このフローがどんなものか考える.

下図は二次元の場合の、 $x_2=0$ 上だけでのベクトル場を図示したもの.

```@gnuplot
set grid
set xrange [-2:2]
set yrange [-1:1]
rho(x) = exp(-1 / x)
mu(x) = abs(x) > 0.999 ? 0 : rho(1 - x ** 2)
plot "<seq -1 .2 1" using 1:(0):(mu($1)):(0) w vectors not
```

ちょっとこういうのはベクトルの方向が被ってるとわかりにくいので上向きにすると


```@gnuplot
set grid
set xrange [-2:2]
set yrange [-1:1]
rho(x) = exp(-1 / x)
mu(x) = abs(x) > 0.999 ? 0 : rho(1 - x ** 2)
plot "<seq -2 .1 2" using 1:(0):(0):(mu($1)) w vectors not
```

こんな感じ.
ベクトル場は常に $x_1$ 方向であるが、 $\|x\|=1$ な境界に近づくほどその大きさはゼロに近づき、境界より外では完全にゼロになる.
その連続性故、ちょうど境界上であってもベクトルはゼロになる.

$F_t$ はこれに従って流れるフローで、単球より内側にある点は時刻に従って $x_1$ 方向に動くが、その速度は境界に近づくに連れて遅くなるので
$\lim t \to \infty$ の極限において初めて境界に到達する.
本当か?
つまり有限時間で到達はできないのか?

**単球の外にあるとき**

$\|x\| > 1$ なる点 $x$ においてはベクトルは $X(x)=0$.
$F_t(x)$ の $t$ に関する連続性から、
$t$ の微小区間 $(-\epsilon, \epsilon)$ での $F_t(x)$ の軌道は、$x$ のある近傍 $U$ に収まっていて、
$\epsilon$ を十分小さく取ることで、$U$ を単球より外における.
つまり、$U$ の中でベクトルは常にゼロ.

$\frac{d}{dt}F(t,x)=0$ なる $t$ においては $F(t,x)=x$ だから、今の場合、$(-\epsilon, \epsilon)$ において、
$F$ は $t$ に関して定値関数である.
この $\epsilon$ という値は $t$ に依らずに決められる定数なので、$(-\epsilon, \epsilon)$ の区間を伸ばしていくことができる.
つまり、
$0 < t < \epsilon$ に対して $(t - \epsilon, t + \epsilon)$ という区間でも同じことが言え、
定値関数である区間を $(\epsilon, t + \epsilon)$ に伸ばせる.
これを無限回繰り返すことで結局、$\mathbb{R}$ 全体で $t$ に関して定値関数であると言える.

$$F_t(x) = x$$

球の外にある点は動かない.

**単球の境界上にあるとき**

$\|x\|=1$ なる点 $x$ を考える.
$x_1$ が正側にあるなら先ほどと同様に、$t$ の区間 $(0, \infty)$ では $F_t$ は定値関数.

マイナス方向には、$x_1$ を少しでも動かすとベクトルがゼロでなくなるので、定値関数ではような気もする.
任意の $t>0$ について $F_t(x) = x$.
$F_{-t}$ を掛けることで $x = F_{-t}(x)$ なので、マイナス方向に時刻を動かしても実は定値関数.

$$F_t(x) = x$$

**単球の内側にあるとき**

ゼロでない $x_1$ 方向のベクトルがあるので単球の内側にある限り、常に $x_1$ 方向に動く.
ただし有限時間で境界上に到達はしない.
なぜなら、 $F_t(x)$ が境界上にあるなら、境界上の点から有限時間 $-t$ で球の内側に写って、先ほどと矛盾するから.

$$x < F_t(x) < x^*$$

ただし $x^*$ は $x_1$ 成分だけが $x$ より大きい点で $\|x^*\|=1$ なる点.

**まとめ**

ある点 (今の場合原点) を中心とする単球 $B$ を台に持つ
($B$ より内側では一方向へのフローが流れる)
ようなベクトル場を構成することができた.

## 連結成分の同値関係

ある多様体の上の2点に就いて、
微分同相な写像で写りあうことを同値関係として定めると、
連結成分の上の2点は同値である.
すなわち次の定理を主張する:

### 定理

<div class=thm>
連結多様体 $M$ の上の2点 $x_1, x_2$ について微分同相写像であって
$$F(x_1) = x_2$$
なる $F : M \to M$ が存在する.
</div>

#### 証明

$M$ を先のような同値類で割る.
商集合 $M/\sim$ の各元は
$$A(x) \equiv [x] = \{ y : F(x) = y, F \text{ is diffeo } \}$$
などと書ける.

各 $A(x)$ は開集合である.
なぜなら、各 $y \in A(x)$ に対して先ほどのように単球を作ってその中でフローを流すことで、単球の中の点を全て同値に出来るから
(フローは微分同相写像).

$M/\sim$ の元が2つ以上あると、連結であることに違反する.
従って $A(x) = M$ が成立する.
すなわち任意の2点はある微分同相写像で写り合う.

### 系

<div class=thm>
相異なる $n$ 点の2組

- $x_1, x_2, \ldots, x_n$
- $y_1, y_2, \ldots, y_n$
    - $x_i \ne x_j, y_i \ne y_j$

に就いて、ある微分同相写像 $F$ によって
$$F(x_i) = y_i$$
と出来る.</div>

#### 証明

先ほどの定理と、微分同相写像の合成は微分同相写像であることを用いる.
即ち、
$$F_i(x_i) = y_i$$
$$F_i(x_j) = x_j ~ (i \ne j)$$
となる微分同相写像 $F_1, F_2, \ldots, F_n$ を作って
$$F = F_1 \circ F_2 \circ \cdots \circ F_n$$
と構成出来る.

### 系

<div class=thm>
連結多様体 $M$ の任意の2点 $x_0, x_1$ について

- $F_0(x_0) = x_0$
- $F_1(x_0) = x_1$

なるフロー $F_t$ が存在する.</div>

#### 証明

今までのは微分同相写像なので単に合成するだけではフローにはならない
(フローとフローの合成は一般にはフローではない).

$x_0, x_1$ が一致してたら自明なので異なるとする.

先の系を用いる.
ある単球を台とするフロー $G_t$ と、球内の異なる2点 $y_0, y_1$ を取る.
ただし

- $G_0(y_0) = y_0$
- $G_1(y_0) = y_1$

となるようにする.
先ほどの系の結果から、
微分同相写像 $f$ によって

- $f(x_0) = y_0$
- $f(x_1) = y_1$

と出来る.
このとき
$$F_t = f^{-1} \circ F_t \circ f$$
で定める写像はフローである.

$$F_{s + t} = f^{-1} \circ F_s \circ f \circ f^{-1} \circ F_t \circ f = F_s \circ F_t$$
こんな感じで.

というわけで目的のフローを構成できた.

## ベクトル場の射影

2つのコンパクト多様体 $M, N$ の間の $C^\infty$ 級写像 $F : M \to N$ があるとき、
接写像 $F_*$ が定まるのであった.
$M$ の上のベクトル場 $X$ に対して $N$ の上のベクトル場 $Y$ があって、
$$F_*(X(x)) = Y(F(x))$$
が成立するとき、$X$ が $F$ によって $Y$ に **射影された** と表現する.

### 定理

<div class=thm>
$M$ 上のベクトル場 $X$ が写像 $F$ によって $N$ 上のベクトル場 $Y$ に射影されるとする.
$X, Y$ が生成するフローを $\phi_t, \psi_t$ とするとき、次が成立する.
$$F(\phi_t(x)) = \psi_t(F(x))$$
</div>

#### 証明

接射像の定義から
$$\frac{d}{dt} F \left( \phi_t(x) \right) = F_* \left( \frac{d}{dt} \phi_t(x) \right)$$
$\phi_t$ は $X$ に生成されるフローなので
$$= F_* \left( X(\phi_t(x)) \right)$$
射影の仮定より
$$= Y(F(\phi_t(x))).$$

$Y$ が生成するフロー $\psi_t$ はこれが成立する下で、 $Y$ についての微分方程式
$$\frac{d}{dt} \psi_t (x) = Y(\psi_t(x))$$
を解けば良いのだが、正にゴールであるところの
$$F(\phi_t(x)) = \psi_t(F(x))$$
なる $\psi_t$ がこれを満たす.

なぜなら、
$$\begin{align*}
\frac{d}{dt} \psi_t (F(x)) & = \\
\frac{d}{dt} F \left( \phi_t(x) \right)
& = Y(F(\phi_t(x))) \\
& = Y(\psi_t(F(x))) \\
\end{align*}$$

$t=0$ において初期条件も満たしていることが分かる.

となるので. なのでその $\psi_t$ は1つの解になっているが、解の唯一性より、これが生成されるフローである.

### 定理

<div class=thm>
コンパクト多様体 $M$ から実数への写像
$f : M \to \mathbb{R}$
で、 $[a, b]$ が $f$ の正則値とする.
このとき
$f^{-1}([a, b])$
と
$f^{-1}(a) \times [a, b]$
とは微分同相.
</div>

#### 証明

時刻に従って一様に $f$ の値が増えるようなフローを $M$ の上に作ると、具体的に微分同相写像を構成することが出来る.
即ち、以下のような $F_t$ を構成出来る.
$F_t$ は自由に逆関数を作れるが $f$ は明らかに逆関数を持たないことに註意.

```@dot
digraph {
    rankdir=LR;
    node [shape=plaintext];
    bgcolor=transparent;

    subgraph cluster_2 {
        style=filled; color="#f0fff0";
        label="R";
        a -> "a+t";
    }

    subgraph cluster_1 {
        style=filled; color="#fff0ff";
        label="M";
        x -> "x'" [label=Ft];
    }

    x -> a [label=f];
    "x'" -> "a+t" [label=f];
}
```

$[a,b]$ が正則値であるとは即ち、
$f^{-1}([a,b]) \to [a,b]$
において $f$ は full rank であるということ.
今の場合は
$$\exists i, \frac{\partial}{\partial x_i} (f \circ \varphi^{-1})(x) \ne 0$$
ということ.
これを使うと $f$ を座標に用いることが出来る.

区間 $[a,b]$ に少しだけ余裕をもたせることで
正則である開区間 $(a - \epsilon, b + \epsilon)$ を与える.
$f$ の連続性とコンパクト性からそのような $\epsilon$ がある.

$M$ の被覆として、$f^{-1}((a - \epsilon, b + \epsilon))$ に完全に含まれる
$\{U_i\}_{i=1,\ldots,k}$
(コンパクト性から有限個としてよい)
と、
$M \setminus f^{-1}([a,b])$ に完全に含まれる
$\{V_j\}$
とに分けて其々に局所座標を与える.

$V_j$ の方はどうでもいい.
$(U_i, \varphi_i)$ について、
$\varphi_i$ の第1座標 $(x_1)$ を $f$ に取り替えて出来る局所座標を $\varphi_i'$ とする.
これが座標として妥当であるためには座標変換の微分が full rank であることが必要十分で、

$$\begin{align*}D \left( \varphi_i' \circ \varphi_i^{-1} \right)
& = \left[ \begin{array}{cccc}
\frac{\partial}{\partial x_1} f \circ \varphi_i^{-1} &
\frac{\partial}{\partial x_2} f \circ \varphi_i^{-1} &
\cdots &
\frac{\partial}{\partial x_n} f \circ \varphi_i^{-1} \\
\frac{\partial x_2}{\partial x_1} &
\frac{\partial x_2}{\partial x_2} &
\cdots &
\frac{\partial x_2}{\partial x_n} \\
\cdot & \cdot & \cdots & \cdot \\
\frac{\partial x_n}{\partial x_1} &
\frac{\partial x_n}{\partial x_2} &
\cdots &
\frac{\partial x_n}{\partial x_n}
\end{array}\right] \\
& = \left[ \begin{array}{cccc}
\frac{\partial}{\partial x_1} f \circ \varphi_i^{-1} &
\frac{\partial}{\partial x_2} f \circ \varphi_i^{-1} &
\cdots &
\frac{\partial}{\partial x_n} f \circ \varphi_i^{-1} \\
0 & 1 & \cdots & 0 \\
0 & 0 & \cdots & 0 \\
\cdot & \cdot & \cdots & \cdot \\
0 & 0 & \cdots & 1
\end{array}\right]
\end{align*}$$

というわけで $\frac{\partial}{\partial x_1} (f \circ \varphi_i^{-1}) \ne 0$ でありさえすれば良い.
そうであるとは限らないが、そのような第 $i$ 成分が少なくとも一つはあることが正則性から保証されているので、
成分を適当に交換してから第一成分を $f$ にすることで、妥当な局所座標を作れる.

このような座標に取り替えた
$\{(U_i, \varphi_i')\}_i$
について 1 の分割 $\lambda_i$ を設けて、ベクトル場
$$X = \sum_i \lambda_i \frac{\partial}{\partial x_1^i}$$
及びそれが生成するフロー $F_t$ を考える.
$x_1^i$ は $\varphi^i$ の第 1 座標のこと.

問題の実関数 $f$ を多様体 $M$ から多様体 $\mathbb{R}$ への写像と見做す.
$f$ は $f_*$ によってベクトル場 $X$ を $\mathbb{R}$ の上のベクトル場 $Y$ に射影する.
具体的には
$$f_*(X(x)) = Y(f(x))$$
$f_*$ であるが、今 $x \in M$ の第一成分が $f$ そのものなので
$$Df = \left[ 1, 0, \cdots, 0 \right]$$
というわけで
$$f_* \left( \sum a_i \frac{\partial}{\partial x_i} \right) = a_i \frac{\partial}{\partial t}$$
ここで $t$ は $\mathbb{R}$ の上の座標.

$$\begin{align*}
Y(f(x))
& = f_*(X(x))
& = f_* \left( \sum \lambda_i(x) \frac{\partial}{\partial x_1^i} \right) \\
& = \sum \lambda_i(x) \frac{\partial}{\partial t} \\
& = \frac{\partial}{\partial t}
\end{align*}$$

$f$ はその範囲では full rank 故、全射であるので、これは単に
$$Y(y) = \frac{\partial}{\partial t}$$
と書けて、これが生成するフローは正に
$$G_t(y) = y + t$$
となる.

以上で、ちょうど $f$ で $\mathbb{R}$ に射影するとそれが定ベクトル場 (等速のフロー) になるような、
$M$ の上のベクトル場/フロー を作ることが出来た.

前の定理を適用して、$F_t, G_t$ について
$$f(F_t(x)) = G_t(f(x))$$
が成立している.
$G_t$ が今わかっているのでそれを代入して
$$f(F_t(x)) = f(x) + t$$

このフロー $F_t$ は次の重要な性質を持っている.
ある点 $x_0$ で $f(x_0) = a$ となるとき、
$$f(F_{b - a}(x_0)) = f(x_0) + (b-a) = b.$$

下図再掲.
$f$ の逆関数は作れないが、$F_t$ 及び $G_t$ (実数の加算) は逆関数が作れるのでなんとかなるのだ.

```@dot
digraph {
    rankdir=LR;
    node [shape=plaintext];
    bgcolor=transparent;

    subgraph cluster_2 {
        style=filled; color="#f0fff0";
        label="R";
        a -> "a+t";
    }

    subgraph cluster_1 {
        style=filled; color="#fff0ff";
        label="M";
        x -> "x'" [label=Ft];
    }

    x -> a [label=f];
    "x'" -> "a+t" [label=f];
}
```


このフローを使うと次が言える.

まず順方向の写像:
$$f^{-1}(a) \times [a,b] \to f^{-1}([a,b])$$
$$(x, t) \mapsto F_t(x)$$
ただし $f(x) = a$.

この逆写像を作る.

- $x' = F_t(x)$
- $f(x) = a$

を解けば良い.

$f(x') = f(F_t(x)) = f(x) + t = a + t$
より
$t = f(x') - a$.

$x = F_{-t}(x') = F_{-f('x)+a}(x')$

というわけで、

$$f^{-1}([a,b]) \to f^{-1}(a) \times [a,b]$$
$$x' \mapsto (F_{-f('x)+a}(x'), f(x') - a)$$

で元に戻る.

以上で微分同相写像が構成できた.


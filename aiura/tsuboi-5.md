% 坪井 多様体 &sect;5 - 多様体上の関数
% 2017-05-20 (Sat.)
% 数学 幾何学

## index

<div id=toc></div>

## notation

多様体 $M$ から $N$ への $C^\infty$ 級関数全体を $C^\infty(M,N)$ と書く.
またユークリッド空間への関数全体 $C^\infty(M, \mathbb{R})$
を単に $C^\infty(M)$ と書く.
本章では主にこのユークリッド空間への関数を取り扱う.

関数 $f \in C^\infty(M)$ の台 (support) とは
$$\mathrm{supp} f = \overline{\{x \in M : f(x) \ne 0 \}}$$
のことと定義する.
ただしここで、位相空間の集合 $X$ に対して $\overline{X}$ とは $X$ の閉包
(極大の閉集合, $X \subseteq \overline{X}$).

集合 $X$ に対して $\mathrm{int}X$ で $X$ の内部
(極大の開集合, $\mathrm{int}X \subseteq X$) を表す.

## 定理

<div class=thm>
多様体 $M$ とその上の任意の点 $x_0$ 及び $x_0$ の任意の近傍 $V$ に対して、
次のような関数 $\mu \in C^\infty(M)$ がある.

- $\forall x \in M, \mu(x) \geq 0$
- $\mu(x_0) > 0$
- $\mathrm{supp}\mu \subseteq V$
    - $\iff \forall x \not\in V, \mu(x) = 0$
</div>

すなわち任意の点の周りでだけ正でその他でゼロであるような関数であって、
かつその台は望むだけ狭くできるような関数を作る方法が存在する.

台の領域に関しては局所座標に関して作ればよく (連続関数なので)、
$\varphi(V) \to M \to \mathbb{R}$
の関数として

$$\rho(x) = \begin{cases}
\exp(-\frac{1}{x}) & \text{ when } x>0 \\
0
\end{cases}$$

これを使う.
$x$ 軸と傾きゼロで接しているのが大事.
左に $\varphi^{-1}$ を合成して、$x=0$ が $x_0 \in M$ に写るようにして、
$\mu(x) = \rho(1 - \|x\|_2)$
みたいに使う.

<center><img src="http://i.imgur.com/mCS1Pwt.png" /></center>

上図の緑色.
$\|x\| \geq 0$ であって、この領域では問題なく $C^\infty$ 級.
この図では $\|x\| <1 \iff \mu(x) > 0$.
これを適当にスケーリングすることで、台を十分狭く出来る.

## 定理

先の $\mu$ は台にいわば上限を与える制約しかない.
次の定理はより強い関数があることを言う.

<div class=thm>
多様体 $M$ のある近傍 $U$ とその部分集合でコンパクトな $K (\subseteq U)$ があるとする.
次のような $C^\infty$ 級関数 $\nu_1: M \to \mathbb{R}$ がある.

- $\nu_1(x) \geq 0$
- $\mathrm{supp}f \subseteq U$
    - $\iff \forall x \not\in V, \mu(x) = 0$
- $\forall x \in K, \nu_1(x) > 0$
</div>

一番最後の要請によって台の下限が $K$ として与えられている.

$K$ をコンパクトとしてるのが肝で、有限個の $\mu$ を足し合わせることで実現できる.

## 定理

更に強く出来る.

<div class=thm>
先ほどと同様に、近傍 $U$ とそのコンパクト部分集合 $K$ について、次の関数 $\nu$ がある.

- $0 \leq \nu(x) \leq 1$
- $\mathrm{supp}f \subseteq U$
    - $\iff \forall x \not\in V, \mu(x) = 0$
- $\forall x \in K, \nu(x) = 1$
</div>

次のように作れる.

$(U, K)$ に関して先ほどの $\nu_1$ を作り、
$(U \setminus K, \mathrm{supp} \nu_1 \setminus \mathrm{int}(\mathrm{supp} \nu_1))$
に関して作った $\nu_1$ を $\nu_2$ と名付ける.
$K_2 = \mathrm{supp} \nu_1 \setminus \mathrm{int}(\mathrm{supp} \nu_1)$ はコンパクトであることに註意.

こうすると、

- $\forall x \not\in \mathrm{supp} \nu_1, \nu_1(x) = 0 \land \nu_2(x)=0$
- $\forall x \in K_2, \nu_1(x) > 0 \land \nu_2(x) > 0$
- $\forall x \in K \setminus K_2, \nu_1(x) > 0 \land \nu_2(x) = 0$

とできる.
というわけで、
$$\nu(x) = \begin{cases}
\frac{\nu_1(x)}{\nu_1(x) + \nu_2(x)} & \text{ when } x \in \mathrm{int}(\mathrm{supp}(\nu_1 + \nu_2)) \\
0 & \text{ otherwise}
\end{cases}$$

によって実現できる.

## 微分 (ライプニッツ則)

ある多様体$M$ の上の関数全体
$C^\infty(M)$
は自然にベクトル空間と見做すことが出来る.
すなわち、
$f, g \in C^\infty(M)$
と実数 $\alpha, \beta$ について
$$(\alpha f + \beta g)(x) = \alpha f(x) + \beta g(x)$$
とすればよい.

また関数の乗算を次のように値の乗算として定義しておく.
$$(f \cdot g)(x) = f(x) \cdot g(x)$$

さて線形関数
$D : C^\infty \to \mathbb{R}$
について次の性質 (これをライプニッツ則と呼ぶ) が成り立つと仮定する.
$$D (f \cdot g) = Df \cdot g(p) + f(p) \cdot Dg$$
ここで $p$ は適当な点.
$Df, Dg$ は実数であることに註意.
ライプニッツ則が成立する $D$ 全体を $\mathcal{D}_p$ と書く.

### $\mathcal{D}_p$ は線形空間

$D_1, D_2 \in \mathcal{D}_p$ について、
$\alpha D_1 + \beta D_2$ もまた、ライプニッツ則を満たすことから
$\mathcal{D}_p$ に属する.
従って $\mathcal{D}_p$ は線形空間である.

### 微分はライプニッツ則を満たす

ライプニッツ則がいかにもそういう形をしてたから当然だけど.

<div class=thm>
関数 $f : M \to \mathbb{R}$ に対して、ある $M$ 上の曲線 $c$ を用いて
$$f \mapsto \frac{d f \circ c}{dt}(t=t_0)$$
はライプニッツ則を満たす線形関数である.
</div>

微分に関して親しんだいくつかの性質は実はライプニッツ則さえ成立すれば成り立つ.

### 命題

<div class=thm>
$M$ 上の関数 $f$ がある開集合 $U$ の上で $f|_U=0$ だったとき、
点 $p \in U$ に対して、
任意の $D \in \mathcal{D}_p$ を用いて
$$Df = 0$$
が成立する.
</div>

前章で示したことから、
$\mathrm{supp}(g) \subseteq U$ なる関数 $g$ が存在して、
$f \cdot g = 0$ となる.
$D$ の線形性から $D(fg)=0$ である.

ライプニッツ則から
$D(fg) = Df \cdot g(p) + f(p) \cdot Dg$
であるが、左辺は0、$f(p)=0$ より、
$Df \cdot g(p) = 0$
を得、今 $g(p)$ は一般に非ゼロなので結局 $Df=0$ を得る.

## 方向微分

点 $p$ の周りの局所座標 $(U, \varphi)$ に対して、曲線
$$c_i : t \mapsto \varphi^{-1}(0,\ldots,0,t,0,\ldots,0)$$
による微分
$$D_{c_i} = \left(f \mapsto \frac{d f\circ c_i}{dt}(t=0)\right)$$
これのことを
$$\frac{\partial}{\partial x_i}$$
と名付け、 **方向微分** と呼ぶ.

### 命題

<div class=thm>
$\frac{\partial}{\partial x_i}$ と $\frac{\partial}{\partial x_j}$ ($i \ne j$) とは一次独立である.
</div>

<div class=thm>
多様体 $M$ の次元が $m$ で
$\varphi : x \mapsto (x_1, x_2, \ldots, x_m)$
に対して $m$ 個の方向微分
$$\left\{
\frac{\partial}{\partial x_i}
\right\}_{i=1,2,\ldots,m}$$
が $\mathcal{D}_p$ の基底になっている.
</div>

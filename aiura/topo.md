% 位相
% 2017-03-11 (Sat.)
% 集合位相
% 位相をやります

## index
<div id=toc></div>

## 位相の定義

位相空間 $X$ とは、集合 $X$ に **位相 (開集合系)** $\mathcal O_X$ を与えたもののことである.
ただし、位相 $\mathcal O_X$ とは
$\mathcal O_X \subseteq P(X)$ (冪集合)
であって、次の3つを要請するもの

1. $\emptyset, X \in \mathcal O_X$
1. **有限** の添字族 $\Lambda$ について $\forall \lambda \in \Lambda, U_\lambda \in \mathcal O_X \implies \bigcap_{\lambda \in \Lambda} U_\lambda \in \mathcal O_X$
1. (無限を許す) 添字族 $\Lambda$ について $\forall \lambda \in \Lambda, U_\lambda \in \mathcal O_X \implies \bigcup_{\lambda \in \Lambda} U_\lambda \in \mathcal O_X$


$\mathcal O_X$ の元のことを $X$ の開集合 (open set) と言う.
また補集合が開集合であるもののことを閉集合 (closed set) と言う.

- $U \in O_X \iff U$ is open
- $X \setminus U \in O_X \iff U$ is closed

注意として、開集合でかつ閉集合であるということがある.
その自明なものとして $\emptyset, X$.

### (註) 無限個の積について

有限個の開集合の積は開集合とし、
無限 (以下) 個の開集合の和を開集合とする.

直感的に、開集合とは、実数空間で言うと (例えば) 開区間 $(a, b)$ のようなものである.
$U_n = (-1/n, 1/n)$
それぞれは開集合であるが、これの可算無限個の積
$$\bigcap_{n=1}^\infty U_n = \{0\}$$
を開集合として認めたくない.

## 連続写像の定義

集合 $X, Y$ 間の写像
$$f: X \to Y$$
に対して、逆像
$$f^{-1}(V) = \{ x \in X : f(x) \in V \}$$
を定義する.
これは点を点に写すような $f^{-1}: Y \to X$ なる逆写像とは異なることに註意.

このような $f^{-1}$ が、$Y$ における開集合を$X$ における開集合に写すとき、
すなわち、
$$\forall V \in \mathcal O_Y, f^{-1}(V) \in \mathcal O_X$$
となるとき、$f$ を **連続写像** という.

## 部分位相

### 補題

<div class="thm">
集合 $X$ に関して2つの位相
$\mathcal O_X, \mathcal O_X'$
があるとき、この積
$\mathcal O_X \cap \mathcal O_X'$
もまた位相である.
</div>

1. $(\emptyset, X \in \mathcal O_X) \land (\emptyset, X \in \mathcal O_X')$ より $\emptyset, X \in \mathcal O_X \cap \mathcal O_X'$
1. $\forall i \in I, (U_i \in \mathcal O_X) \land (U_i \in \mathcal O_X')$ のとき、
    - $\bigcap_i U_i \in \mathcal O_X \land \bigcap_i U_i \in \mathcal O_X'$
    - したがって、 $\bigcap_i U_i \in \mathcal O_X \cap \mathcal O_X'$
1. $\bigcup$ も同様

### 部分位相の定義

位相空間 $X$ とその部分集合 $Y$ があるとき、
$Y$ に **自然に** 位相を導入することができる.
これを **部分位相** という.
すなわち、

$$\mathcal O_Y = \{ U \cap Y : U \in \mathcal O_X \}$$

と定める.
これが位相であることは確認できる.

## 商位相

位相空間 $X$ と集合 $Y$ との間に全射

$$p : X \to Y$$

があるとき、次のように $Y$ に位相を導入することが出来る.

$$\mathcal O_Y = \{ p(U) : U \in \mathcal O_X \}$$

これが位相であることは確認でき、この位相のとき $p$ は連続写像になる.
この位相は、$p$ を連続たらしめる位相の中に (包含に関して) 最大の位相である (小さいほど連続になりやすいことに註意).

## コンパクト

### 被覆

位相空間 $X$ の被覆とは、
$X$ の開集合の族
$\{U_i\}_{i \in I}$
であって、

$$\bigcup_i U_i = X$$

なるもののこと.

### コンパクトの定義

位相空間 $X$ がコンパクトであるとは、
$X$ の任意の被覆
$\{U_i\}_{i \in I}$
について、有限個の
$\{U_i\}_{i \in J}$
を適切に選べば、これが尚も $X$ の被覆と出来ること.
すなわち、有限集合 $J$ がって、

$$\bigcup_{j \in J} U_j = X$$

と出来ること.

### 例

1. $\mathbb{R}$ はコンパクトではない
1. $(0, 1) \subseteq \mathbb{R}$ はコンパクトではない
    - $\mathbb{R}$ から部分位相を導入してることに註意
1. $[0, 1] \subseteq \mathbb{R}$ はコンパクトである
1. $[0, 1] \cap \mathbb{Q} \subseteq \mathbb{R}$ はコンパクトでない

#### 証明

コンパクトでないことの証明は、実際に反例を一つ与えればよい.
すなわち、その中の有限個では被覆できない点があるような被覆を与えれば良い.

- $\mathbb{R} = \bigcup_{i \in \mathbb{Z}} U_i$
    - where $U_i = (i-1/2-\epsilon, i+1/2+\epsilon)$
- $(0, 1) = \bigcup_{i \in \mathbb{N}} U_i$
    - where $U_i = (1/n, 1)$
- $[0, 1] \cap \mathbb{Q} = \bigcup_{i \in \mathbb{N}} U_i$
    - where
        - $U_i = ([0, r - 1/n) \cap (r + 1/n, 1]) \cap \mathbb{Q}$
        - $r$ は無理数で $0 < r < 1$

コンパクトであることの証明は辛い.

$[0,1]$ がコンパクトであることの証明を行う.
$[0,1]$ の被覆 $\{U_i\}_i$ が与えられたとする.
$0 \leq x \leq 1$ について、
命題「閉区間 $[0,x]$ が有限個で被覆できる」を $P(x)$ とする.
$X = \{x : 0\leq x \leq 1, P(x) \}$
について、これは実数の部分集合であるので、
$\sup X$ が存在する (これは有理数については言えない).

$\sup X = r < 1$ とする.
$r \in [0,1]$ を被覆する $U_i$ が存在するので、
$P(r + \epsilon)$ が成立し、
$\sup X = r$ に矛盾する.
従って $\sup X=1$ が言える.

## 補題 0

<div class="thm">
$X$ が開集合であることと、
$\forall x \in X, \exists U \text{ is open }, x \in U \subseteq X$
とは同値.
</div>

$(\Rightarrow)$ の証明:
任意の点 $x \in X$ について $U=X$ とすれば、$x \in X \subseteq X$ が自明に成立する.

$(\Leftarrow)$ の証明:
点 $x$ に対して $x \in U \subseteq X$ なる $U$ を $U_x$ と名付けると、
開集合の公理から $\bigcup_{x \in X} U_x$ は開集合であるが、これがちょうど $X$ と一致する. 従って $X$ は開集合である.

## 補題 1

<div class="thm">
ハウスドルフ空間 $X$ の部分集合 $Z$ がコンパクトなとき、$Z$ は閉集合.
</div>

$X \setminus Z$ が開集合であることを示す.
開集合であることを示すのに先の補題 0 を用いる.
すなわち、
任意の点 $x \in X \setminus Z$ に対して、

$$\exists U \text{ is open }, x \in U \subseteq X \setminus Z$$

を示せば良い.

$X$ がハウスドルフ空間であることから、
点 $x \in X$ と
点 $z \in X \setminus Z$ に対して
それらを分離するような

- $z \in U_z$
- $x \in V_z$
- $U_z \cap V_z = \emptyset$

がある.
さて、 $Z$ の全ての点 $z$ に対して

$$\{ U_z \cap Z \}_{z \in Z}$$

は ($Z$ の部分位相に於いて) $Z$ の被覆であるが、$Z$ のコンパクト性より、ある有限の点集合$Z'$ を以って

$$\{ U_z \cap Z \}_{z \in Z'}$$

が $Z$ の被覆である.
これに対応して

$$V = \{ V_z \}_{z \in Z'}$$

は、$Z$ と積を持たない.
また、有限個の積であるから、開集合.

結局、任意の $x \in X \setminus Z$ に対して、

$$x \in Z \subseteq X \setminus Z$$

なる開集合 $Z$ が得られた.

従って、$X \setminus Z$ は開集合である.

## 補題 2

<div class="thm">
コンパクト集合の部分閉集合はコンパクトである.
</div>

コンパクト集合 $X$ についてその部分集合 $Z \subseteq X$ には部分位相を入れていることに註意.
$Z$ に任意の被覆 $\{U_i\}_i$ を与えた時、
ちょうど

$$\{ U_i \}_i \cap \{ X \setminus Z \}$$

は、$X$ の被覆になっている. ここで、$Z$ が閉集合 (補題 1) であるから、$X \setminus Z$ は開集合であることを用いてる.
$X$ のコンパクト性故、

$$\exists J, \{ U_i \}_{i \in J} \cap \{ X \setminus Z \}$$

によって、$X$ を被覆する. このときに

$$\exists J, \{ U_i \}_{i \in J}$$

によって $Z$ が被覆できる. 従って、$Z$ はコンパクト.

## 補題 3

<div class="thm">
コンパクト集合の連続写像による像はコンパクト.
</div>

2つの位相集合 $X, Y$ の間に連続写像 $f : X \to Y$ があるとき、
$f(X)$ は $Y$ の部分集合であるが、
部分位相を入れる時、$f(X)$ はコンパクト集合である.

証明は 補題 2 とほぼほぼ同様.

## 定理

<div class="thm">コンパクト集合からハウスドルフ空間への全単射な連続写像は同相を与える</div>

コンパクト集合 $X$ からハウスドルフ空間 $Y$ への写像
$$f : X \to Y$$
を考える.
これが連続写像であることから、自然に

$$f^{-1} : \mathcal O_Y \to \mathcal O_X$$

が定まる.
同相であることを示すには逆写像も連続であることを示せばよい.
そのためには、

$$f : P(X) \to P(Y)$$
$$f(U) = \{ f(x) : x \in U \}$$

これが開集合を保つ、つまり、

$$f : \mathcal O_X \to \mathcal O_Y$$
$$\forall U \in \mathcal O_X, f(U) \in \mathcal O_Y$$

と、開集合を開集合に写していればよい.

今の場合、
開集合を開集合に写すことは、閉集合を閉集合に写すことと等しい.
なぜなら、$f$ は全単射なので.

- 閉集合 $Z \subseteq X$ に対して、$f(Z)$ が閉集合であることを示す.
    1. 補題 2 より、$Z$ はコンパクトである.
    1. 補題 3 より、$f(Z)$ はコンパクト
    1. 補題 1 より、$f(Z) \subseteq Y$ は閉集合

以上より示された.

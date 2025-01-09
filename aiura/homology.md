% ホモロジー
% 2017-01-07 (Sat.)
% 幾何学

十分大きな $N$ についてユークリッド空間 $\mathbb{R}^N$ 中の図形を考える.

## index

<div id=toc></div>

## notation, definitions

1. 図形とは $\mathbb{R}^N$ 中の点の集合のこと
    - 例えば点や線分は図形である
1. 図形 $X$ が凸集合であるとは、
    - $\forall x, y \in X, \forall \alpha (0 \leq \alpha \leq 1), \alpha x + (1 - \alpha) y \in X$
    - とあること
1. いくつかの図形 $X_1, X_2, \ldots, X_m$ 全てを含む最小の凸集合を
    - $|X_1, X_2, \ldots, X_m|$
    - と書く. 区切りのコンマは雰囲気で付けたり付けなかったりする
1. $m$ 点 $\lambda_1, \lambda_2, \ldots, \lambda_m$ が一般的な位置にあるとは、ベクトル $\overrightarrow{\lambda_i \lambda_j}$ $(i \lt j)$ 全てが互いに一次独立であること

## $n$ 単体

$n$ 単体と呼ぶ図形を次のように定義する.

一般的な位置にある $n+1$ 点
$$\lambda_0, \lambda_1, \ldots, \lambda_n$$
を含む最小の凸集合
$$|\lambda_0, \lambda_1, \ldots, \lambda_n|$$
を $n$ 単体と呼ぶ.

単体のメタ変数に $\sigma, \tau$ 等を用いる.

$n$ 単体全体を $\Delta^n$ と書く.
例えば $\Delta^0$ とは点全体で、$\Delta^1$ とは線分全体のこと.
$\Delta^2$ は内部も含む三角形のこと.
内部を含まない三角形は凸集合でないので単体ではない.

### 辺単体

$n+1$ 点 $\lambda_0, \lambda_1, \ldots, \lambda_n$ で表現される単体
$$\sigma = |\lambda_0, \lambda_1, \ldots, \lambda_n|$$
に就いて、
この $n+1$ 点から適当に異なる $q+1$ 点選んで作る
$$\tau = |\lambda_{i_0}, \lambda_{i_0}, \ldots, \lambda_{i_q}|$$
は $q$ 単体である ($q \leq n$).
この $\sigma, \tau$ の関係を
$$\tau \preceq \sigma$$
と書いて、$\tau$ は $\sigma$ の辺単体であると言う.

> 明らかに
> $\tau \preceq \sigma \Rightarrow \tau \subseteq \sigma$
> である

例えば $\Delta^0$ は $\Delta^n$ の辺単体である.
$\Delta^1$ はまさに $\Delta^2$ の **辺** そのものであり、3つ含まれる.

<center>
<table class="no-border-table"><tr><td>
```@dot
graph {
    rankdir=LR; bgcolor=transparent;
    a [shape=point];
}
```
</td><td>
$\preceq$
</td><td>
```@dot
graph {
    rankdir=LR; bgcolor=transparent;
    a -- b
    a [shape=point];
    b [shape=point];
}
```
</td><td>
$\preceq$
</td><td>
```@dot
graph {
    rankdir=LR; bgcolor=transparent;
    a [label="" shape=triangle style=filled];
}
```
</td></tr></table>
</center>

## 複体

複体とは単体の組み合わせで表現する図形のことである.

複体 $X$ とは単体の集合であり、
$$\forall \sigma \in X. \forall \tau \preceq \sigma. \tau \in X$$
を満たすもののこと.

図形を辺や頂点に分解すると考えると分かりやすい.
例えば次のような内部を含まない三角形は

<center>
<table class="no-border-table"><tr><td>

```@dot
graph {
    rankdir=LR; bgcolor=transparent; splines=false;
    a [label="" shape=triangle];
}
```

</td><td>$=$</td><td>

```@dot
graph {
    rankdir=LR; bgcolor=transparent; splines=false;
    v1 [shape=circle];
    v2 [shape=circle];
    v3 [shape=circle];
    v1 -- v2 [label="e1"];
    v2 -- v3 [label="e2"];
    v3 -- v1 [label="e3"];
}
```

</td></tr></table>
</center>

- 3つの頂点 ($\Delta^0$)
    - $v_1, v_2, v_3$
- 3つの辺 ($\Delta^1$)
    - $e_1, e_2, e_3$

から構成される複体
$$\{v_1, v_2, v_3, e_1, e_2, e_3\}$$
と表現される.

## (1次元) 複体のホモロジー

$1$ 単体までしか含まない複体を考える.
つまり頂点と辺からなる図形である.

複体 $X$ について
$$C_n(X) = \bigoplus_{\sigma \in X, \sigma \in \Delta^n} \mathbb{R} \sigma$$
を定める.

例えば今の三角形ならば、

- $C_0(X) = \mathbb{R} v_1 + \mathbb{R} v_2 + \mathbb{R} v_3 \cong \mathbb{R}^3$
- $C_1(X) = \mathbb{R} e_1 + \mathbb{R} e_2 + \mathbb{R} e_3 \cong \mathbb{R}^3$

となる.
このように $C_n$ は図形をベクトル空間に写す写像である.

> 複体 $X$ にある頂点の集合を $V$ 、辺の集合を $E$ とすると、
> $C_1(X) \cong \mathbb{R}^{|E|}$,
> $C_0(X) \cong \mathbb{R}^{|V|}$.

### 向き付け

複体 $X$ の中の各 $n$ 単体 $\sigma (\in X)$ に向きを定める.

向きというのは $\Delta^n$ に対して、有り得る向きの集合を後述するように定める.
「複体に向きをつける」とは
含まれる各単体に、ありえる向きからちょうど1つを選んで与える、ということ.
予め一つの向きを与えておくことが重要なのであって、異なる向きを与えたからといって本質が変わるわけではない.

例えば 1 単体 $|uv|$ については $\{\overrightarrow{uv}, \overrightarrow{vu} \}$ の二通りの向きがありえて、そのどちらかを選んでおくのである.
1単体を2つ含む複体に向きをつける、と言うと、4通りありえる.

こういうこと:

<center>
```@dot
digraph {
    rankdir=LR; bgcolor=transparent; splines=false;
    node [shape=point];
    a -> b -> c;
    d -> e; e -> f [dir=back];
    g -> h [dir=back]; h -> i;
    j -> k [dir=back]; k -> l [dir=back];
    {rank=same a d g j}
    {rank=same b e h k}
    {rank=same c f i l}
}
```
</center>

#### $n=0$ 単体の向き

ただ一通りの向き $\{*\}$ がある.
これは省略して考える.

#### $n \geq 1$ 単体の向き

$n$ 単体に 2 通りの向きを与える.
2という数字は偶奇に由来するのだが、形式的には次のように定義される.
向きに関する notation も同時に定めておく.

$n$ 単体 $\sigma$ は $n+1$ 個の頂点によって
$$\sigma = |\lambda_0, \lambda_1, \ldots, \lambda_n|$$
と記述される.

凸集合としての $| \cdots |$ という記述は中に並べる図形の並び順はどうでもよいが
(例えば $|uv| = |vu|$)、
この順序のことを向きだと定義して、区別して考える.

先ほどの $n$ 単体では $n+1$ 点の並びを変えて
$$\sigma = |\lambda_{i_0}, \lambda_{i_1}, \ldots, \lambda_{i_n}|$$
とすることで、$\sigma$ に一つの向きをつけたことになる.

こうすると $n$ 単体の向きは $(n+1)!$ 通りありそうになるが、次のようにして $2$ 通りにする.

今見たように、 **向き** とは添字に関する **置換**
$$\left(\begin{array}{cccc}
0 & 1 & \cdots & n \\
i_0 & i_1 & \cdots & i_n \\
\end{array}\right)$$
のことに他ならない.

この置換が偶置換であるか奇置換であるかだけを見ることにする.
すなわち、
2つの向きがどちらとも偶置換である (またはどちらとも奇置換である) とき、それらは同じ向きだとする.

例えば 2 単体 $|uvw|$ の向きは次の二通りである

- (偶置換): $|uvw| = |vwu| = |wuv|$
- (奇置換): $|uwv| = |vuw| = |wvu|$

> 向き $|uvw|$ を基準にしたとき、
> $|uvw|$ が偶置換グループで、
> その中の2点を入れ替えたら奇置換グループで、
> さらにその中の2点を入れ替えたら偶置換グループである.
>
> もっとも、どれを基準にするかでどちらが偶置換でどちらが奇置換か分からないが、
> それはどうでもいい.

### 境界

境界を取るという操作
$$\partial: C_1(X) \to C_0(X)$$
$$\partial(ae) = av - au = a(v-u) ~~(a \in \mathbb{R})$$
を定める.
ここで $e$ は向き付きの 1 単体 $|uv|$ とする.

> イメージとしては $\partial$ とは $n$ 単体からその辺単体である $n-1$ 単体を取り出す操作であり、
> これをベクトル空間の上の操作として定義している.

$\partial$ は線形写像で、
行列表示ができて、
$$\mathrm{rank}\partial = \mathrm{dim}(\mathrm{Image}~\partial)$$
である.

### ホモロジー

先の $\partial$ は線形関数である.
そこで次を定義する.

- $H_1(X) = \mathrm{Ker} \partial$
- $H_0(X) = C_0(X) / \mathrm{Image} \partial$

> __部分群による商集合__  
> $(A, +)$ が群でその部分群 $B$ があるとき
> $x,y \in A$ について $x \sim y \iff x-y \in B$ という同値関係を使って
> $A/B = A/\sim$
> を定める.

#### 例

辺に与える向きを有向グラフぽく矢印で表現してく.

$X=$

```@dot
digraph {
    rankdir=LR; bgcolor=transparent; splines=false;
    node [shape=plaintext];
    v1 -> v2;
}
```

- 各ベクトル空間
    - $C_1(X) = \mathbb{R} e$
    - $C_0(X) = \mathbb{R} v_1 \oplus \mathbb{R} v_2$
- 境界
    - $\partial(ae) = a (v_2 - v_1)$
        - $\mathrm{Ker}~\partial = \{a=0\} = 0$
        - $\mathrm{Im}~\partial = \mathbb{R} (v_2 - v_1) \cong \mathbb{R}^1$
- 各ホモロジー
    - $H_1(X) = 0$
    - $H_0(X) = C_0(X) / \mathrm{Im}~\partial \cong \mathbb{R}^1$
        - この商集合においては $a v_1 \sim a v_1 + b (v_2 - v_1)$ であることに註意

#### 例

$Y=$

```@dot
digraph {
    rankdir=LR; bgcolor=transparent; splines=false;
    node [shape=plaintext];
    v1 -> v2 [label=e1];
    v2 -> v3 [label=e2];
}
```

- 各ベクトル空間
    - $C_1(Y) = \mathbb{R} e_1 \oplus \mathbb{R} e_2 \cong \mathbb{R}^2$
    - $C_0(Y) = \mathbb{R} v_1 \oplus \mathbb{R} v_2 \oplus \mathbb{R} v_3 \cong \mathbb{R}^3$
- 境界
    - $\partial(ae_1 + be_2) = a (v_2 - v_1) + b(v_3 - v_2)$
        - $\mathrm{Ker} \partial = 0$
        - $\mathrm{Im}~\partial = \mathbb{R} (v_2 - v_1) + \mathbb{R}(v_3 - v_2) \cong \mathbb{R}^2$
- 各ホモロジー
    - $H_1(Y) = 0$
    - $H_0(Y) = C_0(Y) / \mathrm{Im}~\partial \cong \mathbb{R}^1$

というわけでここで見てきた $X, Y$ で、
$H_0, H_1$
の次元だけを見ると、2つとも同じだという気附きがある.

#### 例

$Z=$

```@dot
digraph {
    rankdir=LR; bgcolor=transparent; splines=false;
    node [shape=plaintext];
    v1 -> v2 [label=e1];
    v2 -> v3 [label=e2];
    v3 -> v1 [label=e3];
}
```

- 各ベクトル空間
    - $C_1(Z) = \oplus_i \mathbb{R} e_i \cong \mathbb{R}^3$
    - $C_0(Z) = \oplus_i \mathbb{R} v_i \cong \mathbb{R}^3$
- 境界
    - $\partial(ae_1 + be_2 + ce_3) = a (v_2 - v_1) + b(v_3 - v_2) + c(v_1 - v_3)$
        - $\mathrm{Ker}~\partial = \{a=b=c\} \cong \mathbb{R}^1$
        - 関数の行列表示をすると
$$\partial = \left[\begin{array}{ccc}
-1 & & 1 \\
1 & -1 & \\
& 1 & -1
\end{array}\right]$$
            - であるので、$\mathrm{Im}~\partial = \mathrm{rank}~\partial = 2$
- 各ホモロジー
    - $H_1(Z) = \mathrm{Ker} \partial \cong \mathbb{R}^1$
    - $H_0(Z) = C_0(Z) / \mathrm{Im} \cong \mathbb{R}^{3-2} = \mathbb{R}^1$

### 考察

3つめの例 $Z$ で $\mathrm{Ker} \partial \ne 0$ な例を見た.
それは
$\partial(e_1 + e_2 + e_3) = 0$
であることに由来する.
すなわち、一周するようなベクトルが存在するということであり、所謂 **穴** に相当する.

さて $C_0/\mathrm{Im} \partial$ とは何か.
これは結局辺によって連結な点どうしは同一視するということである.

このような考察から、

- $\dim H_1(X) = \dim \mathrm{Ker} \partial$ は穴の数
- $\dim H_0(X) = \dim C_0 / \mathrm{Im} \partial$ は連結成分の数

を表現してるのだと分かる.

## (2次元) 複体のホモロジー

$2$ 単体までを含む複体を考える.
つまり頂点、辺、面からなる図形である.

### 境界

複体 $X$ について境界を取る2つの操作を定義する.

- $\partial_2: C_2(X) \to C_1(X)$
    - $\partial_2(|uvw|) = |uv| + |vw| + |wu|$ $(u,v,w \in \Delta^0)$
- $\partial_1: C_1(X) \to C_0(X)$
    - $\partial_1(|uv|) = v - u$ $(u,v,w \in \Delta^0)$

2つをまとめて単に $\partial$ と書いて区別しないこともある.
さらに架空の線形写像 $\partial_3, \partial_0$ を付け足して

$$0 \overset{\partial_3}{\to} C_2
\overset{\partial_2}{\to} C_1
\overset{\partial_1}{\to} C_0
\overset{\partial_0}{\to} 0$$

こういう連鎖した図式をよく描く.

> $\partial_i$ は全て線形写像として定めている.
> 付け足した架空の境界については
> $\partial_3(0)=0$,
> $\partial_0(x)=0$
> なる写像として定める.

### 境界の性質

<div class=thm>
架空に付け足した $\partial_3, \partial_0$ を含めて、
隣り合う境界を合成した写像はゼロ写像である:
$$\partial_i \circ \partial_{i+1} = 0$$
</div>

実際に確かめれば分かる.

$\begin{align*}
\partial_1 \circ \partial_2 (|uvw|)
& = \partial_1 (|uv| + |vw| + |wu|) \\
& = (v - u) + (w - v) + (u - w) \\
& = 0
\end{align*}$

他の $i$ はより自明.

この性質は
$$\mathrm{Im}~\partial_{i+1} \subseteq \mathrm{Ker}~\partial_i$$
を保証している.
次の章で
$\mathrm{Ker}~\partial_i~/~\mathrm{Im}~\partial_{i+1}$
と書いているが、この性質のおかげで、それが不都合なく定められる.

### ホモロジー

先ほど付け足した架空の $\partial_3, \partial_0$ を使うと、

- $H_2(X) = \mathrm{Ker}~\partial_2~/~\mathrm{Im}~\partial_3$
- $H_1(X) = \mathrm{Ker}~\partial_1~/~\mathrm{Im}~\partial_2$
- $H_0(X) = \mathrm{Ker}~\partial_0~/~\mathrm{Im}~\partial_1$

と出来る.
ここで
$\mathrm{Im} \partial_3 = 0$,
$\mathrm{Ker} \partial_0 = C_0$ なので、

- $H_2(X) = \mathrm{Ker}~\partial_2$
- $H_1(X) = \mathrm{Ker}~\partial_1 / \mathrm{Im}~\partial_2$
- $H_0(X) = C_0 / \mathrm{Im}~\partial_1$

と同じ.

#### 例

3点 $v_1, v_2, v_3$ を頂点に持つ複体
$$X = \{ v_1, v_2, v_3, |v_1 v_2|, |v_2 v_3|, |v_3 v_1|, |v_1 v_2 v_3| \}$$
<center>
```@dot
digraph {
    rankdir=LR; bgcolor=transparent; splines=false;
    node [shape=plaintext];
    a [label="" shape=triangle style=filled width=2 height=2];
}
```
</center>
について、

- 各ベクトル空間
    - $C_2(X) \cong \mathbb{R}^1$
    - $C_1(X) \cong \mathbb{R}^3$
    - $C_0(X) \cong \mathbb{R}^3$
- 境界
    - $\partial_2(a |v_1 v_2 v_3|) = a (|v_1v_2| + |v_2v_3| + |v_3v_1|)$
        - $\mathrm{Ker}~\partial_2 = 0$
        - $\mathrm{Im}~\partial_2 \cong \mathbb{R}^1$
    - $\partial_1(a |v_1 v_2| + b |v_2 v_3| + c |v_3 v_1|) = a (v_2 - v_1) + b(v_3 - v_2) + c(v_1 - v_3)$
        - $\mathrm{Ker}~\partial_1 = \{a=b=c\} \cong \mathbb{R}^1$
        - $\mathrm{Im}~\partial_1 \cong \mathbb{R}^2$ (一次元複体の例 $Z$ と同じ)
- 各ホモロジー
    - $H_2(X) = 0$
    - $H_1(X) = 0$
    - $H_0(X) \cong \mathbb{R}^1$

### 考察

1次元の時と全く同様に考察できる.
つまり、

- $\dim H_2(X)$ は空洞の数
    - 空洞とは面によって囲まれた空な三次元領域
- $\dim H_1(X)$ は穴の数
    - 穴とは辺によって囲まれた空な二次元的領域
    - ただしいくつかの面によって覆われているのならそれは穴ではない
        - 上手く形式的に言う言い方が分からない...
- $\dim H_0(X)$ は連結成分の数

を表現してるのだと分かる.

### オイラーの多面体定理

<div class=thm>
多面体とは穴が空いてなくて空洞がただ一つあり、連結な2次元複体 $X$ である.
頂点の数を $|V|$、
辺の数を $|E|$、
面の数を $|F|$ とするとき
$$|V| - |E| + |F| = 2$$
が成立する.
</div>

条件を形式的に書きなおすと次のようである:

- $C_2(X) \cong \mathbb{R}^{|F|}$
- $C_1(X) \cong \mathbb{R}^{|E|}$
- $C_0(X) \cong \mathbb{R}^{|V|}$
- $\dim H_2 = 1$ (空洞の数)
- $\dim H_1 = 0$ (穴の数)
- $\dim H_0 = 1$ (連結成分の数)

まず $H_n$ の定義から、
$$\dim(H_n) = \dim(\mathrm{Ker}~\partial_{n}) - \dim(\mathrm{Im}~\partial_{n + 1})$$

加えて線形数学の事実から、
$$\dim(\mathrm{Ker}~\partial_n) + \dim(\mathrm{Im}~\partial_n) = \dim(C_n)$$

これらから連立方程式を立てることが出来る.
書くのが辛いので、
$K_n = \dim(\mathrm{Ker}~\partial_n)$,
$I_n = \dim(\mathrm{Im}~\partial_n)$
と書く.

1. $1 = K_2 - I_3 = K_2$ ($I_3 = 0$ を代入)
1. $0 = K_1 - I_2$
1. $1 = K_0 - I_1 = |V| - I_1$ $(K_0 = |V|)$
1. $K_2 + I_2 = |F|$
1. $K_1 + I_1 = |E|$
1. $K_0 = K_0 + I_0 = |V|$ ($I_0 = 0$ を代入)

$I_3, I_0$ はゼロだから無視して他5つの変数が上の連立方程式でちょうど解ける.

1. $K_2 = 1$, $I_2 = |F| - 1$
1. $K_1 = |F| - 1$, $I_1 = |E| - |F| + 1$
1. $K_0 = |E| - |F| + 2$

これとは全然別に、
$$K_0 = \dim(\mathrm{Ker}~\partial_0) = \dim C_0 = |V|$$

だから、
$$|E| - |F| + 2 = |V|$$
を得る.
適当に項移して、初めの定理を得る.

<div class=thm>
穴が $g$ 個だけ空いた多面体 $X$ を考える.
頂点の数を $|V|$、
辺の数を $|E|$、
面の数を $|F|$ とするとき
$$|V| - |E| + |F| = 2 - 2g$$
が成立する.
</div>

多少、穴の数や空洞の数が変わっても、同様にして、$|V|, |E|, |F|$ の間の関係式を作ることが出来る.

普通、「多面体に穴が $g$ 個空いている」と言った場合、
多面体の表面のある地点から別のある地点まで連なった穴を言う.
ドーナツや円柱の側面に厚みを持たせたような形.

ホモロジー $H_1$ とは辺によって囲まれた閉路の数のことなので、今の場合、
$$\dim H_1 = 2g$$
とカウントする.

そこだけ修正して解き直すと定理を得る.

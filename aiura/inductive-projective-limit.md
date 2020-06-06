% 帰納極限, 射影極限
% 2018-11-14 (Wed.)
% 圏論

$\def\C{\mathcal C}\def\D{\mathcal D}\def\colim{\mathrm{colim}\;}\def\i{\hookrightarrow}\def\limD{D_{-\infty}}$

## INDEX
<div id=toc-level-2></div>

## 概要

極限を定義し, Sets における有向集合の圏の(余)極限が
[帰納極限](https://ja.wikipedia.org/wiki/%E5%B8%B0%E7%B4%8D%E6%A5%B5%E9%99%900)
及び
[射影極限](https://ja.wikipedia.org/wiki/%E5%B0%84%E5%BD%B1%E6%A5%B5%E9%99%90)
であることを説明する.
話は省略するが, Gr 圏でもこれらの極限やその射は群と群準同型射であるので成立する.

- 内容的には Wikipedia に書いてある事柄
- 圏論の話だからって可換図式ばっかり書かなくていいのでは?
    - 可換図式は一見とっつきやすく見せかけるだけであって, 中身は単に可換性の等式を言ってるだけなので式を直接書けばいいじゃん

## 準備

- 圏
    - 略
- 部分圏
    - 圏 $\mathcal D$ が $\mathcal C$ の部分圏であるとは, 射と対象について部分であって,
    - 射の合成について閉じていて
    - 全ての対象 $A \in \mathcal D$ には恒等射 $1_A$ があること

### 極限 (limit)

圏 $\C$ において, その部分圏 $\D$ の極限というものを定義してこれを $\lim \D$ と書くことにする.
定義は以下の通り.

対象 $X \in \C$ であって,
各対象 $D_i \in \D$ について
$\mu_i : X \to D_i$
が備わっている.
ただし $\D$ にある任意の射 $f_{ij} \colon D_i \to D_j$ について
$$\mu_j = \mu_i \circ f_{ij}$$
という可換性を要請する.

ただし更に次の普遍性と呼ばれる性質を要請する.

同様に対象 $Y \in \C$ であって
$$\sigma_j = \sigma_i \circ f_{ij}$$
なる $\sigma_i$ を備えるものがあったとき,
この $Y$ に対して, 射
$$\sigma \colon Y \to X$$
があって,
次の可換性
$$\sigma_i = \mu_i \circ \sigma$$
が全ての対象 $D_i \in \D$ について成り立っていること.
このような射 $\sigma$ の存在は唯一であることを要請する.

このとき, $X$ のことを $\D$ の極限と言って
$$X = \lim \D$$
と書く.
ただしこの $X$ には暗に射の集まり $(\mu_i)$ を備えさせる.

<center>
```dot
digraph {
    graph [bgcolor=transparent];
    node [shape=plaintext];
    edge [arrowhead=vee];
    rankdir=LR;
    Di -> Dj [label=f];
    X -> Di [label=μ_i];
    X -> Dj [label=μ_j];
    Y -> Di [label=σ_i];
    Y -> Dj [label=σ_j];
    Y -> X [label="!" style=dotted];
    { rank=same; X Y }
}
```
</center>

例えば積やイコライザーなどは, この形式で定義される概念であった.

また特に普遍性より,
極限の存在は同型を除いて一意.
つまり複数あっても互いに逆射があるので圏の言葉では区別が出来ない.

### 余極限 (colimit)

limit の定義の中で出てくる射の向きを全て反対に (双対に) して定義されるものを余極限と言って
$$X = \colim \D$$
と書くことにする.

念のために述べると,

- 可換性
    - $X$ には $\D$ の各対象 $D_i$ に対応して $\tau_i \colon D_i \to X$ が備わっていて可換性がある
- 普遍性
    - 同様の任意の $Y$ と $(\nu_i)$ に対して唯一 $\nu \colon X \to Y$ があって可換である

というもの.

例えば直和やコイコライザーが余極限である.

### 有向集合

集合 $X$ に次のような関係 $\leq$ を入れた $(X, \leq)$ を有向集合という.

- 前順序であること
    - $x \leq x$
    - $x \leq y \land y \leq z \implies x \leq z$
- フィルターであること (上に有界であること)
    - $\forall x, y, \exists z, x \leq z \land x \leq z$

### 帰納系

部分圏 $\D$ の対象がある添字集合 $I$ を以て
$$\D = \{ D_i \}_{i \in I}$$
と書けて, $I$ が有向集合であるとする.

$i \leq j$ のときに限ってちょうど一つの $f_{ij} : D_i \to D_j$ を持つような痩せた圏を帰納系と言う.

圏の制約から
$f_{ii} = 1$
であることや
$i \leq j \leq k \implies f_{jk} f_{ij} = f_{ik}$
であることに注意.

### 射影系

また射の方向を逆にして,
$i \leq j$ のときに限ってちょうど一つの $f_{ij} : D_j \to D_i$ を持つような痩せた圏を射影系と言う
(添字に注意).

## 帰納極限

帰納系 $\D$ が Sets の部分圏であるとする (つまり $D_i$ は集合).
このとき余極限 $\colim \D$ は実は次で与えられる.

$$\colim \D = D_{\infty} := \coprod_{i \in I} \left. D_i \right/ \sim$$
ただしここで $\sim$ は次のような同値関係.

$\coprod_{i \in I} D_i$ の元であって $D_i$ 由来であるようなものを
$(x ; D_i)$
と書くことにすると,
$$(x ; D_i) \sim (y ; D_j) \iff \exists k, k \geq i \land k \geq j \land f_{ik}(x) = f_{jk}(y)$$
で定義する.

ここで
有向集合のフィルター性から単に
$k \geq i \land k \geq j$
なる $k$ は常に存在することに注意.

また, ある $k$ で
$$f_{ik}(x) = f_{jk}(y)$$
となるのであればそれより大きな
$k' \geq k$
でも
$$f_{ik'}(x) = f_{kk'}f_{ik}(x) = f_{kk'}f_{jk}(y) = f_{jk'}(y)$$
が成り立つことに注意.

### 例

Sets における 帰納系と帰納的極限の単純な例を示す.

次のような帰納系 $\mathcal D$ を考える.
$$\emptyset \i \{0\} \i \{0,1\} \i \{0,1,2\} \i \cdots$$
添字は自然数全体 $\mathbb N$ (これは全順序集合なのでもちろん有向集合)であって,
各対象は $D_i = \{ m \in \mathbb N : 0 \leq m \leq (i-1) \}$.
射は全て包含射 $f_{ij}(m) = m$.

これについて上の $D_\infty$ は, 次のようになる:
$$D_\infty = \coprod_{i=0}^\infty \left. D_i \right/ \sim$$
ここで $i \leq j$ について,
$$(x ; X_i) \sim (y ; X_j) \iff f_{ij}(x) = y \iff x = y$$
なので $\sim$ は単に値を自然数として等しいか見るだけのものと思って良くて,
$$D_\infty = \bigcup_{i=0}^\infty D_i = \{0,1,2,\ldots \} = \mathbb N$$
が得られる.

今の場合に $\mathbb N$ がが確かに余極限であることを見てみる.

$\tau_i : D_i \to \mathbb N$ は包含射 $\tau_i(m) = m$ として定義すれば確かに可換:
$$\tau_i = \tau_j \circ f_{ij}$$
また別の $(Y, (\nu_i : D_i \to Y))$ があるとき,
$\nu : \mathbb N \to Y$
を次のように定義する.
任意の $m \in \mathbb N$ について,
$m \in D_{m+1}$
なので
$\nu_{m+1}(m) \in Y$
が定まる.
そこで
$$\nu(m) = \nu_{m+1}(m)$$
とする.
あきらかに
$$\nu_i = \nu \circ \tau_i$$
となって可換.

またこのような $\nu$ が唯一であることも可換性から言える.
(異なる $\nu'$ があるなら可換性が崩れる部分がどこかにあると言える.)

### 証明

Sets においてはこれが一般に成立することを示す.

- $D_\infty = \coprod_{i=0}^\infty \left. D_i \right/ \sim$
    - $\mu_i : D_i \to D_\infty$
    - $\mu_i(d) = (d; D_i)$

任意の $(Y, (\sigma_i : D_i \to Y))$ について

- $\sigma : D_\infty \to Y$
- $\sigma(d; D_i) = \sigma_i(d)$

以上が証拠になっている.

$\mu_i$ の可換性は次の通り.
$i \leq j$ のときに限り
$\D \ni f : D_i \in D_j$
が存在して,

- $\mu_j f_{ij} x = (f_{ij} x; D_j)$
- $\mu_i x = (x; D_i)$

であるが, $i \leq j$ より $(x; D_i) \sim (f_{ij} x; D_j)$.
よって $\mu_i = \mu_j f_{ij}$.

$\sigma$ の可換性は次の通り.
$\sigma \mu_i(x) = \sigma (x;D_i) = \sigma_i(x)$
より $\sigma \mu_i = \sigma_i$.
また結局この可換性から任意の $(x;D_i) \in D_\infty$ について
$\sigma(x;D_i) = \sigma_i(x)$
が必要なので $\sigma$ は唯一存在する.

## 射影極限

射影系 $\D = (\{ D_i ~;~ f_{ij}: D_j \to D_i \iff i \leq j \})$ の極限は
Sets においては次のような形で与えられ,
これを射影極限と呼ぶ.

$$\lim \D = \limD := \left\{
\left.
(x_i)_{i \in I} \in \prod_{i \in I} D_i
\right|
\forall i,j, i \leq j \implies
x_i = f_{ij}(x_j) \right\}$$

### 証明

これは帰納極限よりも単純.

$\tau_i$ は射影.

- $\tau_i : \limD \to D_i$
- $\tau_i((x_j)_j) = x_i$

任意の $(Y, (\nu_i : Y \to D_i))$ について

- $\nu : Y \to \limD$
- $\nu(y) = (\nu_i(y))_{i \in I}$

とすれば可換になる.
唯一性も明らか.

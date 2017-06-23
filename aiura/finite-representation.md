% 有限群の表現
% 2016-12-27 (Tue.)
% 数学 線形代数
% 表現論です

## INDEX
<div id=toc></div>

## 群

集合 $G$ が群であるとは積
$G \times G \to G$
が定められたもの.
積には次の3つのルールの成立を仮定する.

1. 結合則
    - $(gh)i = g(hi) = ghi$
1. 単位元 $e$ の存在
    - $eg = ge = g$
1. 逆元の存在
    - $\forall g. \exists g^{-1}. g g^{-1} = g^{-1} g = e$

### 命題.

$G$ が群であることと、

$$\forall g, h \in G. ~ g h^{-1} \in G$$

とは同値.

### 対称群

集合 $I_n = \{1,2,\ldots,n\}$ について、$I_n \to I_n$ の全単射は ($n$ 次の) 置換と呼ばれる.
置換全体を $n$ 次の **対称群** $S_n$ と呼ぶ.
その名の通り、これは群を成す. 積は関数合成. 単位元は恒等関数.

置換 $\sigma$ を

$$\left(\begin{array}\\
1 & 2 & \cdots & n\\
\sigma(1) & \sigma(2) & \cdots & \sigma(n)
\end{array}\right)$$

と書く.

### 巡回置換 (cycle)

$n$ 次の置換 $\sigma$ について、$\sigma$ は

$$J(k, \sigma) = \{k, \sigma(k), \sigma^2(k), \ldots, \sigma^{n-1}(k) \}$$

を巡回するように置換し、他の値を置換しないとき、

つまり、

- $\sigma^0(k) = k$
- $\sigma^m(k) \ne k$ $(1 \leq m \leq n - 1)$
- $\sigma^n(k) = k$

で、

- $\sigma(j) = j$ when $j \in I_n \setminus J(k, \sigma)$

というとき、
置換 $\sigma$ を

$$\left(\begin{array}\\
k & \sigma(k) & \sigma^2(k) & \cdots & \sigma^{n-1}(k)
\end{array}\right)$$

と書いて、 **巡回置換** と呼ぶ.
$n$ を $\sigma$ と長さと言う.

### 生成される群

ある条件 $\text{cond}$ の下で ($e$ とも) 相異なるいくつかの元 $a,b,\ldots$ に対して

$$\{
e, a, b, \ldots,
a^2, ab, ba, b^2, \ldots,
a^3, a^2b, aba, ab^2, ba^2, bab, b^2a, b^3, \ldots
\}$$

を、$a,b,\ldots$ が **生成** する群だといい、略記して

$$\langle a,b,\ldots | \text{cond} \rangle$$

と書く.

#### 例. 巡回群 $C_n$

ある元 $g$ について、ある自然数 $n$ があって

- $g^0 = e$
- $g^m \ne e$ $(1 \leq m \leq n-1)$
- $g^n = e$

のとき、

$$\langle g \rangle = \{e, g, g^2, \ldots, g^{n-1}\}$$

であるが、これを **巡回群** という.
位数 (集合のサイズ) は $n$ であり、$C_n$ と書く.

### Abel群

積の交換則
$$ab = ba$$
が成立する群をAbel群という.


#### 例. [Klein の四元群](https://ja.wikipedia.org/wiki/クラインの四元群)

とは、次の群のこと.

$$V_4 = \langle a,b | a^2=e, b^2=e, ab=ba, a\ne b \rangle$$

明らかにこれはAbel群である.

## 群の作用

特に置換に見られるように、群の成分には一つの操作を対応させることがしばしばある.
群の要素を手続きとみなした場合の関数適用を、「群の (左) 作用」という.

群 $G$ を集合 $S$ へ作用させる手続きを

$$\rho: G \times S \to S$$

と書く.
関数適用を

$$\rho(g, s) = g \circ s = g(s)$$

などと書く.

ただし群の作用には次の2つのルールを仮定する.

1. 単位元の作用は恒等写像
    - $\rho(e, s) = s$
1. 積の作用は関数合成
    - $\rho(g, \rho(h, s)) = \rho(g \circ h, s)$

## 準同型写像

群 $G$ から別な群 $G'$ への写像 $f: G \to G'$ であって、

$$f(gh) = f(g) f(h)$$

を満たすものをそう呼ぶ.

## 群の表現

体 $V$ の上の正則正方行列全体を $GL(V)$ と書く.
多くの場合、 $GL(V)$ とは、サイズが $n \times n$ で、成分が複素数な正則正方行列全体 $GL(n:\mathbb{C})$ のことだと思って構わない.
群 $G$ に対して、

$$\rho: G \to GL(V)$$

なる写像を、群 $G$ の **表現** という.
場合に依っては単に行き先 $GL(V)$ のその $V$ を $G$ の表現と言ったりもする.
行き先の行列のサイズ $n$ を、この表現の次元という.

### 例. $C_2$ の表現

位数 2 の巡回群とは $C_2=\{e,g\} (g^2=0)$ であるが、これの表現を具体的に与えてみる.

まず一次元表現の場合.
表現という写像の値域は $GL(1:\mathbb{C})$. これはゼロ以外の複素数のこと.
すなわち $\mathbb{C}^\times = \mathbb{C} \setminus \{0\}$.
定義域は $C_2$ であるので、
$\rho(e)$ および $\rho(g)$ を実際に与えれば表現を与えたことになる.
満たすべき性質はそれが準同型写像であることだけなので、

- $(\rho(e))^m = \rho(e)$ ($m$ は任意の自然数)
- $(\rho(g))^2 = \rho(e)$ ($g^2 = e$ より)

これらから

- $\rho(e)=1$
- $\rho(g) = \pm 1$.

従って二通りの表現が得られることが分かった.

一般に、任意の元を全て $\rho(e)$ (それは 1 ライクな値) に写すものは表現の一つになっていて、これを自明な表現 $\mathbb{1}$ と書くことにする.
対して $+1$ と $-1$ が交互に並ぶ感じのを $\mathbb{sgn}$ と書く.

今の場合、$C_2$ の一次元表現として $\mathbb{1}$ と $\mathbb{sgn}$ との2つが得られた.

次に二次元表現の場合.
値域は、普通に、行列式がゼロではない、複素 $2 \times 2$ 行列.
先と同様の考察から、

- $\rho(e) = I$ (単位行列)
- $\rho(g) = I, -I, \ldots$ (色々沢山)

自乗して $I$ になるような行列は色々ある.

どの表現になるかはこれ以上からは一意には定まらない.
次の例に話を続ける.

### 例. 対称式の表現

2変数 $x,y$ の一次式全体という集合 $V$ を考える:

$$V = \{ax+by : a,b \in \mathbb{C}\}.$$

この要素について、
$x, y$ を入れ替えるという操作 $g$ を含む群を

$$G = \{e,g\}$$

とする.
操作の意味から $g^2=e$ は自明.
従ってこの群自体は $C_2$ である.

さて、$V$ の要素 $ax+by$ は、$x, y$ を基底にとって

$$\left(\begin{array}\\a\\b\end{array}\right)$$

と書ける.
この時 $g$ の作用を

$$g \circ \left(\begin{array}\\a\\b\end{array}\right)
=
\left(\begin{array}\\b\\a\end{array}\right)$$

と書ける.
ここで $g$ をその表現で置き換えると

$$\rho(g) \circ \left(\begin{array}\\a\\b\end{array}\right)
=
\left(\begin{array}\\b\\a\end{array}\right)$$

となるが、ちょうどここに二次元表現が来ると、行列の演算であるように見える.
だとすると、$\rho(g)$ としてふさわしい行列は、一意に定まって

$$\left(\begin{array}\\
0 & 1\\1 & 0
\end{array}\right)
\left(\begin{array}\\a\\b\end{array}\right)
= \left(\begin{array}\\b\\a\end{array}\right)$$

とすべきだろう.
$\rho(g) = \left(\begin{array}\\
0 & 1\\1 & 0
\end{array}\right)$
としたわけであるが、これはちゃんと自乗したら $I$ になる行列.


ところで基底のとり方を $x, y$ としたが、別にそうする理由はない.
例えば $x+y, x-y$ という基底のとり方もあり得る.
この場合

$$g \circ \left(\begin{array}\\c\\d\end{array}\right)
=
\left(\begin{array}\\c\\-d\end{array}\right)$$

とすればいいだけなので、

$$\rho(g) = \left(\begin{array}\\
1&0\\0&-1
\end{array}\right)$$

という表現がふさわしく見える.

以上の例は、準同型の制約からは表現は一意に定まらないが、それらは所詮、基底のとり方で変わるだけだという主張を支えるものである.

## 定義. 部分表現

表現 $\rho: G \to GL(V)$ の部分表現 $W$ とは、
$W \subseteq V$ であって、
$w \in W$ への (左) 作用を考えた時に

$$\forall g.~ \forall w.~ g \circ w \in W$$

が成立するもの.
自明な部分表現として $V$ 自身と $\emptyset$.

## 定義. 既約表現

$V$ の部分表現として $V$ 自身と $\emptyset$ 以外の表現を持たないような $V$ を **既約表現** という.

## 定理. 表現の分解

有限群 $G$ とその表現 $V$ について、
$V$ は有限個の既約表現の直和に分解できる:

$$V = V_1 \oplus V_2 \oplus \cdots \oplus V_k$$

ここで、表現の直和とはデカルト積.

### 例. 対称式

例えば $V=\{ax+by\}$ は $V_1=\{a(x+y)\}$ と $V_2=\{b(x-y)\}$ とに分解できる.
すなわち、

$$
\left(\begin{array}\\
1 & 0 \\ 0 & -1
\end{array}\right)
\left(\begin{array}\\
a\\b
\end{array}\right)
=
\left(\begin{array}\\
1
\end{array}\right)
\left(\begin{array}\\
a
\end{array}\right)
\oplus
\left(\begin{array}\\
-1
\end{array}\right)
\left(\begin{array}\\
b
\end{array}\right)
$$

と言っている.

## 定義. 表現の間の射

群 $G$ の2つの表現 $V$ と $W$ の間の **射** $f: V \to W$ とは、線形写像であって、また群の作用について準同型なもののこと.

すなわち、
$g \in G$,
$v \in V$ について

$$f(g \circ v) = g \circ f(v)$$

すなわち、

<center>

```dot
digraph {
  bgcolor=transparent;
  node [shape=plaintext width=1.4 height=0.4 fixedsize=true];
  edge [arrowhead=vee];
  v -> fv [label=f];
  v -> gv;
  fv -> X;
  gv -> X [label=f];
  fv [label="f(v)"];
  gv [label="g・v"];
  X [label="f(g・v) = g・f(v)"]
  rankdir=TB;
  {rank=same v fv};
  {rank=same gv X};
}
```

</center>

$V \to W$ なる射全体を $\text{Hom}(V, W)$ と書く.

### 例. $C_2$ の一次元表現

には先程示したように $\mathbb{1}$ と $\mathbb{sgn}$ とがある.

- $\mathbb{1}(e) = 1$
- $\mathbb{1}(g) = 1$
- $\mathbb{sgn}(e) = 1$
- $\mathbb{sgn}(g) = -1$

$\mathbb{1} \to \mathbb{sgn}$ にどんな射があるだろうか.

射 $f$ は線形関数でないといけないとした.
一次元の上の線形関数はスカラー倍する関数
$f(x) = ax$
しかない.
準同型であるべきという制約から

- $f(g \circ v) = a(\mathbb{1}(g) v) = av$
- $g \circ f(v) = \mathbb{sgn}(g) (av) = -av$

これらが $v \in V$ で等しくある必要があるので、結局 $a=0$.
即ち、
$$f(x) = 0$$
なる射だけがあり得る.

### 例. 対称式の二次元表現

$V=\{ax+by\}$ の $x$ と $y$ を入れ替える操作 $g$ の表現.
先ほど見たように $x+y, x-y$ を基底に取ると、

$$\rho(g) = \left(\begin{array}\\1 & \\ & -1 \end{array}\right).$$

これを参考にして、$V \to V$ の射を調べる.
二次元表現の線形関数なので、$2 \times 2$ 行列 $A$ だと思えばいい.

- $A \rho(g) v = \rho(g) A v$
- $\Rightarrow A \left(\begin{array}\\1 & \\ & -1 \end{array}\right) = \left(\begin{array}\\1 & \\ & -1 \end{array}\right) A$
- $\Rightarrow A = \left(\begin{array}\\a & \\ & d\end{array}\right)$

従って $\text{Hom}(V, V) \simeq \mathbb{C}^2$ であることが分かる.

## 定義. 表現の同型

2つの表現 $V, W$ が同型 $V \simeq W$ であることを、次のように定める.
2つの表現の間の射

- $f: V \to W$
- $g: W \to V$

があって、$g \circ f = id_V$ , $f \circ g = id_W$ が成り立つこと.

## Schur (シューア) の補題

$G$ の2つの **既約** 表現 $V, W$ について次が成立する.

$$\text{Hom}(V,W) \simeq \begin{cases}
\mathbb{C} & \text{ when } V \simeq W \\
0 & \text{ otherwise }
\end{cases}$$

### 例. 対称式の二次元表現

明らかに $V \simeq V$ であるが先ほど見たように
$\text{Hom}(V, V) \simeq \mathbb{C}^2$ であった.
これから $V$ が規約ではないことが分かる.

## 定理. Abel群の既約表現は一次元

簡単な証明を与える.

Abel 群 $G$ の表現 $\rho: G \to GL(V)$ を考える.
$G$ の可換性と $\rho$ の準同型性から、

$$\rho(g) \rho(h) = \rho(gh) = \rho(hg) = \rho(h) \rho(g)$$

$\{ \rho(g) : g \in G \}$ もまた可換群であることが分かる.

ところで、

$$\rho(g) \rho(h) = \rho(h) \rho(g)$$

は $h$ という左作用をかける操作自体が $V \to V$ の射になっていることを言っている.

$$
\begin{array}\\
v          & \rightarrow^h & \rho(h, v) \\
\downarrow &               & \downarrow \\
\rho(g, v)  & \rightarrow^h & \rho(g) \rho(h, v)
\end{array}
$$

Schur の補題から
$\rho(h) \ni \text{Hom}(V,V) \simeq \mathbb{C}$.
スカラー倍するという関数だけで
？？？

メモ不明

### $C_n$ の既約表現の数

$C_n$ はAbel群なので、一次元表現、すなわち
$\rho: C_n \to C^\times$
だけを考えればよい.

$\rho(e) = 1$ は自明.
$\rho(g)$ を決めた場合、
$\rho(g^2), \rho(g^3), \ldots$
は自動的に定まるので、
結局 $\rho(g)$ の値を定めることが、$\rho$ を定めることになる.

満たすべき性質は、 $g^n = e$ なので、

$$\rho(g)^n = 1$$

$1$ の $n$ 乗根は一般に $n$ 個ある:

$$\rho(g) = 1, \omega, \omega^2, \ldots, \omega^{n-1}$$


ここで $\omega = \exp(2 \pi i / n)$.

従って、$C_n$ の既約表現は $n$ 通りあり得る.

### Abel群の規約表現の数

実はAbel群 $G$ の規約表現は、その位数 $\#G$ と同じ数だけ存在する.
そしてその表現の間の積を

$$(\rho_1 \times \rho_2)(g) = \rho_1(g) \times \rho_2(g)$$

と定めることで、表現全体という集合も群になる.

## 商群

群 $G$ とその部分群 $H$ があるとき、$H$ の下で $G$ の同値関係を

$$g_1 \sim g_2 \iff g_1 g_2^{-1} \in H$$
と定義する.
$G$ を $H$ で割った商群を
$$G/H = G/\sim = \{ [g] : g \in G \}$$
と定める.

$g_1 g_2^{-1} \in H \iff g_1 g_2^{-1} = h \iff g_1 = h g_2$
から、逆に、$g_2$ から同値クラスは $[g_2] = H g_2 (= \{ h g_2 : h \in H \})$
などと書ける.
そういうわけで、
$$G/H = \{ Hg : g \in G\}$$
というふうに書いたりもする.

$G/H$ は $G$ という集合の分割をしていると見ることもできる.
すなわち、

$$G = \bigcup Hg = He \cup H g_1 \cup \cdots \cup H g_m$$
$$G/H = \bigoplus Hg = He \oplus H g_1 \oplus \cdots \oplus H g_m$$

ここで $m$ は代表元の数.
そして明らかに $\#Hg = \#H$.
というわけで、位数に関して

$$\#G = m~\#H$$

これは次の定理を導く.

### ラグランジュの定理

群 $G$ の部分群 $H$ の位数は $\#G$ の約数

### 系.

群の左作用
$$G \times S \to S$$
$$(g, s) \mapsto g \circ s$$
について.

次を $s$ の $G$ 軌道という.

$$G s = \text{Orb}(s) = \{ g \circ s : g \in G \}$$

そして次を不動点という.

$$\text{Fix}(s) = \{ g : g \circ s = s \}$$

$\text{Fix}(s)$
は $G$ の部分群です.
なぜなら、
これが $G$ の部分集合なのは自明で、
また、
$\forall g,h \in \text{Fix}(s)$
について、
$(g h^{-1})(s) = g(h^{-1} \circ s) = g \circ s = s$ から $g h^{-1} \in \text{Fix}(s)$
が成立するので群.

> _N.B._ $G$ が群であることと $\forall g, h \in G. ~ g h^{-1} \in G$ は同値であった

ラグランジュの定理で $H=\text{Fix}(s)$ と思うと、

$$G = \text{Fix}(s) g_1 \cup \text{Fix}(s) g_2 \cup \cdots \cup \text{Fix}(s) g_k$$

ここで $g_1, g_2, \ldots, g_k$ は $G/\text{Fix}(s)$ の異なる代表元のつもり.
その個数 $k$ は実は $\#G s$ と一致する.

なぜなら、上の式で右から $s$ を掛けると、

- $G s = \text{Fix}(s) \circ g_1(s) \cup \text{Fix}(s) \circ g_2(s) \cup \cdots \cup \text{Fix}(s) \circ g_k(s)$
    - $= g_1(s) \oplus \cdots \oplus g_k(s)$
    - なぜなら $\text{Fix}(s) \circ g(s) = \{ h(g(s)) : h \in \text{Fix}(s) \} = \{ g(s) \}$

従って $\#Gs = k$.

以上から、

$$\#G = \#\text{Fix}(s) \times \#Gs$$

## 共役類

群 $G$ について $h \in G$ の共役類とは、

$$c(h) = \{ h g h^{-1} : g \in G \}$$

のこと.

### 群作用としての共役類

これも $G (\ni g)$ の $G (\ni h)$ への (左) 作用と見ることができる.
すなわち、

$$G \times G \to G$$
$$(g, h) \mapsto hgh^{-1}$$

とすると、$c(h)$ は $h$ の $G$ 軌道.
不動点は
$$Z_G(h) = \text{Fix}(h) = \{ g : hgh^{-1} = h \}$$

したがって、
$$\#G = \#c(h) \times \#Z_G(h)$$

### 同値関係としての共役類

共役類は同値関係を与える.
すなわち、
$$g \sim h \iff \exists i. h = i g i^{-1} \iff g \in c(h)$$

## 定理. 既約表現の個数について

$G$ の規約表現全体を $\hat{G}$ とする.

次の2つの定理がある:

$$\#G = \sum_{V \in \hat{G}} (\text{dim} V)^2$$

$$\# G \text{ の共役類} = \# \hat{G}$$

これらの定理を用いて、規約表現を頑張れば網羅して列挙できる.

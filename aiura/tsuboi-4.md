% 坪井 多様体 &sect;4 - 接空間
% 2017-02-21 (Tue.)
% 数学 幾何学
% 第4章です. 接空間とか接写像とか

## INDEX
<div id=toc></div>

## 曲線

$n$ 次元多様体 $M$ の上に貼られた曲線を考える.
とりあえず曲線 $c$ は次のように記述できるだろう.
写像の像ではなく写像そのものを曲線としていることに註意.

- 線分から $M$ への連続写像 $c: (a, b) \to M$

座標の時と同様に、$c$ を微分することは出来ない.
曲線 $c$ が通るある点
$c(t_0) = x_0 \in M$
を含む近傍 $U$ とその近傍座標 $\phi$ を用いれば
$\frac{d(\phi \circ c)}{dt}(t_0)$
という微分値を考えることは出来る.

$x_0 \in M$ を通る曲線 $c$ について、適当な $(U, \phi)$ を取って

$$\phi^* : c \mapsto \frac{d(\phi \circ c)}{dt}(t_0) (\in \mathbb{R}^n)$$

を定める.

またここでは、曲線は $\phi \circ c$ が $C^\infty$ 級なものに限ることにする.

### 目論見

- $x_0$ における **「接ベクトル」** を、$x_0$ を通る曲線で表現しようと考えている.
    - 接ベクトルとはその点を通る曲線のこと
    - 文字通り $M$ の上にベクトルを作ることはできないのでこうする
- その接ベクトルを分類する方法として $\phi^*$ を用いようと考えている.

### 座標のとり方について

今 $x_0$ に対して適当な一つの近傍座標 $(U, \phi)$ を取ったが、
別な近傍座標 $(V, \psi)$ もまた取れるとする $(x_0 \in U \cap V)$.

異なる2曲線 $c_1, c_2$ で、
$\phi^*(c_1) = \phi^*(c_2)$
が成り立っているとする.

座標を $\phi$ から $\psi$ に取り直した時、この関係は実は保存される.
なぜなら

$$\frac{d(\psi \circ c)}{dt}(t_0) = D(\psi \circ \phi^{-1})_{(\phi(x_0))} \frac{d(\phi \circ c)}{dt}(t_0)$$

である.
定数 (行列) 倍されるだけなので、イコール関係は保存される.

$$\begin{align*}
\phi^*(c_1) =& \phi^*(c_2) \\
\iff& \\
\psi^*(c_1) =& \psi^*(c_2) \\
\end{align*}$$

## 接ベクトル・接空間

$x_0 \in M$ での **接ベクトル** とは
$x_0$ を通る曲線 $c: [a,b] \to M; c(t_0) = x_0$ のこと.
$x_0$ を通る ($C^\infty$ 級の) 曲線全体を $C_{x_0}$ と書く.

ただし接ベクトルには
$\phi^*(c_1) = \phi^*(c_2)$
による同値関係を入れる.
この同値関係は局所座標のとり方に依らないことは先に確認した.

今同値関係を入れたので接ベクトル全体とは  $C_{x_0}/\sim$ である.
先の $\phi^*$ をこの商集合に導くと自明に単射 (その値で同値を定めてるので).

$$\phi^* : C_{x_0}/\!\sim \; \to \mathbb{R}^n$$
$$c \mapsto \frac{d(\phi \circ c)}{dt}(t_0)$$

と制限すると、同値関係から明らかに単射.
しかも次の事実から全射でもある.

任意のベクトル $v \in \mathbb{R}^n$ について
曲線 $c^v(t) = \phi^{-1}(tv + \phi(x_0))$
を構成すると $\phi^*(c^v) = v$.
というわけで $\phi^*$ は全単射.
従って $C_{x_0}/\!\sim$ と $\mathbb{R}^n$ は同型である.

> ただし曲線 $c^v$ は近傍 $U$ の範囲を超えない範囲である必要がある.
> なので厳密には十分に小さな区間を定義域として定義する必要がある.

同型故に $\mathbb{R}^n$ におけるベクトル空間として構成を $C_{x_0}/\sim$ に導くことで、これをベクトル空間とすることができる.
ベクトル空間としての $C_{x_0}/\sim$ を $$T_{x_0}M$$ と書き、我々はこれを **接空間 (接ベクトル空間)** という.

> つまり
> $\phi^*(\alpha_1 c_1 + \alpha_2 c_2) := \alpha_1 \phi^*(c_1) + \alpha_2 \phi^*(c_2)$
> と定める.

座標系を取り直しても値は定数 (行列) 倍にしかならないので、ベクトル空間としての構造は変わらない.

### 座標変換

先の $c^v = \phi^{-1}(tv + \phi(x))$ という曲線は有用で、
$\mathbb{R}^n$ における標準基底
$e_1, e_2, \ldots, e_n$
に対して
$c^{e_1}, c^{e_2}, \ldots, c^{e_n}$
は $T_xM$ における基底である.
これは $\phi^*: T_xM \to \mathbb{R}^n$ が同型を与えることを思い出せば明らか.

- 点 $x \in M$ を
    - $\phi$ で与える座標を $\phi(x) = (x_1, x_2, \ldots, x_n)$ ,
    - $\psi$ で与える座標を $\psi(x) = (y_1, y_2, \ldots, y_n)$ とする.
- $T_xM$ の基底
    - $c_\phi^i = \phi^{-1}(te_i + \phi(x)) ~~ (i=1,2,\ldots,n)$
    - $c_\psi^j = \psi^{-1}(te_j + \psi(x)) ~~ (j=1,2,\ldots,n)$

- $\psi^* (c_\psi^j) = e_j$
- $\psi^* (c_\phi^i) = \frac{\partial (\psi \circ \phi^{-1})}{\partial x_i} e_i$

この $x_i$ とは、$t e_i$ のこと.
或いは $\phi \circ c^i_\phi : t \mapsto (x_1, x_2, \ldots, x_n)$ の値の第 $i$ 成分.

また $\psi \circ \phi^{-1}$ とは
$(x_1, x_2, \ldots, x_n) \mapsto (y_1, y_2, \ldots, y_n)$
という座標変換のことで、
$\mathbb{R}^n$ から $\mathbb{R}^n$ への変換.
従ってこの変換に関するヤコブ行列を考えられる.

$$\left(
\frac{\partial y_i}{\partial x_j}
\right)_{i,j}$$

を使うと

- $\psi^* (c_\phi^i) = \sum_j \frac{\partial y_j}{\partial x_i} ~ \psi^*(c_\psi^j)$
- $\therefore c_\phi^i = \sum_j \frac{\partial y_j}{\partial x_i} ~ c_\psi^j$

$c_\phi^i$ のことを $\frac{\partial}{\partial x_i}$,
$c_\psi^j$ のことを $\frac{\partial}{\partial y_j}$ と書くことにすると

- $\frac{\partial}{\partial x_i} = \sum_j \frac{\partial y_j}{\partial x_i} ~ \frac{\partial}{\partial y_j}$

となって形式的に辻褄が合う.
$c_\phi^i$ は、$x_i$ 方向の微分ベクトルのことだから、解釈としても問題ない.

## $T$ の作用

$T$ は多様体 $M$ 及びその上の点 $x \in M$ から $T_xM$ というベクトル空間を導いた.

多様体 $M$ から $N$ への連続写像

- $f: M \to N$

について $T$ を作用させることを考える.

まず定義域の多様体 $M$ を $T_xM$ に写す.
$f$ は $M$ 上の点に関する写像であるが、
$c$ は区間 $(a, b)$ から $M$ 上の点への写像であったから、
$f$ との関数合成をすることで、$N$ 上の点に写すことが出来る.

```dot
digraph {
  rankdir=LR;
  bgcolor=transparent;
  node [shape=plaintext fixedsize=true width=0.6 height=0.3];
  M -> N [label=f];
  ab -> M [label=c];
  ab[label="(a, b)"];
  ab -> N [label="f・c"];
}
```

すなわち、$M$ 上の曲線 $c$ から $N$ 上の曲線 $f \circ c$ を導いた.
この定義域は $T_xM$ である.
値域を考えると、これは $T_{f(x)}N$ である.
これは、$T$ が $N$ を $T_{f(x)}N$ に写したと考えると分かり良い.

曲線 $f \circ c$ のことを 写像 $Tf$ と書くことにする.
すると、$T$ は

- $f: M \to N$
    - $x \mapsto y$

を

- $Tf: T_xM \to T_{f(x)}N$
    - $c \mapsto f \circ c$

に写したと考えられる.

```dot
digraph {
  rankdir=LR;
  bgcolor=transparent;
  node [shape=plaintext fixedsize=true width=0.3 height=0];
  subgraph cluster_1 {
  TM -> TN [label=Tf];
  }
  subgraph cluster_2 {
  M -> N [label=f];
  }
}
```

実はこの $T$ は圏論の言葉で言うところの (共変) 関手である.

## 接写像 (tangent map)

連続写像 $f: M \to N$ とある基点 $x \in M$ から $Tf$ を構成できることを先に示した.
この $Tf$ を **接写像** という.
$Tf$ は線形写像である.
これはほぼ自明.
線形写像ということは行列表示ができるし、rank を計算することもできる.

先の座標変換の時と同様に基底が $Tf$ でどう写るかを考えると、

$$\begin{align*}
\frac{\partial}{\partial x_i} \in T_xM
& ~ \sim ~
\frac{d}{dt} (\phi \circ \phi^{-1}(te_i + \phi(x))) \in \mathbb{R}^n \\
& \xrightarrow{Tf}
\frac{d}{dt} (\psi \circ f \circ \phi^{-1}(te_i + \phi(x))) \in \mathbb{R}^n \\
& ~ \sim ~
\frac{\partial f^*}{\partial x_i} \frac{\partial}{\partial x_i} \in M_{f(x)}N
\end{align*}$$

すなわち、線形写像 $Tf$ は $f^* = \psi \circ f \circ \phi^{-1}$ のヤコブ行列に相当して、
特にその rank が一致する.

$$\text{rank} (Tf) = \text{rank} (Df^*)$$

### 例

$\mathbb{R}/\mathbb{Z}$
は $S^1$ と同型なハウスドルフ空間である.
これ同士の直積もほぼ自明に (或いは先のファイバー束と見なして) ハウスドルフ空間である.
というわけで

$$(\mathbb{R}/\mathbb{Z})^2 \cong \mathbb{R}^2/\mathbb{Z}^2$$

は2次元の微分可能多様体である (詳細略).

整数の $2\times 2$ 行列 $A$ が定める線形写像

$$f_A : \mathbb{R}^2 \to \mathbb{R}^2$$

を $/\mathbb{Z}^2$ で割った

$$f_A : \mathbb{R}^2/\mathbb{Z}^2 \to \mathbb{R}^2/\mathbb{Z}^2$$

を定める.
これは、次のように、同値な点を同値な点に写すので well-defined に定義できる.
($A$ の成分を整数としているので.)

- $f_A \left(\begin{array}\\x\\y\end{array}\right) = A  \left(\begin{array}\\x\\y\end{array}\right)$
- $f_A \left(\begin{array}\\x+m\\y+n\end{array}\right)
= A  \left(\begin{array}\\x+m\\y+n\end{array}\right)
= A  \left(\begin{array}\\x\\y\end{array}\right) + A  \left(\begin{array}\\m\\n\end{array}\right)
= A  \left(\begin{array}\\x\\y\end{array}\right)$

$f_A$ は微分可能な写像である.
というのは、商集合から商集合への写像とすると微分は定義できないが、今、定義域と値域は多様体だとしたので、

```dot
digraph {
  rankdir=LR;
  bgcolor=transparent;
  node [shape=plaintext fixedsize=true width=0.8 height=0.3];
  M -> N [label="fA"];
  M [label="R²/Z²"]
  N [label="R²/Z²"]
  M -> X [label="φ"];
  N -> Y [label="ψ"];
  X [label="R²"];
  Y [label="R²"];
  {rank=same M X}
  {rank=same N Y}
  X -> Y [label="fA*"];
}
```

$f_A$ の代わりに $f_A^* = \psi \circ f_A \circ \phi^{-1}$ が微分可能であるかを考えればよい.
これはほぼ自明な局所座標 $\phi, \psi$ を取ることで、

- $f_A^* \left(\begin{array}\\x\\y\end{array}\right) = A \left(\begin{array}\\x\\y\end{array}\right)$

とできる.
これは $C^\infty$ 級なので、「$f$ は $C^\infty$ 級である」と言える.

さてではこれらに $T$ を作用させることを考える.

- $Tf_A : T_x \mathbb{R}^2/\mathbb{Z}^2 \to T_y \mathbb{R}^2/\mathbb{Z}^2$

この rank は

- $\text{rank} (Tf_A) = \text{rank} (Df_A^*) = \text{rank} A$

と、行列 $A$ の rank と一致することが分かる.

### 例. Lie 群

$G$ が Lie 群であるとは、
$G$ が$n$ 次元多様体だと見做せ、
群の積演算 $* : G \times G \to G$ が $C^\infty$ 級写像であるもののこと.

$L_h(g) = gh$ なる右から定数を掛ける関数は定義から $C^\infty$ 級であるし、
$L_{h^{-1}}$ が明らかに $C^\infty$ 級の逆写像であるので、結局 $L_h$ は同相写像である.

$$x \xrightarrow{(g, L_h)} (g, hx) \xrightarrow{~*~} ghx \xrightarrow{L_{(gh)^{-1}}} x$$

ただしここで左の $(g, L_h)$ は第一成分を定数 $g$ に、第二成分を $L_h$ を適用する関数.
一番左から右までの合成射は恒等射.

$x=1$ における接 $T$ を取ると、

$$T_1G \xrightarrow{T(g, L_h)} T_{(g,h)}(G\times G) \xrightarrow{T~*~} T_{gh}G \xrightarrow{TL_{(gh)^{-1}}} T_1G$$

一番左から右までの合成は、恒等射を $T$ で写したものなので、これも恒等射
(関手は恒等射を恒等射に写す).

一番右の $TL_{(gh)^{-1}}$ は同相写像 $L_{(gh)^{-1}}$ を写したものだから、やはりこれも同型を与える.
従って、左2本の射の合成も全射.

"$f \circ g$ が全射ならば $g$ は全射" であることに註意すれば、 $T~*$ は全射.
また、これは $\mathbb{R}^{n \times n}$ から $\mathbb{R}^n$ への写像であるから
$$\text{rank} (T~*~) = n$$
と、群の積の接写像の rank を調べることができた.

$$* : (g, h) \to gh$$
が $C^\infty$ 級の全射であることから、ここに陰関数定理を適用することで、
$g, gh$ が与えられた時に、$h$ を求める関数も $C^\infty$ 級写像であることが分かる.

ただしここで陰関数定理を適用するために、
$*$ のヤコビアンが full-rank であること、すなわち
$$\text{rank}(D*) = \text{rank}(T*) = n$$
であることを用いた.

特に $gh=1$ とすることで、逆元を取る操作
$$g \mapsto g^{-1}$$
が $C^\infty$ 級であることも分かる.

## 部分多様体

$n$ 次元多様体 $M$ に就いて、
$p$ 次元多様体 $N$ が $M$ の **部分** 多様体であるとは、
$N \subseteq M$ であって、

任意の $\forall x \in M$ を含む $M$ の局所座標 $\exists (U, \phi)$ について

$$N \cap U = \phi^{-1}( \{ x_{p+1} = \cdots = x_n = 0 \} \cap \phi(U) )$$

となること.

### 例

$m>n$ のとき、
$m$ 次元多様体 $M$ から $n$ 次元多様体 $N$ への $C^\infty$ 級写像 $F$ の
接写像 $TF$ の rank が $n$ のとき、
任意の $x_0 \in N$ に対して $F^{-1}(x_0)$ は $M$ の部分多様体である.

例えば

$$F : \mathbb{R}^2 \to \mathbb{R}$$
$$F : (x, y) \mapsto x^2 + y^2$$
$$TF : T\mathbb{R}^2 \to T\mathbb{R}$$
$$TF : a \frac{\partial}{\partial x} + b \frac{\partial}{\partial y} \mapsto (2ax+2by) \frac{\partial}{\partial t}$$

### はめ込み (immertion)

$m<n$ のときに $F: M \to N$ であって $\forall x, T_xF$ が単射のとき、
そのような写像 $F$ をはめ込みという.

$F$ 自体が単射である必要はない.
局所的に単射であれば良い.

### 埋め込み (embedding)

写像 $F: M \to N$ が単射であるようなものを埋め込みという.

### 沈め込み (submertion)

$m \geq n$ のときの写像 $F: M \to N$ であって
$\forall x, T_xF$ が全射であるようなものを、沈め込みという.

## 接束

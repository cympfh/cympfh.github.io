% mex, ニム和
% 2019-05-27 (Mon.)
% ゲーム理論

$\def\mex{\mathrm{mex}}$
<div id=toc-level-2></div>

## 準備

### 自然数

$0$ を含むことにだけ注意してもらってあとは普通の自然数全体を $\mathbb N$ と書く.
$$\mathbb N = \{0,1,2,\ldots\}$$
普通の意味の大小関係 $\leq$ を入れる.

### $\min$

$\mathbb N$ の部分集合 $X$ について,
その最小元を
$$\min X$$
と書く.
$$\min X = a \iff a \in X \land (\forall x \in X, a \leq x).$$

### $\mex$

最小除外数というものを定義する.
$\mathbb N$ の部分集合 $X$ について
$$\mex X := \min (\mathbb N \setminus X)$$
と定義する.
ここで $\mathbb N \setminus X$ は $X$ に含まれない自然数全体を意味する.

$$\mex X = a \iff a \not\in X \land (\forall x \in \mathbb N, x \not\in X \implies a \leq x).$$

特に, $\mex \emptyset = \min \mathbb N = 0$.

## 諸性質

### $\min$ の性質

大体明らかなので紹介だけ

- $x \in X \implies x \geq \min X$
- $\min (A \cap B) \geq \min \{ \min A, \min B \}$
- $\min (A \cup B) = \min \{ \min A, \min B \}$

### $\mex$ の性質

#### mex-0

$$s = \mex S \iff \{0,1,\ldots,s-1\} \subset S \land s \not\in S$$

これは定義そのままなので証明略.

#### mex-1

$$x \not \in X \implies x \geq \mex X$$

<details><summary>Proof</summary>
上の主張は, 次の同値な形に書き直せる.
$$x \in \mathbb N \setminus X \implies x \geq \min (\mathbb N \setminus X)$$
$X$ の補集合を $Y$ と改めて置くと,
$$x \in Y \implies x \geq \min Y$$
これは $\min$ の性質そのものである.
</details>

#### mex-2

$$\mex S < \mex T \implies \mex S \in T$$

<details><summary>Proof</summary>

対偶を取ると難しくない.
今 $\mex S \not\in T$ を仮定すると,
$$\begin{align*}
\mex T
& = \min ( \mathbb N \setminus T ) \\
& = \min ( (\mathbb N \setminus T) \cup \{ \mex S \} ) \\
& = \min \{ \min(\mathbb N \setminus T) , \mex S \} \\
& \leq \mex S
\end{align*}$$

</details>

#### mex-3

$$S \subset T \implies \mex S \leq \mex T$$

<details><summary>Proof</summary>

$s = \mex S$ と置くと, これが $S$ の最小除外数であることから,
$$s \not\in S.$$
今 $S \subset T$ を仮定すると,
$$s \not\in T.$$
mex-1 を使うと
$$s \geq \mex T.$$
</details>

## 定義: ニム和 (Nim-sum)

ニム和 $\oplus$ を定義する.
これは
$$\mathbb N \times \mathbb N \to \mathbb N$$
$$(a, b) \mapsto a \oplus b$$
なる関数で, その値は次で与えられる.
$$a \oplus b := \mex (\{ a' \oplus b \mid 0\leq a' < a \} \cup \{a \oplus b' \mid 0 \leq b' < b \})$$
ここでこの右辺は少々長ったらしいので
$$\{ a' \oplus b, a \oplus b' \mid 0\leq a' < a, 0 \leq b' < b \}$$
とか, 更には
自然数 $x$ に対して $x'$ で $0$ 以上 $x$ 未満の自然数 **全て** を表すということにして,
$$\{ a' \oplus b, a \oplus b' \}$$
と略記することにする.

> このプライム記号は式に対して自由に適用して良いことにする.
> 例えば $(x+y)'$ と書けば $(x+y)$ 未満の自然数全てという意味.

ところでこの $\oplus$ の定義はその右辺にも $\oplus$ が登場するが,
これは再帰的定義になっていることに注意.
すなわち, $a \oplus b$ を定義するにあたって,
$a' \oplus b$ と $a \oplus b'$ がすでに定義済みであることを仮定している.
右辺に出てくる $\oplus$ には必ず左辺より小さい数が与えられているので,
$(0,0)$ から順にやっていけば求まるようになっている.

特に $0 \oplus 0 = \mex \emptyset = 0$.

小さい数について $x \oplus y$ を書き出してみると

| x,y | 0 | 1 | 2 | 3 | 4 |
|:---:|:-:|:-:|:-:|:-:|:-:|
|  0  | 0 | 1 | 2 | 3 | 4 |
|  1  | 1 | 0 | 3 | 2 | 5 |
|  2  | 2 | 3 | 0 | 1 | 6 |

こんな感じ.
簡単に見えてくる性質を挙げる.

### 諸性質

#### nim-1

$$x \oplus y = y \oplus x$$

これは定義の時点で対称的になってるので明らかにそう.

#### nim-2

$$x \oplus 0 = x$$

普通の和と同様に $+0$ が恒等写像になってる.

<details><summary>Proof</summary>
帰納法で示す.
$\oplus$ 自体が再帰的定義になってるから再帰的な証明になるのは仕方ないね.

$x=0$ のときは実際に計算すれば確かに成り立っている.

$x \oplus 0$ について,
$x' \oplus 0 = x'$ がすでに成り立っているとする
($x'$ で $x$ 未満の自然数全てを表すのであった).
このとき,
$$x \oplus 0 = \mex \{ x' \oplus 0 \} = \mex \{ x' \} = x.$$

以上より示された.
</details>

#### nim-3

$$x \oplus x = 0$$

いわば自分自身が **逆数** になっている.

<details><summary>Proof</summary>
やはり帰納法で示す.

$x=0$ のときは成立.

$x'\oplus x'=0$ を仮定して $x \oplus x = 0$ を示す.

各 $a < x$ について
$$a \oplus x = \mex \{ a' \oplus x, a \oplus x' \}$$
であるが,
$0 = a \oplus a \in \{ a' \oplus x, a \oplus x' \}$
なので,
$a \oplus x > 0$
である.
(これは特に紹介した性質を使ったわけじゃないけど,
$0$ を含んでればその最小除外数が $0$ ではないのは明らかでしょう.)

今度は
$$x \oplus x = \mex \{ x' \oplus x \}$$
を考えると,
今さっき $x' \oplus x > 0$ であることを示したから,
$0 \not\in \{ x' \oplus x \}$.
mex-1 より, $0 \geq x \oplus x$.
$0$ 未満の数は無いのでもちろん $0 = x \oplus x$.
</details>

## ニム和と排他的論理和

実はニム和 $x \oplus y$ は $x,y$ を2進表示したときのそれらの排他的論理和 (XOR) と等しい.

これを証明するのに必要なヒントとして,
ニム和の表は実は左上を $(0,0)$ として一辺 $2^k$ の正方形を取ると, パターンが見えてくる.
先程の表を少しずつ広げてくと,,,

| x,y | 0 | 1 |
|:---:|:-:|:-:|
|  0  | 0 | **1** |
|  1  | **1** | 0 |

<br>

| x,y | 0 | 1 | 2 | 3 |
|:---:|:-:|:-:|:-:|:-:|
|  0  | 0 | 1 | **2** | **3** |
|  1  | 1 | 0 | **3** | **2** |
|  2  | **2** | **3** | 0 | 1 |
|  3  | **3** | **2** | 1 | 0 |

<br>

| x,y | 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 |
|:---:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|
|  0  | 0 | 1 | 2 | 3 | **4** | **5** | **6** | **7** |
|  1  | 1 | 0 | 3 | 2 | **5** | **4** | **7** | **6** |
|  2  | 2 | 3 | 0 | 1 | **6** | **7** | **4** | **5** |
|  3  | 3 | 2 | 1 | 0 | **7** | **6** | **5** | **4** |
|  4  | **4** | **5** | **6** | **7** | 0 | 1 | 2 | 3 |
|  5  | **5** | **4** | **7** | **6** | 1 | 0 | 3 | 2 |
|  6  | **6** | **7** | **4** | **5** | 2 | 3 | 0 | 1 |
|  7  | **7** | **6** | **5** | **4** | 3 | 2 | 1 | 0 |

大体次のような形をしてそうだと分かる.
つまり,

$0$ から $2^k-1$ の自然数からなる大きさ $2^k \times 2^k$ の対称行列 $A$ があって,

$$\left[\begin{array}{cc}
A & A + 2^k \\
A + 2^k & A
\end{array}\right]$$

このことを今から示していく.

### 補題

自然数 $k$ と $0 \leq x < 2^k, 0 \leq y < 2^k$ について, 次の2つが成り立つ:

1. $x \oplus (y + 2^k) = (x \oplus y) + 2^k$
1. $(x + 2^k) \oplus (y + 2^k) = x \oplus y$
1. $\{ x \oplus y' \mid 0 \leq y' < 2^k \} = \{0,1,\ldots,2^k-1\}$

この1つ目は右上（または左下）の $A + 2^k$ に対応している.
2つ目は右下が $A$ であることを言っている.
3つ目は $A$ の各行を見ると実は $0$ から $2^k-1$ の全てが出現していることを言っている

<details><summary>Proof</summary>

まず $k$ に関して, 更にその中では $x,y$ に関する帰納法で示す.

すなわち, $(k,x,y)$ の場合を示すのに次の2つを同時に仮定する.

1. $\forall 0 \leq x',y' < 2^{k-1}$,
    - $x' \oplus (y' + 2^{k-1}) = (x' \oplus y') + 2^{k-1}$
    - $(x' + 2^{k-1}) \oplus (y' + 2^{k-1}) = x' \oplus y'$
    - $\{ x' \oplus z \mid 0 \leq z < 2^{k-1} \} = \{0,1,\ldots,2^{k-1}-1\}$
1. $\forall 0 \leq x' < x$ OR $\forall 0 \leq y' < y$,
    - $x' \oplus (y' + 2^k) = (x' \oplus y') + 2^k$
    - $(x' + 2^k) \oplus (y' + 2^k) = x' \oplus y'$

この仮定の下で $x \oplus y, x \oplus (y + 2^k), (x + 2^k) \oplus (y + 2^k)$ を考える.

> 基本的に最小除外数の対象となる集合を考えて分解して帰納法の仮定が使えるところを使えば示される.

$S = \{ x' \oplus y, x \oplus y' \}$ と置くと $x \oplus y = \mex S$.
$r = x \oplus y$ と置けば
$$\{0,1,\ldots,r-1\} \subset S \land r \not\in S$$
(mex-0).

次に
$T = \{ x' \oplus (y+2^k), x \oplus (y+2^k)' \}$
と置けば
$x \oplus (y+2^k) = \mex T$
である.
この $T$ を更に調べると

$$\begin{align*}
T & = \{ x' \oplus (y+2^k), x \oplus (y+2^k)' \} \\
& = \{ x' \oplus (y+2^k), x \oplus (y'+2^k) \} \cup \{ x \oplus z \mid 0 \leq z < 2^k \} \\
& = \{ (x' \oplus y) + 2^k, (x \oplus y') + 2^k \} \cup \{0,1,\ldots,2^k-1\} \\
& = \{ s + 2^k \mid s \in S \} \cup \{0,1,\ldots,2^k-1\} \\
\end{align*}$$

ということまで分かる.
$\{0,1,\ldots,r-1\} \subset S$ だったので,
これらに $+2^k$ して
$\{2^k,2^k+1,\ldots,2^k+r-1\} \subset T$
である.

したがって
$\{0,1,\ldots,2^k,2^k+1,\ldots,2^k+r-1\} \subset T$
まで言える.

また $r \not\in S$ だったので, $2^k + r \not\in T$.

以上から $\mex T = 2^k + r = 2^k + (x \oplus y)$ が分かった.

次に $(x + 2^k) \oplus (y + 2^k)$ について考える.
$U = \{(x+2^k)' \oplus (y+2^k), (x+2^k) \oplus (y+2^k)'\}$
と置けば $(x + 2^k) \oplus (y + 2^k) = \mex U$ であるわけだが

$$\begin{align*}
U & = \{(x+2^k)' \oplus (y+2^k), (x+2^k) \oplus (y+2^k)'\} \\
& = \{(x'+2^k) \oplus (y+2^k), (x+2^k) \oplus (y' + 2^k) \}
\cup
\{ z \oplus (y+2^k), (x+2^k) \oplus z \mid 0 \leq z < 2^k \} \\
& = \{x' \oplus y, x \oplus y' \}
\cup
\{ z \oplus (y+2^k), (x+2^k) \oplus z \mid 0 \leq z < 2^k \} \\
& = \{x' \oplus y, x \oplus y' \}
\cup
\{ (z \oplus y)+2^k, (x \oplus z) + 2^k \mid 0 \leq z < 2^k \} \\
& = S \cup \{ z+2^k \mid 0 \leq z < 2^k \} \\
\end{align*}$$

というわけでやはり
$\{0,1,\ldots,r-1\} \subset U$ かつ
$r \not\in U$
がわかるので
$\mex U = r = x \oplus y$
であることがわかる.

最後に.
$$\begin{align*}
\{x \oplus z \mid 0 \leq z < 2^k \}
& = \{ x \oplus z \mid 0 \leq z < 2^{k-1} \} \cup \{ x \oplus z \mid 2^{k-1} \leq z < 2^k \} \\
& = \{ x \oplus z \mid 0 \leq z < 2^{k-1} \} \cup \{ x \oplus z + 2^k \mid 0 \leq z < 2^{k-1} \} \\
& = \{0,1,\ldots,2^{k-1}-1\} \cup \{2^{k-1}, 2^{k-1}+1,\ldots,2^k-1\} \\
& = \{0,1,\ldots,2^k-1\}
\end{align*}$$

以上から全て示された.
</details>

### 定理: ニム和は排他的論理和と一致する

<div class=thm>
<b>定理</b>

自然数 $x,y$ それぞれを

- $x = \sum_{i=0}^\infty x_i 2^i$; $x_i \in \{0,1\}$
- $y = \sum_{i=0}^\infty y_i 2^i$; $y_i \in \{0,1\}$

という2進表示をした時,

$$x \wedge y = \sum_{i=0}^\infty (x_i \wedge y_i) 2^i$$

を $x$ と $y$ との排他的論理和と呼ぶ.

ただしここで $0 \wedge 0=0, 1 \wedge 1=0, 0 \wedge 1=1, 1 \wedge 0=1$.

そしてこのとき
$$x \oplus y = x \wedge y$$
が成り立つ.
</div>

<details><summary>Proof</summary>
各 $i$ に関して先程の補題を適用すればいい.
$x > y$ だと仮定して,
$x$ の最上位ビットが $i=k$ だとすると,
$x_i=1$ であって

$$x \oplus y = ((x-2^k)+2^k) \oplus ((y-y_k 2^k)+y_k 2^k)
= ((x-2^k) \oplus y- y_k2^k) + (1-y_k) 2^k$$

$(x-2^k) \oplus y- y_k2^k) = (x-2^k) \wedge y- y_k2^k)$
であると仮定すれば,
$$\begin{align*}
x \oplus y
& = (1-y_k) 2^k + ((x-2^k) \wedge y- y_k2^k)) \\
& = (x_k \wedge y_k) 2^k + \sum_{i=0}^{k-1} (x_i \wedge y_i) 2^i \\
& = x \wedge y
\end{align*}$$
というわけでビットに関する帰納法で示される.
</details>

## ニム和はAbel群を構成する

$(\mathbb N, \oplus)$ はAbel群を成す.
単位元 $0$ の存在, 逆元 $-x$ の存在, Abel 性はすでに mex-1,mex-2,mex-3 で示したのであとは結合性
$$(x \oplus y) \oplus z = x \oplus (y \oplus z)$$
を示せば Abel 群であることが分かる.
結合性だけは排他的論理和で証明する.

排他的論理和は各ビットの排他的論理和の級数和であったが,
ただの和 ($+$) はもちろん結合性を満たすので,
各ビットの結合性を示せば良い.
つまり $x_i, y_i, z_i \in \{0,1\}$ について
$$(x_i \wedge y_i) \wedge z_i = x_i \wedge (y_i \wedge z_i)$$
が成り立つことを見ればよいが,
これは $8$ 通り全てをチェックすればよくて, 実際成り立っている.

以上から排他的論理和、しいてはニム和は結合性を満たす.
というわけでAbel群を成す.

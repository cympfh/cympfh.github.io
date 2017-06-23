% 量子計算

ここではあくまでも計算モデルとして量子計算を眺め、なにが実現出来るかを調べる.
つまり物理学的な視点にはあまり興味がない.

## INDEX
<div id=toc></div>

## qbit (量子ビット, Qbit, qubit)

古典コンピュータにおける計算にはbitを用いる.
これは $0$ または $1$ のいずれかの状態を取るものである.
一方で、qbit はこの2つの状態を重ねあわせて持つ.
具体的には2つの状態を線型結合として記述される.

qbit が $0$ である状態を $|0\rangle$、
qbit が $1$ である状態を $|1\rangle$ と書く (bra-ket記法).

一般にはこれらの重ねあわせ (線型結合):
$$\alpha |0\rangle + \beta |1\rangle$$
で表される.
ここで $\alpha, \beta$ は **虚数**.
ただし物理学の要請から、
$$|\alpha|^2 + |\beta|^2 = 1$$
という係数の制約がある.

> 実数 $\alpha$ について $|\alpha|^2 = \alpha^2$.
> 虚数 $\alpha$ について $|\alpha|^2 = \alpha^* \alpha$.

### 観測

$|\alpha|^2 + |\beta|^2 = 1$ とあるが、これらは確率を意味する.
すなわち、
qbit $\alpha |0\rangle + \beta |1\rangle$
を実際に観測すると、
確率 $|\alpha|^2$ で $|0\rangle$ を得、
確率 $|\beta|^2$ で $|1\rangle$ を得る.
観測という行為は qbit に干渉する.
例えば $|0\rangle$ を得たとき、
qbit $\alpha |0\rangle + \beta |1\rangle$
は $|0\rangle$ に変化するという性質を持つ.
もちろん $|0\rangle$ はそれ以降、いくら観測しても $|0\rangle$ のままである.

### $n$ qbit

bit と同様に $n$ 個の qbit を並べた場合を $n$ qbit として考える.

- 自由に一列に並べられる
- 自由に一部を取り出せる
- 自由に一部だけを観測できる

簡単に $n=2$ とする.
1つ目が $|0\rangle$ で 2つ目が $|1\rangle$ であるとき、
それらを並べて出来る 2 qbit の状態を $|01\rangle$ であると書く.
すると 2 qbitは
$$|00\rangle, |01\rangle, |10\rangle, |11\rangle$$

の四通りの状態を取り得、これらの線型結合で一般には表される.
すなわち、

$$\alpha_{00} |00\rangle + \alpha_{01} |01\rangle + \alpha_{10} |10\rangle + \alpha_{11} |11\rangle$$

が一般の 2 qbit の表現である.
係数の制約は
$$|\alpha_{00}|^2 + |\alpha_{01}|^2 + |\alpha_{10}|^2 + |\alpha_{11}|^2 = 1$$
であって、それぞれがそれぞれを観測する確率になる.

それぞれが
$\alpha_1 |0\rangle + \beta_1 |1\rangle$
と
$\alpha_2 |0\rangle + \beta_2 |1\rangle$
だったとする.
観測する確率は qbit 毎に独立だとすると、

- $|\alpha_{00}|^2 = |\alpha_1|^2 |\alpha_2|^2$
- $|\alpha_{01}|^2 = |\alpha_1|^2 |\beta_2|^2$
- $|\alpha_{10}|^2 = |\beta_1|^2 |\alpha_2|^2$
- $|\alpha_{11}|^2 = |\beta_1|^2 |\beta_2|^2$

であることが確認できて、実際そう.

#### 部分的観測

$n$ qbit の内 1つの qbit ($\alpha |0\rangle + \beta |1\rangle$) を観測した結果、
その qbit の状態は先述したとおり、観測された状態に確定して固定されるが、
残りの $n-1$ qbit についてはなおも重ね合わせの状態を保ったままで観測が干渉することはない.


例として、
2 qbit
$$\alpha_{00} |00\rangle + \alpha_{01} |01\rangle + \alpha_{10} |10\rangle + \alpha_{11} |11\rangle$$

の 1 qbit 目を観測した結果 $|0\rangle$ を得たとする.
1 qbit 目は $0$ で固定されるので、
$|10\rangle$, $|11\rangle$ は最早得られない.
従って 2 qbit は、
$$\alpha_{00}' |00\rangle + \alpha_{01}' |01\rangle$$

で表される.

$\alpha_{00}'$, $\alpha_{01}'$ はどうなるかと言うと、これらは結局、2 qbit 目が
$|0\rangle$, $|1\rangle$ で観測される確率 (の閉包根) であって、
(それは観測の前後で変化しない)

元の 2 qbit が
$\alpha_1 |0\rangle + \beta_1 |1\rangle$
と
$\alpha_2 |0\rangle + \beta_2 |1\rangle$
だったとすると、

- $\alpha_{00}' = \alpha_2$
- $\alpha_{01}' = \beta_2$

先ほど見た結果を使うと
(絶対値などという細かなことを無視すると)

- $\alpha_{00}' = \alpha_2 = \alpha_{00} / \alpha_1$
- $\alpha_{01}' = \beta_2  = \alpha_{01} / \alpha_1$

$\alpha_1$ の逆数を単に定数 $\kappa$ と書いて以上を改めてまとめると、

- 2 qbit $\alpha_{00} |00\rangle + \alpha_{01} |01\rangle + \alpha_{10} |10\rangle + \alpha_{11} |11\rangle$
- 1 qbit 目を観測して $|0\rangle$ を得た
- 2 qbit $\kappa \alpha_{00} |00\rangle + \kappa \alpha_{01} |01\rangle$

観測の結果あり得ない状態を消して (係数をゼロにして) 他の係数は定数 $\kappa$ 倍する.
係数の自乗和が $1$ (全確率が $1$) という制約から $\kappa$ の値は決定する.

## 量子ゲート

量子に対する実現可能な操作で次のようなゲートを作成することが理論上可能.

### 量子NOT

次のような $X$ が存在する:

- $X |0\rangle = |1\rangle$
- $X |1\rangle = |0\rangle$

この2つは即ち、
$X (\alpha |0\rangle + \beta |1\rangle)
=
\beta |0\rangle + \alpha |1\rangle$
であると言っている.

### 制御 (controlled) NOT

次のような 2 qbit に対する操作 $X$ が存在する:

- $X |\alpha, \beta \rangle = |\alpha, \alpha \oplus \beta \rangle$
- $X |\alpha, \beta \rangle = |\alpha, \alpha \oplus \beta \rangle$

$\oplus$ は排他的論理で、
$0 \oplus \beta = \beta$、
$1 \oplus \beta = 1 - \beta$.

### アダマール (Hadamard) ゲート

次のような $H$ が存在する:

- $H |0\rangle = \frac{1}{\sqrt{2}} |0\rangle + \frac{1}{\sqrt{2}} |1\rangle$
- $H |1\rangle = \frac{1}{\sqrt{2}} |0\rangle - \frac{1}{\sqrt{2}} |1\rangle$

#### N.B.

ちょうど一つの量子を得ることができれば、観測してみることで
$|0\rangle$, $|1\rangle$ を得ることができる.
アダマールゲートは観測した上で二種類重ね合わせの状態の量子を得られる.
そのに種類は確かに異なるものだが、両者とも
「同確率で $|0\rangle$, $|1\rangle$ が観測される」ような量子である.

また $H$ は二回通すことで恒等写像になることがわかる.

また $H$ を組み合わせることで、
全ての $2^n$ 状態が等確率で観測できる $n$ qbit を作ることができる.

## 量子並列性

古典回路で計算できるビット操作 $f$ について、同程度の効率で計算できる次のような量子ゲート $U_f$ が存在する:

$$U_f |x,y\rangle = |x, y \oplus f(x) \rangle$$

アダマールは2つの状態を全く同等に含んだ量子を作れるから、$U_f$ を用いて、
実質的に $f(0)$ と $f(1)$ を並列に計算するようなことができる.
具体的には次を実行する.

1. $H |0\rangle$ に $|0\rangle$ を並べる
    - $H|0\rangle \cdot |1\rangle = \frac{1}{\sqrt{2}} |00\rangle + \frac{1}{\sqrt{2}} |10\rangle$
1. $U_f$ に通す
    - $\frac{1}{\sqrt{2}} |0, f(0)\rangle + \frac{1}{\sqrt{2}} |1, f(1)\rangle$

一度の $U_f$ の計算で $f(0)$ と $f(1)$ が行われているのが分かる.
この性質を量子並列性というが、これをこのまま観測するだけでは結局、一通りの結果
$|x, f(x)\rangle$
しか得られない.
並列性のメリットを享受するには工夫が必要である.
その古典的な一例であるドイチュのアルゴリズムを次に見る.

## ドイチュのアルゴリズム (Deutsch algorithm)

bit操作 $f$ について $f(0) \oplus f(1)$ を一度の $U_f$ ($f$ 相当の計算) で計算するアルゴリズム.

アルゴリズムは次の 4 step から成る.

1. $|+\rangle = H |0\rangle$
2. $|-\rangle = H |1\rangle$
    - 2つを並べたものを $|+\rangle \cdot |-\rangle = |+-\rangle$ とする
3. $|\phi_1, \phi_2 \rangle = U_f |+-\rangle$
4. $H |\phi_1, \phi_2 \rangle$ の 1 qbit 目を観測
    - $H |\phi_1, \phi_2 \rangle$ とは $H|\phi_1 \rangle \cdot H |\phi_2 \rangle$ のこと

具体的に計算を追う.

2. $|+-\rangle = (|0\rangle+|1\rangle)/\sqrt{2} \cdot (|0\rangle - |1\rangle)/\sqrt{2} = (|00\rangle - |01\rangle + |10\rangle - |11\rangle) / 2$
3. $U_f |+-\rangle = (|0,f(0)\rangle -|0,1-f(0)\rangle +|1,f(1)\rangle -|1,1-f(1)\rangle)/2$
4. $H(U_f |+- \rangle) = \left( |H(0),H(f(0))\rangle -|H(0), H(1-f(0))\rangle +|H(1), H(f(1))\rangle - |H(1), H(1-f(1))\rangle \right)/2$

ここで $H(|0\rangle)$ を $H(0)$ などと略記した.
(もちろん $H(0) = |+\rangle$, $H(1) = |-\rangle$ のことである.)

最期の式を更に詳細に調べる.

初めの2項 $|H(0),H(f(0))\rangle -|H(0), H(1-f(0))\rangle$ に注目する.
$f(0), 1-f(0)$ はちょうど一方が 0 なら他方は 1 である.

- $H(0) - H(1) = ~ \sqrt{2}~|1\rangle$
- $H(1) - H(0) = - \sqrt{2}~|1\rangle$

であることを使うと

$$|H(f(0))\rangle -|H(1-f(0))\rangle = (-1)^{f(0)} \sqrt{2}~|1\rangle.$$
すなわち、
$$|H(0),H(f(0))\rangle -|H(0), H(1-f(0))\rangle
=
(-1)^{f(0)} \sqrt{2}~|H(0), 1\rangle.$$

と書ける.
残りの2項についても同様に書きなおせば、

$$H(U_f |+- \rangle) = \frac{1}{2} \left[
(-1)^{f(0)} \sqrt{2}~|H(0), 1\rangle
+
(-1)^{f(1)} \sqrt{2}~|H(1), 1\rangle
\right]$$
$$= \frac{1}{\sqrt{2}}\left[
(-1)^{f(0)} ~|H(0), 1\rangle
+
(-1)^{f(1)} ~|H(1), 1\rangle
\right]$$

1 qbit 目にだけ注目すると

$$\frac{1}{\sqrt{2}}\left[
(-1)^{f(0)} ~|H(0)\rangle
+
(-1)^{f(1)} ~|H(1)\rangle
\right]$$

$f(0), f(1)$ によって場合分けをすると

1. case $f(0)=0, f(1)=0$
    - $1/\sqrt{2}~|H(0)\rangle + 1/\sqrt{2}~|H(1)\rangle = |0\rangle$
1. case $f(0)=0, f(1)=1$
    - $1/\sqrt{2}~|H(0)\rangle - 1/\sqrt{2}~|H(1)\rangle = |1\rangle$
1. case $f(0)=1, f(1)=0$
    - $-1/\sqrt{2}~|H(0)\rangle + 1/\sqrt{2}~|H(1)\rangle = -|1\rangle$
1. case $f(0)=1, f(1)=1$
    - $-1/\sqrt{2}~|H(0)\rangle - 1/\sqrt{2}~|H(1)\rangle = -|0\rangle$

観測して得られる qbit は、符号は無視して、それぞれ、確率 $1$ で、
$|0\rangle$ または $|1\rangle$ が得られ、それはちょうど
$f(0) \oplus f(1)$ と一致している.

## ユニタリ変換

複素正方行列 $U$ で

$$U^\dagger U = UU^\dagger = I$$

とあるような行列をユニタリ行列という.
ここで $U^\dagger$ は成分の共役 $(U^*)$ を取って転置した行列 $(U^*)^T$.

簡単な性質として2つのユニタリ行列 $U,V$ の積 $UV$ もユニタリ行列.

ベクトル $v$ の左から $U$ を掛ける操作をユニタリ変換という.

### Thm.

任意のユニタリ変換を再現する量子ゲートが存在する.

ところでこの定理を証明する気は無いが、其の前に qbit のベクトル表記を説明しないと意味が分からない.
$n$ qbit に関して

$$|0\ldots000\rangle,~
|0\ldots001\rangle,~
|0\ldots010\rangle,~
\ldots,~
|1\ldots111\rangle$$

という $2^n$ 個の (基底) 状態があり得、
これらに係数

$$\alpha_{0\ldots000},~
\alpha_{0\ldots001},~
\alpha_{0\ldots010},~
\ldots,~
\alpha_{1\ldots111}$$

を乗じた線型結合が一般の状態だが、
そう書く代わりに、

$$\left[\begin{array}
\alpha_{0\ldots000}\\
\alpha_{0\ldots001}\\
\alpha_{0\ldots010}\\
\ldots\\
\alpha_{1\ldots111}
\end{array}\right]$$

という列ベクトルだと思うことにする.


そうして先ほどの定理だが、これはこの列ベクトルに左からあるユニタリ行列 $U$ を掛けて

$$
\left[\begin{array}
\beta_{0\ldots000}\\
\beta_{0\ldots001}\\
\beta_{0\ldots010}\\
\ldots\\
\beta_{1\ldots111}
\end{array}\right]
=
U
\left[\begin{array}
\alpha_{0\ldots000}\\
\alpha_{0\ldots001}\\
\alpha_{0\ldots010}\\
\ldots\\
\alpha_{1\ldots111}
\end{array}\right]$$

という時に、左辺のベクトルに対応する qbit 状態を得るような量子ゲートが必ず存在すると言っている.


このような行列 $U$ の大きさは $2^n \times 2^n$ と、2のべき乗でないといけないが、
実際には気にする必要はない.
一般の $m$ ($2^{n-1} < m \leq 2^n$) について、
ユニタリー行列 $U \in \mathbb{C}^{m\times m}$ に $2^n-m$ 個、サイズを広げて、
$$U' = \left[\begin{array}
  &   &   &   &   \\
  & U &   &   &   \\
  &   &   &   &   \\
  &   &   & 1 &   \\
  &   &   &   & 1
\end{array}\right]$$

広げた部分は対角に $1$ を置いてできる行列 $U'$ も問題なくユニタリー行列.

$n$ qbit であるが実際には $2^n$ 状態の内 $m$ 状態しか取り得ないようなもの長さ $m$ の列ベクトルで表現でき、$m \times m$ 行列 $U$ で、操作を記述すればよい.
実際には余白を $0$ で埋めた長さ $2^n$ の列ベクトルを $2^n \times 2^n$ 行列 $U'$ で操作したものだとすれば問題ない.

#### 例. 量子NOT

量子NOTというゲート $X$ は
$\alpha |0\rangle + \beta |1\rangle$ を
$\beta |0\rangle + \alpha |1\rangle$ に写す.

即ち

$$
\left[\begin{array}
\beta\\
\alpha
\end{array}\right]
=
U_X
\left[\begin{array}
\alpha\\
\beta
\end{array}\right]$$

という行列 $U_X$ である.
これを満たすような行列は正しく

$$U_X = \left[\begin{array}
0 & 1\\
1 & 0
\end{array}\right]$$

で、これがユニタリ行列であることは明らか.

## EXACT and THRESHOLD algorithm

### 論文

- "Exact quantum query complexity of EXACT and THRESHOLD"
    - Andris Ambainis, Jānis Iraids, Juris Smotrovs
- [https://arxiv.org/abs/1302.1235](https://arxiv.org/abs/1302.1235)

与えられた $n$ bit (qbit ではない) について立ってる ($1$ である) ビットの数を数えるアルゴリズム.
正確に述べると、
立ってるビットの数がちょうど $k$ であるか判定する $\text{EXACT}^n_k$ と、
$k$ 以上であるか判定する $\text{THRESHOLD}^n_k$ の2つのアルゴリズムを与える.

### notation

01を並べて $|00010\rangle$ などと書く代わりに
$$|0\rangle,~|1\rangle,~\ldots,~|n\rangle$$
と書く.
実際にはこれは $n$ qbit だとして、
$i$ 番目のビットだけが立ってるものを $|i\rangle$ と書いたと約束する (one-hot).

$i<j$ について、
$|i \rangle \cdot |j \rangle = |i,j\rangle$
(左辺は $n$ qbit、右辺は $2n$ qbit)
と書く.

さらに冗長に、
$|i\rangle \cdot |i\rangle$ を改めて、
$|i \rangle$ とする.
即ちこれは実際には $2n$ qbit である.

> _N.B._ 実際には、中身の表現はどうでもよくて、要するに区別できる状態であればよい.
> つまり $| \cdot \rangle$ の中に書く数字は単なるラベルであるので実際には文字列だと思って見る.

1 qbit $|x\rangle$ ($x=0,1$) に対して
$(-1)^x$ を $\hat{x}$ と書く ($\hat{x}=-1,1$).

### Query (量子クエリ)

これから EXACT と THRESHOLD という2つのアルゴリズムを説明するが、
共に $Q$ という操作が登場する.
これは入力 $x_1, x_2,\ldots, x_n$ に依存する写像であって、

- $Q |i\rangle = \hat{x}_i |i\rangle$
- $Q |i,\rangle = |i,j\rangle$ $(i<j)$

で定めるものである.
このように入力に依存する操作をクエリと呼ぶ.

1回のクエリの処理 ($Q$ の適用) のたびに、入力 $x_i$ を一回読む必要がある.
アルゴリズムの複雑性として、クエリを処理する回数を指標とする.
これを量子クエリ計算量という.

### EXACT

$n$ bit
$x_0, x_1, \ldots, x_{n-1}$
の内、ちょうど $k$ 個が立ってるか判定するアルゴリズムを
$\text{EXACT}^n_k$
とする.

$$\text{EXACT}^n_k : \{0,1\}^n \to \{\text{true}, \text{false}\}$$

今から述べる彼らのアルゴリズムでは $2n$ qbit を用意する.
取り得る状態は
$|i\rangle, |i,j\rangle$
$(
0\leq i < n,
0\leq j < n,
i < j)$
の $n + n(n-1)/2 = n(n+1)/2$ 個だけとし、初め $|0\rangle$ だとする.
従って、長さ $n(n+1)/2$ の虚ベクトルで状態は表現される.

まず $n=2k$ ($\text{EXACT}^{2k}_k$) の場合を考える.

#### EXACT${}^{2k}_k$

ちょうど半分のビットが立ってるかだけを判定する.
ビットそれぞれを $x \mapsto \hat{x}$ としたときに、
その和 $\sum_i \hat{x}_i$ がゼロになるだろう.
これを利用する.

次の3つの操作を用いる:

1. $U_1 |0\rangle = \frac{1}{\sqrt{2k}} \sum_{i=0}^{2k-1} |i\rangle$
    - ユニタリー変換
1. $Q$
1. $U_2 |i\rangle = \frac{1}{\sqrt{2k}} \left( \sum_{i<j} |i,j\rangle - \sum_{i>j} |j,i\rangle + |0\rangle \right)$
    - ユニタリー変換

ここで未定義な値 (e.g. $U_1|1\rangle$) はどう定義してもいいので $U_1, U_2$ をユニタリー行列になるようにする.

$|0\rangle$ にこれらを順に通す.

- $|0\rangle$
    - ${}_\vec{~~U_1~~} ~~ \frac{1}{\sqrt{2k}} \sum_{i=0}^{2k-1} |i\rangle$
    - ${}_\vec{~~Q~~} ~~ \frac{1}{\sqrt{2k}} \sum_{i=0}^{2k-1} \hat{x}_i |i\rangle$

$${}_\vec{~~U_2~~} ~~ \frac{1}{2k} \left( (\hat{x}_i - \hat{x}_j) |i,j\rangle + \sum_{i=0}^{2k-1} \hat{x}_i |0\rangle \right)$$

で、最後の量子を観測したときに得られうる状態は

1. $|i,j\rangle$
1. $|0\rangle$

の2種類ある.
この2つ目を得た時、それは係数 $\sum_i \hat{x}_i$ がゼロでないということ.
なぜなら、ゼロなら観測できる確率はゼロだから.
そして、それがゼロでないということは、$n=2k$ の内ちょうど半分のビットが立っていることを **否定** している.
すなわち、

$$\text{EXACT}^{2k}_k(x_0, x_1, \ldots, x_{n-1}) = \text{false}.$$

次に、1つ目の $|i,j\rangle$ を得た時、これも同様に、その係数
$\hat{x}_i - \hat{x}_j$
がゼロではないことを示してる.
それはつまり、ビット $x_i$ とビット $x_j$ とが異なることを示してる.
すなわち、

$$\text{EXACT}^{2k}_k(x_0, x_1, \ldots, x_{n-1})
=
\text{EXACT}^{2k-2}_{k-1}(x_0, x_1, \ldots, x_{n-1} \setminus \{x_i, x_j\}).$$

以上は $k$ に関する帰納法を示唆する.
基底状態として

$$\text{EXACT}^0_0() = \text{true}$$

である.

#### EXACT${}^{n}_k$

入力 $x_0, \ldots, x_{n-1}$ に適当に付け足せば $\text{EXACT}^{2k}_k$ に出来る.
具体的には

- case $n = 2k$
    - $\text{EXACT}^{2k}_k(x)$
- case $n > 2k$
    - $\text{EXACT}^{2n-2k}_{n-k}(x +\!\!\!\!\!+ (1,\ldots,1))$
    - $n-2k$ 個の 1 bit 列を連結
- case $n < 2k$
    - $\text{EXACT}^{2k}_{k}(x +\!\!\!\!\!+ (0,\ldots,0))$
    - $2k-n$ 個の 0 bit 列を連結

#### クエリ計算量

$\text{EXACT}^{2k}_k$ のクエリ計算量は、再帰の回数なので、最悪 $k$.
したがって、$\text{EXACT}^{n}_k$ のクエリ計算量は、最悪

$$\max\{k, n-k\}$$

となる.

### THRESHOLD

$n$ bit
$x_0, x_1, \ldots, x_{n-1}$
の内、$k$ 個 **以上** が立ってるか判定するアルゴリズムを
$\text{THRESHOLD}^n_k$
とする.

$$\text{THRESHOLD}^n_k : \{0,1\}^n \to \{\text{true}, \text{false}\}$$

#### THRESHOLD${}^{2k+1}_{k+1}$

まず初めに
$\text{THRESHOLD}^{2k+1}_{k+1}$
を考える.
これは即ち過半数ビットが立ってるかを判定する手続きである.

入力は $x_0, x_1, \ldots, x_{2k}$ の $2k+1$ 個.
これに関して

- $S_0 = \{ i : x_i = 0 \}$
- $S_1 = \{ i : x_i = 1 \}$

とする.
それぞれのサイズ (個数) について
$\#S_0 = \#S_1$
であることはない.
今
$\#S_0 > \#S_1$
とする.
逆の場合も同様であるので省略する.

まず、次のような性質がある.

- $0 \leq i \leq 2k$ について、
    - when $i \in S_0$
        - when $\#S_0 = \#S_1 + 1$: $\sum_{j \ne i} \hat{x}_j = 0$
        - when $\#S_0 > \#S_1 + 1$:
            - 任意の $j \ne i$ について
            - $\text{THRESHOLD}^{2k+1}_{k+1}(x) = \text{THRESHOLD}^{2k-1}_{k-1}(x \setminus \{x_i, x_j\})$
    - when $i \in S_1$
        - 任意の $j \ne i$ について
        - $\text{THRESHOLD}^{2k+1}_{k+1}(x) = \text{THRESHOLD}^{2k-1}_{k-1}(x \setminus \{x_i, x_j\})$

THRESHOLD では次の3つの操作を用いる:

1. $U_1$
    - 先述
1. $Q$
    - 先述
1. $U_3$
    - $U_3 |i\rangle = \frac{\sqrt{2k+1}}{2k} \left( \sum_{i<j} |i,j\rangle - \sum_{i>j} |j,i\rangle + \frac{1}{2k} |j\rangle \right)$
    - ユニタリ変換


EXACT と同様に $|0\rangle$ から初めてこれらに順に通す.

- $|0\rangle$
    - ${}_\vec{~~U_1~~} ~~ \frac{1}{\sqrt{2k}} \sum_{i=0}^{2k-1} |i\rangle$
    - ${}_\vec{~~Q~~} ~~ \frac{1}{\sqrt{2k}} \sum_{i=0}^{2k-1} \hat{x}_i |i\rangle$

$$
{}_\vec{~~U_3~~}
~~
\frac{\sqrt{2k-1}}{2k \sqrt{2k+1}} \sum_{i<j} (\hat{x}_i - \hat{x}_j) |i,j\rangle
+ \frac{1}{2k\sqrt{2k+1}} \sum_{i=0}^{2k} \sum_{i \ne j} \hat{x}_i |j\rangle$$

これを測定すると

1. $|i,j\rangle$ または
2. $|j\rangle$

のいずれかを得る.

1. $|i,j\rangle$ を得た時、

$\hat{x}_i - \hat{x}_j \ne 0$
であるから、$x_i \ne x_j$.
従って

$$\text{THRESHOLD}^{2k+1}_{k+1}(x)
= \text{THRESHOLD}^{2k+1}_{k+1}(x \setminus \{x_i, x_j\}$$

2. $|j\rangle$ を得た時、

$\sum_{i \ne j} \hat{x}_i \ne 0$.
先ほどの性質を思い出せば、

$$\text{THRESHOLD}^{2k+1}_{k+1}(x)
= \text{THRESHOLD}^{2k+1}_{k+1}(x \setminus \{x_i, x_j\}$$

以上から、ちょうど $k$ 回、再帰的に $U_1, Q, U_2$ を適用することで

$$\text{THRESHOLD}^1_0(x_0) = x_0$$

というわけで
$\text{THRESHOLD}^{2k+1}_{k+1}$
はクエリ計算量 $k+1$ で解ける.

#### THRESHOLD${}^{n}_k$

EXACT と同じ感じでやる.

クエリ計算量は、

$$\max \{k+1, n-k+1\}.$$



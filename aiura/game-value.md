% ゲームの値
% 2016-11-23 (Wed.), 2017-08-09 (Wed.)
% 数学 ゲーム理論
% ゲームの値

これは [game-class.html](game-class.html) とか [game-algebra.html](game-algebra.html) の続き

## INDEX

<div id=toc></div>

## 参考文献

- M.H.Albert (著), R.J.Nowakowski (著), D.Wolfe (著), 川辺 治之  (翻訳): "組合せゲーム理論入門 －勝利の方程式－" (2011)

## ゲームの定義 (復習)

二人組み合わせゲームを Conway の方法で形式的に表現する.

ゲームは次のように再帰的に定義される.

1. $\{|\}$ はゲームである.
2. $g_1, \ldots, g_n, h_1, \ldots, h_m$ がゲームであるとき、 $$\{g_1, \ldots, g_n | h_1, \ldots, h_m\}$$ もまたゲームである
    - 略記法として、集合 $G=\{g_1, \ldots, g_n\}, H=\{h_1, \ldots, h_m\}$ として $\{G|H\}$ とも書く

### 等価性、順序

[ゲームの代数](game-algebra.html) 参照のこと.

重要な性質としては

- ゲーム $G$ は後手必勝
    - $\iff G = 0$
- $G$ は先手必勝
    - $\iff G \| 0$ (比較不能)
- $G$ は左必勝
    - $\iff G > 0$
- $G$ は右必勝
    - $\iff G < 0$

## ゲームの値

ゲームに値を対応させる.

まずは、次のように、一部のゲームに整数値を対応させる.

- $\overline{0} = \{|\}$
- $\overline{1} = \{\overline{0}|\}$
    - $\overline{-1} = \{|\overline{0}\}$
- $\overline{2} = \{\overline{1}|\}$
    - $\overline{-2} = \{|\overline{-1}\}$
- $\overline{n} = \{\overline{n-1}|\}$ ($n>0$)
    - $\overline{-n} = \{|\overline{1-n}\}$ ($n>0$)

ここでゲーム $G$ が整数 $n$ に対応していることを $G=\overline{n}$ と書いた.

> $n \geq 0$ に対して $\overline{n}$ は左が自由に $n$ 手打てるゲームを表している.
> ゲームのマイナス (左右の入れ替え) が整数のマイナスに対応している.

### ゲームの代数との対応

[ゲームの代数](game-algebra.html) でゲームの和や大小比較を定義したが、
これが今回定義した整数の上の和や大小比較と一致する.

例えば $\overline{n} + \overline{m} = \overline{n + m}$ (ゲームの $=$) は自明.

整数 $a,b,c$ があって、
ゲーム
$A=\overline{a}$,
$B=\overline{b}$,
$C=\overline{c}$ があるとする.

- $A+B+C \geq 0 \iff a+b+c \geq 0$
- $A+B = C \iff a+b = c$
- $A \geq B \iff a \geq b$

## 2進有理数

分母が (2以上の) 2の冪数である有理数を2進有理数と呼ぶ.

今度は、整数と対応付けられなかったゲームのうちの幾つかを2進有理数と対応付ける.

$j \geq 1$、奇数 $m$ について

$$\overline{~\frac{m}{2^j}~} =
\left\{~
\overline{~\frac{(m-1)/2}{2^{j-1}}~}
~|~
\overline{~\frac{(m+1)/2}{2^{j-1}}~}
~\right\}$$

右辺には分母が $2^0=1$ となることがあるが、これは先述の整数とみなす.
例えば、
$\overline{1/2} = \{0|1\}$.

### 例題

$\overline{1/2} + \overline{1/2} = \overline{~1~}$ が成立する.

これを示すのに、
$\overline{1/2} + \overline{1/2} - \overline{~1~} = 0$
すなわち
$\overline{1/2} + \overline{1/2} - \overline{~1~}$ が後手必勝であることを言えばいい.

先手が $1/2$ について打って $0$ (左) または $1$ (右) になったら後手はもう一つの $1/2$ について
$1$ または $0$ にすることで、
ゲームは
$\overline{~1~} - \overline{~1~}$ になる.
これが後手必勝なのは自明.

先手が右で $-\overline{1}$ $(=\overline{-1})$ を打ったらゲームは $1/2 + 1/2$ になる.
これはどう転んでも左必勝.
従って後手必勝.

### ゲームの代数との対応

整数と同様.

- $A+B+C \geq 0 \iff a+b+c \geq 0$
- $A+B = C \iff a+b = c$
- $A \geq B \iff a \geq b$

$+, \geq$ がゲームについて言ってるのか、整数・2進有理数について言ってるのかの区別は必要ない.

面倒なので $\overline{n}$ も単に $n$ と書いて、
数とゲームを混ぜて足したりする (ゲームであるほうにキャストする).

### 弱数避定理 (Weak Number-Avoidance)

以上の、整数または2進有理数に対応づくゲームを「数である」という.

<div class=thm>
数 $x$ であるゲームと、数でないゲーム $G$ との和 $G+x$ について、
先手の左が $x$ に手を打って勝つならば、
代わりに $G$ に手を打っても勝つ.
</div>

> 「$G$ で左が先手で勝つ」を「$G^L$ で左または後手が勝つ」と読み替えると、
> $G^L \geq 0$ と容易に書き直せる.

定理の主張を言い換えると、
$G+x^L \geq 0$
ならば、
$G^L+x \geq 0$
と言っている.

$G$ が数でないので、$G+x^L=0 \iff G=-x^L$ とあることはない.
従って、
$G+x^L \geq 0$
ならば
$G+x^L > 0$.
すなわち $G+x^L$ は左必勝.
ここから左が $G$ が打った局面でも左必勝、または後手必勝で、
$G^L + x^L \geq 0$.

さて数の定義から、 $x^L < x$.

これを推移させると
$G^L + x > G^L + x^L \geq 0$.
以上から主張は正しい.

### 誘因

左誘因も右も等しく、
$$G^L - G = G - G^R = -\frac{1}{2^j} < 0$$
となる.

## 無限小

<div class=thm>
数でないゲーム $G$ について、任意の正の数 $x$ に対して
$$-x < G < x$$
が成立するとき、 $G$ は無限小であるという.
</div>

ゲーム $\{0|0\}$ に特別に $\ast$ という名前を与える.

<div class=thm>
ゲーム $\ast = \{0|0\}$ は無限小である.
</div>

ゲーム $\ast$ は左右に関わらず先手必勝のゲームのことである.
従って $\ast$ は $0$ と比較不可能 ($\ast || 0$)
(比較不可能、及び $\geq$ の [定義](game-algebra.html#5) より明らか).
なので $\ast$ は数では無い (数なら比較可能なので).

次に $x > 0$ なる任意の数 $x$ について $x + \ast > 0$ を示す.
正であること $(>0)$ は、先手後手に関わらずに左が勝つこと $(\in \mathcal{L})$ が必要十分だった.

左が先手なら、まず左は $\ast$ に対して手を打って $0$ にすることで、ゲームを
$x + 0 = x$
とでき、$x$ は定義より $x \in \mathcal{L}$ であったので、これは左必勝.

左が後手であるとき、
先述した弱数避定理によれば $\ast$ に打つ方がまだマシである.
しかし右が $\ast$ に手を打っても、ゲームは $x+0$ となるだけでやはり左必勝.

というわけで
$$x + \ast > 0 \iff -x < \ast$$
が示された.
さて $\ast$ のその定義から明らかに
$$\ast = -\ast$$
が成立する.
これを代入すれば
$$\ast < x$$
も同時に確認できる.
結局
$$-x < \ast < x$$
であることが確認できた.

### $\uparrow, \downarrow$

$\ast$ を使って次の2つのゲームを新たに定義する.
数でないものを含んでるので明らかに次の2つも数ではない.

- $\uparrow = \{ 0 | \ast \}$
- $\downarrow = \{ \ast | 0 \} ( = - \uparrow)$

これらはともにやはり無限小であり、かつ、

- $\uparrow > 0$
- $\downarrow < 0$

である.

### 全微小 (all-small) ゲーム

ゲーム $G$ から導かれるすべての局面について
「左に打つ手があるとき、またそのときに限り、右にも打つ手がある」
が成立するとき、$G$ は全微小ゲームであるという.
例えば $0$ や $\ast$ や $\uparrow, \downarrow$ が全微小ゲームである.

<div class=thm>
$G$ が全微小ならば、$G$ は無限小である.
</div>

その定義から $G$ は、含む選択肢のすべてが全微小である.
たぶん帰納法で証明できる.
その基底は $G=0$ のとき.

数 $x>0$ に対して $G+x$ が左必勝であること $(G+x>0)$ を示したい.

左が先手なら数を避けて $G$ を進めて $G^L + x$ とする.
定義より $G^L$ もまた全微小であり、そして帰納法の仮定で $G^L$ を無限小であるとする.
従って $G^L > -x$ なので $G^L + x > 0$ で、左必勝.
従って左が先手なら $G+x$ は左が勝つ.

左が後手のとき.
右は数を避けるべきで $G^R + x$ とする.
同様に $G^R$ は無限小なので $G^R > -x$.
$G^R + x > 0$.
なので左が勝つ.

以上から $G + x > 0$. $\iff -x < G$.
同様に $G < x$ を示して無限小であることがわかる.

### $\uparrow$, $\ast$ の比較

<div class=thm>
$$\downarrow \| \ast \| \uparrow$$
</div>

ゲームの差 $G = \uparrow - \ast$ を考える.
これが $0$ と比較不能であればいい. つまり先手必勝.

$\ast = -\ast$ を使うと $G$ は
$G = \uparrow + \ast$
と和の形に書き直せる.
和にすれば具体的に考えることができて、
左の先手なら $\uparrow$ に手を打てば $G^L=0$ とできて勝ち.
右の選定なら $\ast$ に手を打てばやはり $G^R=0$ とできて勝つ.
従って、$G$ は先手必勝なので
$$\uparrow - \ast \| 0.$$
差がゼロと比較不能なので
$$\uparrow \| \ast.$$

$\downarrow = - \uparrow$ についても全く同様に示せる.

<div class=thm>
$$\downarrow + \downarrow < \ast < \uparrow + \uparrow$$
</div>

$\downarrow, \uparrow$ は一つだけだと比較不能だけど2つ (以上) の和だとこのように順序付けることが可能.

差
$G = \uparrow + \uparrow - \ast = \uparrow + \uparrow + \ast$
について
$G > 0$ を示せばよい.
(これが示せれば $-G < 0 \iff \downarrow + \downarrow - \ast < 0$ も導かれる.)

ゼロより大きいことは左必勝に等しいので、3つのゲーム和 $G = \uparrow + \uparrow + \ast$ が左必勝であることを具体的に示す.

左先手のとき下のゲームグラフが描けるが、左は赤いエッジを辿ってれば絶対勝てる.
ただしここで、$\uparrow + \uparrow + \ast$ を $\uparrow\uparrow\ast$ のように $+$ を省略して記述している.

```dot
digraph {
    bgcolor=transparent;
    rankdir=LR;
    "↑↑*" [shape=doublecircle];

    "↑↑*" -> "↑↑" [label=L color=red];
    "↑↑*" -> "↑*" [label=L color=gray];

    "↑*" -> { "**" "↑" } [label=R color=gray];
    "↑↑" -> "↑*" [label=R];

    "**" -> "*" [label=L color=gray];
    "↑" -> 0 [label=L color=gray];
    "↑*" -> "*" [label=L color=gray];
    "↑*" -> "↑" [label=L color=red];

    "*" -> 0 [label=R color=gray];
    "↑" -> "*" [label=R];

    "*" -> 0 [label=L color=red];

    {rank=same "↑↑" "↑*" "↑"}
    {rank=same "**" "*" "0"}
}
```

左が後手のときは下図のように.

```dot
digraph {
    bgcolor=transparent;
    rankdir=LR;
    "↑↑*" [shape=doublecircle];

    "↑↑*" -> "↑↑" [label=R];
    "↑↑*" -> "↑**" [label=R];

    "↑**" -> "**" [label=L color=red];
    "↑**" -> "↑*" [label=L color=gray];
    "↑↑" -> "↑" [label=L color=red];

    "↑" -> "*" [label=R];
    "**" -> "*" [label=R];
    "↑*" -> "**" [label=R color=gray];
    "↑*" -> "↑"  [label=R] color=gray;

    "*" -> 0 [label=L color=red]
    "**" -> "*" [label=L color=gray]
    "↑" -> 0 [label=L color=gray];

    "*" -> 0 [label=R color=gray];

    {rank=same "↑**" "↑↑" "**"}
    {rank=same "↑" "↑*"}
    {rank=same "*" 0}
}
```

というわけで差が左必勝なので、その順序が成立する.

$0<\uparrow$ なので、$\uparrow\uparrow < \uparrow\uparrow\uparrow$ が成り立ち、

$$\downarrow\downarrow\downarrow < \downarrow\downarrow < 0 < \uparrow\uparrow < \uparrow\uparrow\uparrow$$
が成立する.

## ゲームの自然数倍

ゲームのスカラー倍とその記法を定義する.
ゲーム $G$ と 1 以上の自然数 $n$ に対して、$G$ の $n$ 個の和
$$G + G + \cdots + G$$
を
$$n\cdot G$$
と書く.

これに加えて
$$0\cdot G = 0$$
$$(-n) \cdot G = n\cdot (-G)$$
も定義することで、ゲームの自然数倍を定義する.

結合優先度として、$\cdot$ は $+$ より高いものとする.
例えば
$n \cdot \uparrow \ast$
($n \cdot \uparrow + \ast$ のこと)
は
$n \cdot (\uparrow \ast)$ **ではなく**
($n \cdot \uparrow) \ast$ である.

演算子を省略してゲームを並べる場合 $+$ を省略したものとしているので、$\cdot$ は省略しない.

### $n \cdot \uparrow$ の標準形

明らかに劣位な選択肢を予め除去し、打ち消し可能な手を予め打ち消しておいた形を標準形というのだった [[aiura/game-algebra]](./game-algebra.html#6).
標準形はあくまでもこの2つのルールを繰り返し適用して導出される.

ここでは $n \cdot \uparrow$ $(n \geq 1)$ の標準形を調べる.
選択肢はどちらにしろ、$n$ 個ある $\uparrow$ から一つの $\uparrow$ を選んで手を進めるだけなので、
$$n \cdot \uparrow = \{ (n-1) \cdot \uparrow | (n-1) \cdot \uparrow\ast\}$$

まず片手枷原理をチェックする.
左右とも選択肢は1つずつなのでこれは適用できない.

次に打ち消し可能な手を探す.
まず右についてだが、左の応手は
$$(n-2)\cdot\uparrow, (n-1)\cdot \uparrow$$
(一旦十分大きい $n$ を用いている) であり、元のゲーム $n \cdot \uparrow$ と比べて、どちらも大きくなっている (即ち右にとって劣位) ということは無い.
なので右の手を打ち消すような手は無い.

一方で左の $(n-1)\cdot\uparrow$ というのは打ち消し可能で、
右は $(n-2)\cdot\uparrow\ast$ という手で打ち消す (それしか選択肢がないわけだが).
$$\ast < 2\cdot\uparrow$$
であることに註意すると
$$(n-2)\cdot\uparrow\ast < (n-1)\cdot\uparrow$$
であり打ち消すことがわかる.
というわけで、これの左選択肢
$$(n-3)\cdot\uparrow\ast, (n-2)\cdot\cdot\uparrow$$
で短絡できる.

$$\begin{align*}
n \cdot \uparrow
& = \{ (n-1) \cdot \uparrow ~|~ \cdots \} \\
& = \{ (n-2) \cdot \uparrow, (n-3) \cdot \uparrow\ast ~|~ \cdots \}
\end{align*}$$

さて左選択肢に再び「$\uparrow$ の整数倍」が登場するので、再び同様の短絡が出来る.

$$\begin{align*}
n \cdot \uparrow
& = \{ (n-1) \cdot \uparrow ~|~ \cdots \} \\
& = \{ (n-2) \cdot \uparrow, (n-3) \cdot \uparrow\ast ~|~ \cdots \}
& = \cdots \\
& = \{ \uparrow, 1\cdot\uparrow\ast, 2\cdot\uparrow\ast, \cdots, (n-4)\cdot\uparrow\ast, (n-3)\cdot\uparrow\ast ~|~ \cdots \}
\end{align*}$$

さて、次に左選択肢の $m\cdot\uparrow\ast$ ($m \leq n-3$) について考える.
これも右にとって打ち消し可能な手である.
すなわち、

$$n\cdot\uparrow \to^L m\cdot\uparrow\ast \to^R m\cdot\uparrow$$
について
$$m\cdot\uparrow < n\cdot\uparrow$$
である ($m <n$ なので).
なので、やはり左の $m\cdot\uparrow\ast$ という手は、
$m\cdot\uparrow$ に対する左の選択肢で置き換えて短絡する.
左の選択肢はただ1つしかなく、しかもそれは $(m-1)\cdot\uparrow$ である.
というわけでたくさんある
$$1\cdot\uparrow\ast, 2\cdot\uparrow\ast, \cdots, (n-4)\cdot\uparrow\ast, (n-3)\cdot\uparrow\ast$$
という選択肢の係数を 1 ずつ減らしていって、結局すべてをゼロにしてしまえる.
$$n \cdot \uparrow = \{ \uparrow, 0 ~|~ (n-1)\cdot\uparrow\ast \}$$

最後に $0<\uparrow$ なので、
$$n \cdot \uparrow = \{ 0 ~|~ (n-1)\cdot\uparrow\ast \}$$
とまで出来る.

さて $n-3$ というが出てきてるので以上の考察は $n\geq3$ くらい大きい数を考えている.
小さい $n$ については個別に調べれば、やはり今の結論と同じ形をしていることがわかる.

% 汎化システム
% 2015-01-14
% 形式言語 言語獲得

## Introduction

正規言語というものを考えると, これは言語に対して正規表現（あるいはオートマトン）が一対一対応している.
すなわち何か言語を説明する description $p$ というものがあって, 同型写像 $L$ によって $L(p)$ という言語を構成することが出来る.

ある言語クラス $\mathcal L$ は
写像 $L$ によってある集合 $D$ と同型.
この $D$ の元を description と呼ぶ.

$$\begin{align*}
L \colon & D \simeq \mathcal L \\
L \colon & p \mapsto L(p) \\
\end{align*}$$

正規言語の場合, この写像 $L$ とはパターンにマッチする文字列を集めるという関数（オートマトンなら受理する文字列）.
$$L(p) = \{ s \preceq p \mid s \in \Sigma^* \}$$
ここでマッチするという関係を $\preceq$ と書いた.

汎化システムはこのまさにマッチという関係を半順序として一般化することで一般のパターン言語を構成する.

## 汎化システム

$D$ を description の集合とし, そこに半順序 $\preceq$ を入れる.
ただし $D$ は最大元 $\top$ を持つとする.
このとき $$(D, \preceq)$$を汎化システムと呼ぶ.

### 汎化

半順序 $\preceq$ を汎化関係と呼ぶ.

$p \preceq q$ のとき,
$q$ は $p$ の generalization であるといい,
また $p$ から $q$ を構成することを generalize という.
逆に $p$ は $q$ の instance であるといい,
$q$ から $p$ を構成することを refine という.

### object

$p \in D$ が極小元であるとき, $p$ は object であるという.
$$p \text{ is object } \iff \forall q \in D, q \not\prec p$$
すなわちそれ以上 refine できないものを object というのである.

### 定理

$$p \preceq q \implies L(p) \subseteq L(q)$$

#### 証明

$$\begin{align*}
s \in L(p)
& \iff s \preceq p ~~\text{(言語の定義)} \\
& \implies s \preceq q ~~\text{(推移律)} \\
& \iff s \in L(q) ~~\text{(言語の定義)}
\end{align*}$$

## 汎化システムの完全性

先の定理の逆
$$L(p) \subset L(q) \implies p \preceq q$$
は一般には成立 **しない**.
これが常に成り立つような汎化システムは **完全 (complete) である** という.

## 正規パターン (Regular Pattern)

**パターン** 及び **正規パターン** を次で定義する.
(いわゆる正規表現ではなくそれより単純化されたものであることに注意.)

- 大きさ 2 以上の有限集合: $\Sigma = \{0,1,\ldots\}$
    - $\Sigma$ の元を **アルファベット** という
    - 文字列 (object): $\Sigma^+$
    - 空文字列: $\Sigma^0 = \{ \epsilon \}$
- 無限集合 $X = \{x,y,z,\ldots\}$
    - この元を **変数** という
- **パターン** とはアルファベットと変数からなる列
    - $(\Sigma \cup X)^+$ の元
    - e.g. $x$, $0x2xy$, $01214$
- **正規パターン** とはパターンであって, 一つの変数は高々一度しか出現しないもの
    - パターン全体を RP と書くことにする
    - e.g. $x$, $0x2yz$, $01234$

### 代入

（正規）パターンについて **代入** という操作を定義する.

あるパターンについて, その中に出現する変数一つをパターンで置き換える操作を代入という.
代入によって出来る文字列はやはりパターンである.
正規パターンの場合は正規パターンで置き換える.

そして, 正規でないパターンの場合, 同じ変数が複数回出現することがあるが, その場合は全て同じパターンで置き換える.
また正規パターンの場合は代入によって変数が衝突して正規でなくなる可能性があるが, そのような代入は許さず, 代入でできるパターンも正規であるよう保証する.

パターン $p$ 中の変数 $x$ を $q$ で置き換えて出来るパターンを $p[q/x]$ と書くことにする.

以下に代入の例を挙げる.

- $(1x4y)[z/x] = 1z4y$
- $(1x4y)[23/x] = 1234y$
- $(1x4y)[x3/x] = 1x34y$
- $(1x4yy)[5/y] = 1x455$ (正規でない場合)

今パターンは1文字以上であると定義したので, 変数への代入によって全体の文字数は減らない.
変数をただ消すだけのことができないのでこれを **消去不能 (non-erasing)** パターンと呼ぶ.

バリエーションとして, 特別に空文字列の代入も許す代入もあり, それは **消去可能 (erasing)** パターンと呼ぶ.
当然表現力としてはこちらのほうが豊かである.

以下は消去可能パターンの代入の例.

- $(1xy)[/x] = 1y$

> ちなみに代入という操作は [Shinohara91](https://link.springer.com/chapter/10.1007/3-540-11980-9_19) では単に
> "any (possibly erasing) homomorphism from P to P" つまりパターンからパターンへの準同型写像であって,
> ただし "If f(a) = a for any constant a" つまりアルファベット自体はアルファベット自体に写すようなもの, と定義されている.
> 準同型の意味であるが, おそらく文字列結合に関する準同型のことだろうと思われる.
> すなわち $\theta a \cdot \theta b = \theta (a \cdot b)$ を満たす $\theta$ 全てを代入と呼ぶ.

### 正規パターン言語

以下, 正規パターンに絞って話すが, パターンでも同じ.
正規パターン全体を RP と書くことにする.
また消去不能か可能かは先に決めておけばどちらでもいい.

### 正規パターンの汎化システム

正規パターンを description とし, 代入の関係を順序にすることで汎化システムになる.
すなわち,
$q$ にある代入を行うと $p$ になるとき, $p \preceq q$ と定める.
$$\exists x \in X, \exists r \in RP, p = q[x/r] \iff p \preceq q$$
このとき $(RP, \preceq)$ は汎化システムである.

### 同値関係

普通の順序の場合と同様に
$$p = q \iff p \preceq q \land q \preceq p$$
と定義する.

これによって同値になるのは, 全く見た目が同じ場合の他に変数の置換がある.
例えば $x = y$ である.
これは変数一つに変数一つを代入した場合.

消去可能パターンの場合はそれに加えて, 変数一つに1つ以上の変数を代入するのも同値関係である.
例えば $x = xy = xyz$ である.
0個にしちゃうと戻せないのでだめ.
$0 \preceq 0x$ だが $0 \succeq 0x$ ではない.

### 正規パターン言語

RP に対して汎化システムを定義したので言語を定義出来る.
それを正規パターン言語と呼ぶ.
以下に例を示す.

- $L(0x01y0) = \{ 0x01y0 \mid x \in \Sigma^+, y \in \Sigma^+ \}$ (消去不能の場合)
- $L(0x01y0) = \{ 0x01y0 \mid x \in \Sigma^*, y \in \Sigma^* \}$ (消去可能の場合)

さて $\preceq$ の極小元のことを object と呼ぶと先に延べたが,
明らかに object とは $\Sigma^+$ のことであり, 言語の元のことである.

### 正規パターン言語の完全性

$|\Sigma| > 2$ のとき以下は成り立ち, その汎化システムは完全である.
$$L(p) \subseteq L(q) \implies p \preceq q$$
しかし $|\Sigma| = 2$ のときは凡例があり成り立たない.

### アルファベットサイズが 2 の消去可能正規パターン言語の汎化システムは不完全

$\Sigma=\{0,1\}$ とする.
コレに対して次の2つの正規パターンを考える.

- $p = x 01 y 0 z$
- $q = x 0 y 10 z$

$L(p) = L(q)$ であるが $p \not\preceq q$ かつ $q \not\preceq p$ である.

### アルファベットサイズが 3 以上の消去可能正規パターン言語の汎化システムは完全

証明は
[Shinohara91](https://link.springer.com/chapter/10.1007/3-540-11980-9_19)
による.
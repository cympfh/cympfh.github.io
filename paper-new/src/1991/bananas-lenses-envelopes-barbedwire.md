% Functional Programming with Bananas, Lenses, Envelopes and Barbed Wire
% https://maartenfokkinga.github.io/utwente/mmf91m.pdf
% 一般の再帰型について畳み込み操作やその逆操作を与える
% 計算 圏論

$$
\require{amscd}
\def\N{\mathbb{N}}
\def\R{\mathbb{R}}
\def\Normal{\mathcal{N}}
\def\ip#1#2{\langle #1, #2 \rangle}
\def\Pr{\mathop{\mathrm{Pr}}}

\def\banana#1{(\!|#1|\!)}
\def\lense#1{[\!(#1)\!]}
\def\envelop#1{[\![ #1 ]\!]}
\def\wire#1{[\!\!\langle #1 \rangle\!\!]}

\DeclareMathOperator{\cons}{cons}
\DeclareMathOperator{\foldr}{foldr}
\def\Nil{\mathrm{Nil}}
\def\Bool{\mathrm{Bool}}
\def\true{\mathrm{true}}
\def\false{\mathrm{false}}
\def\const#1{#1^\bullet}

\def\as{\mathit{as}}
\def\join{\mathrm{join}}

\def\Hom{\mathrm{Hom}}
\def\fin{\mathrm{in}}
\def\fout{\mathrm{out}}
\def\farrow#1#2#3{(#1 \xleftarrow{#3} #2)}
$$

## Intro

リストデータについて filter や map であったり fold, unfold といった操作がある.
これらは実は catamorphism, anamorphism, hylomorphism, paramorphism という4つの基本的な射を定めることで, それらの組み合わせ, 或いはそれそのものと見なすことが出来る.
そしてこれらはリストに限らず一般の再帰型についてそのまま適用することが出来る.

## Note

圏論の知識は次程度を仮定する.

* 圏の定義
* 対象の積, 和
* 関手
* 圏の積

ただしこの記事においてはその知識が深い必要はない.
考えている圏は常に性質が良いもので,
例えば積や和は常に存在するとしてよい.
具体的には Hask 圏か Set 圏を考えていると思えば良い.

また **型** という用語を無断で用いているが,
この場合は Hask 圏の対象を言っている.
集合 $A$ について $a \in A$ と書くことと,
型 $A$ の値 $a : A$ と書くことを区別しない.

## Notation

### 括弧

この論文では独特な括弧が4種類導入されている.
元論文の印刷とは多少見た目が違うが,
頑張って模倣して次のように表記する.

| 名称       | 表記           | 代替表記 | 備考        |
|:-----------|:--------------:|:--------:|:------------|
| バナナ括弧 | $\banana{\_}$  | `(| |)`  | Bananas     |
| レンズ括弧 | $\lense{\_}$   | `[( )]`  | Lenses, 凹レンズ |
| 封筒括弧   | $\envelop{\_}$ | `[[ ]]`  | Envelopes   |
| 有刺鉄線   | $\wire{\_}$    | `[< >]`  | Barbed Wire |

### 定数写像

- 集合 $A,C$ と $c \in C$ について
    - $\const{c}$ とは $C$ の定数写像 $A \to C$
        - $\const{c}(a) = c$

### 圏論の記法

この論文の記法はずいぶん古いものなので現代風の記法に従う.

- 射
    - $f \colon A \to B$
    - 合成 $f \circ g$
- 積
    - 対象 $A \times B$
    - 射影関数 $\pi_1, \pi_2$
    - 2つの射 $f \colon A \to B, g \colon C \to D$ に対して
        - $f \times g \colon A \times B \to C \times D$ を自然に定める
    - 対角射 $\Delta$
        - 任意の対象 $A$ について
            - $\Delta \colon A \to A \times A$
    - $f \colon A \to B, g \colon A \to C$ について
        - $(f \Delta g) \colon A \to B \times C$
            - $(f \Delta g) := (f \times g) \circ \Delta$
- 和
    - 対象 $A + B$
    - 包含射 $\iota_1, \iota_2$
    - 2つの射 $f \colon A \to B, g \colon C \to D$ に対して
        - $f + g \colon A + B \to C + D$ を自然に定める
    - 余対角射 $\nabla$
        - 任意の対象 $A$ について
            - $\nabla \colon A + A \to A$
    - $f \colon A \to C, g \colon B \to C$ について
        - $(f \nabla g) \colon A + B \to C$
            - $(f \nabla g) := \nabla \circ (f + g)$
- homset
    - $A,B$ について
        - $\Hom(A,B)$ は $A \to B$ なる射全体の集合
- 恒等射, 恒等関手
    - 単に $1$ と書いて添字は省略する
- 終対象
    - 単に $1$ と書く

と書く.

### Sectioning

空間 $X$ 上にある任意の二項演算子 $\otimes \colon X \times X \to X$ について,
演算する値を1つだけ与えて固定すれば,
これを $X \to X$ なる関数と思うことが出来る.

- $(a \otimes) \colon X \to X$
    - $(a \otimes)(b) = a \otimes b$
- $(\otimes b) \colon X \to X$
    - $(\otimes b)(a) = a \otimes b$

### リスト

型 $A$ に対してリスト型を $[A]$ と書く.

要素がゼロ個であるリストを空であると言って $\Nil$ と書く.

また $\cons \colon A \times [A] \to [A]$ はリストの先頭に要素を追加する関数である.
空でないリスト $x: [A]$ は必ずある $a: A, \as: [A]$ があって
$x = \cons(a, \as)$ と書けることに注意.

## リストの場合

リストの場合の catamorphism, anamorphism, hylomorphism, paramorphism がどんなものか具体的に見ていく.

ただしリスト型 $[A]$ の厳密な定義をまだしていない (次章で与える).
この章では一旦「型 $A$ の値をゼロ個以上自由に持ってきて一列に並べたデータ」と直感的に理解しておく.

### catamorphism

"cata-" は catastrophic のそれであって, 下方へ, といった意味らしい.
リストについての catamorphism は次の関数 $h$ をいう.

- $h \colon [A] \to B$
- $h~\Nil = b$
- $h~(\cons(a, \as)) = a \oplus h(\as)$

ここで $b$ は $B$ の定数. $\oplus$ は $A \times B \to B$ なる二項演算子.
このような形の $h$ は Haskell のような言語では `foldr` として知られており
$$h = \foldr(b, \oplus)$$
のように書ける.
この `foldr` の代わりに, ここでは **バナナ括弧** で括ることで
$$h = \banana{b, \oplus}$$
と書く.

バナナ括弧を使うと例えば次のような関数が定義できる.

- リストの長さを取る関数 `length`
    - $\mathrm{length} = \banana{0, (\_,n)\mapsto n+1}$
- 条件 `p` を満たす要素だけを残したリストを作る `filter`
    - $\mathrm{filter}(p) = \banana{\Nil, (a, z) \mapsto \begin{cases} \cons(a, z) & \text{ when } p~a \\ z & \text{ otherwise }\end{cases}}$

### anamorphism

ちょうど catamorphism の逆のもので, `unfold` のような名前で知られている関数 $h$ を次のように定義する.

- $h \colon B \to [A]$
- $h~b = \begin{cases} \Nil & \text{ when } p~b \\ \cons(a, h~b') & \text { otherwise, where } (a,b')=g~b\end{cases}$

ただしここで $p$ は $B \to \Bool$ なる述語関数.
$g$ は $B \to A \times B$ なる関数.

$g,p$ で定まるこの関数 $h$ のことを, レンズ括弧で括って
$$h = \lense{g, p}$$
と書く.

例えば, 関数 $f \colon A \to A$ を繰り返し適用する `iterate f` という関数 $A \to [A]$ は
$\lense{a \mapsto (a, f~a), \const{\mathrm{false}}}$
と書ける.

#### map 関数

リスト $[A]$ と関数 $f \colon A \to B$ があるときに, リストの各要素に $f$ を適用することで $[A] \to [B]$ という関数を構成することができる.
Haskell では `map f` とこれを書くが, 論文に倣って $f*$ と書くことにする.
これは $[A]$ からの catamorphism として書くこともできるし, $[B]$ への anamorphism と書くこともできる.

- $f* = \banana{\Nil, (a, b) \mapsto \cons(f~a, f*b)}$
- $f* = \lense{\cons(a, \as) \mapsto (f~a, \as), \mathrm{nil}}$
    - where
        - $\mathrm{nil}~\Nil=\mathrm{true}$
        - $\mathrm{nil}~\cons(x, xs)=\mathrm{false}$

### hylomorphism

リストに関する hylomorphism とは,
例えば木構造をリストにしてやるような「線形再帰関数」のもの.
具体的には
$$h : A \to C$$
$$h~a = \begin{cases}c & \text{ when } p~a\\ b \oplus h~a' & \text{ otherwise, where } (b,a') = g~a\end{cases}$$
と書き表されるもの.
ここで
$c \colon C$,
$g \colon A \to B \times A$,
$\oplus \colon B \times C \to C$
であって $h \colon A \to C$ である.

今度の $h$ は $c,\oplus, g,p$ という4つで決まる.
（ややトリッキーだが）次のように並べて封筒括弧で包んで
$$h=\envelop{(c,\oplus), (g,p)}$$
と書き表すことにする.

そしてこれは
$$\envelop{(c,\oplus), (g,p)} = \banana{c,\oplus} \circ \lense{g,p}$$
という合成の形に分解できる.
この証明は論文にはあるが省略.
リストが一見登場しないが, この合成の形を見るとその中間でリストを経由してることが分かる.

例えば自然数の階乗を計算する関数 $\mathbb N \to \mathbb N$ は
$\envelop{(1,\times), ((1+n) \mapsto (1+n, n), \mathrm{zero})}$
と書ける.
ここで $\mathrm{zero}$ は引数がゼロかを判定する述語とする.
つまり
$\lense{g,\mathrm{zero}}(m)=[m,m-1,\ldots,1]$
であって
$\banana{1,\times}$ はそれを乗算しながら畳み込む関数である.

### paramorphism

原始再帰のパターンを提供するのが paramorphism であって,
リストに関する paramorphism は 次のように定義される.

- $h \colon [A] \to B$
- $h~\Nil=b$
- $h~\cons(a,\as)= a \oplus (\as, h~\as)$

ここで $b\colon B$, $\oplus\colon A \times([A]\times B) \to B$ である.
このような $h$ はやはり $b,\oplus$ で決定されるので,
有刺鉄線で括って
$$h=\wire{b, \oplus}$$
と書くことにする.

$\oplus$ の型が豪華になったので, 値を蓄積しながらのような関数が書けるようになった.
例えば `tails` は
$\wire{\cons(\Nil,\Nil), (a\oplus(\as,ac)=\cons(\cons(a,\as),ac))}$
と書ける.

## 矢印

矢印 $(\leftarrow)$ という二項演算子を定義する.

2つの射
$f \colon A \to C$ と
$g \colon C' \to B$ について
$$(g \leftarrow f) \colon \Hom(C, C') \to \Hom(A, B)$$
$$(g \leftarrow f)(h) = g \circ h \circ f$$

を定める.

さらに関手 $F$ があるとき

$$\begin{align*}
\farrow{g}{f}{F}(h)
&= (g \leftarrow f)(Fh) \\
&=  g \circ Fh \circ f
\end{align*}$$

と書く.

2つ定義したけどこの最後のしか使わない.

## 不動点オペレータ

$A \to A$ なる射 $f$ について $f$ の不動点を $\mu f$ と書く.
$$\mu \colon \Hom(A, A) \to A$$

ここで不動点とは関数なら $f x = x$ なる $x$ のことを言う.
ここの意味は別途与えられているものとする.

## 再帰型

圏 $C$ の上の関手 $F \colon C \to C$ の不動点 $\mu_F$を次で定義する.

対象 $X \in C$,
射 $\fin \colon FX \to X$, $\fout \colon X \to FX$ が次を満たすとする

- $\fin \circ \fout = 1$
- $\fout \circ \fin = 1$
- $\mu(\fin \xleftarrow{F} \fout) = 1$

このときに $(X, \fin, \fout)$ のことを $F$ の不動点 $\mu_F$ と定める.
$\fout$ は $\fin$ の逆射で自明なものなので省略して $(X, \fin)$ としてもよい.

型の圏について上記の方法で関手 $F$ から $\mu_F = (X, \fin, \fout)$ を得たとき,
この $X$ を再帰型（あるいは再帰データなど）と呼ぶ.
また $\fin$ はその型の構成（データから再帰データを得る方法）になっている.
$\fout$ はその逆でデータを分解する方法になっている.

### リスト型

リスト型を定義する準備ができた.
関手 $LX = 1 + A \times X$ を考える.
このとき
$$\mu_L = ([A], (\const{\Nil} \nabla \cons))$$
を得る.
ここで

- $[A]$
    - これをリスト型と呼ぶ
- $\const{\Nil} \colon 1 \to [A]$
    - 空リストの定義
- $\cons \colon A \times [A] \to [A]$
    - リストの先頭に要素を追加する操作

というわけで
「リスト及びその構成は関手 $L$ の不動点のこと」
という定義を与えることができた.

念の為に $\fin, \fout$ を明示的に書くと次のようになっている.

- $\fin \colon [A] \to 1 + A \times [A]$
    - $\fin~\ast = \Nil$
        - ここで $\ast \in 1$
    - $\fin~(a, \as) = \cons(a, \as)$
- $\fout \colon [A] \to 1 + A \times [A]$
    - $\fout~\Nil = \ast$
    - $\fout~(\cons(a, \as)) = (a, \as)$

### 自然数

自然数も再帰型として定義できる.
関手 $NX = 1 + X$ の不動点を計算すると

- $\mu_N = (\N, \const{0} \nabla S)$
    - $\const{0} \colon 1 \to \N$
        - ゼロの定義
    - $S \colon \N \to \N$
        - successor の定義

を得る.

## ポリモーフィズム

2つの関手 $F, G$ について $\varphi$ がポリモーフィズムであるとは,
任意の対象 $A$ について射 $\varphi_A \colon FA \to GA$ を与えるようなもののことで,
$$\varphi \colon F \to G$$
と書く.

これは自然変換からその自然さについての要請を取り除いたもの.

## 再帰スキーム

一般の再帰型について
catamorphism, anamorphism, hylomorphism, paramorphism を与える.

関手 $F$ とその不動点 $\mu_F = (L, \fin, \fout)$ があるとする.
ここで3つのポリモーフィズム

- $\varphi_A \colon FA \to A$
- $\psi_A \colon A \to FA$
- $\xi_A \colon F(A \times L) \to A$

を自由に持ってくる.
このときに次を定義する.

- catamorphism
    - $\banana{\varphi}_F \colon L \to A$
    - $\banana{\varphi}_F = \mu(\varphi_A \xleftarrow{F} \fout)$
- anamorphism
    - $\lense{\psi}_F \colon A \to L$
    - $\lense{\psi}_F = \mu(\fin \xleftarrow{F} \psi_A)$
- hylomorphism
    - $\envelop{\varphi, \psi}_F \colon A \to B$
    - $\envelop{\varphi, \psi}_F = \mu(\varphi_B \xleftarrow{F} \psi_A)$
- paramorphism
    - $\wire{\xi}_F \colon L \to A$
    - $\wire{\xi}_F = \mu(g)$
        - where $g(f) = \xi_A \circ F(1 \Delta f) \circ \fout$

括弧の添字の $F$ は定義のために用いた $F$ を指すが,
文脈から明らかな場合これを省略する.
例えば $\banana{\varphi}_F$ の代わりに $\banana{\varphi}$ と書く.

## Fixed point fusion (Free theorem)

関数 $f$ が正格で $f \circ g = h \circ f$ なるとき,

$$f(\mu g) = \mu h$$

## Theorem (名称不明)

$gh=1$ のとき

$$\mu(f \xleftarrow{F} g) \circ \mu(h \xleftarrow{F} j) = \mu(f \xleftarrow{F} j)$$

## Catamorphisms

### CataEval

catamorphism を具体的に評価する手段を与える.

- 関手 $F$
- $\mu_F = (L, \fin, \fout)$
- $\varphi_A \colon FA \to A$

から catamorphism $\banana{\varphi}$ が与えられる.

定義から

$$\begin{align*}
\banana{\varphi}
& = \mu(\farrow{\varphi}{\fout}{F}) \\
& = \varphi_A \circ F\banana{\varphi} \circ \fout \\
\end{align*}$$

ここで右から $\fin$ を掛けると $\fout$ が消えるので

$$\banana{\varphi} \circ \fin = \varphi_A \circ F\banana{\varphi}$$

$$\begin{CD}
L @<\fin<< FL \\
@V\banana{\varphi}VV @VF\banana{\varphi}VV \\
A @<\varphi_A<< FA
\end{CD}$$

を得る.

この最後の結果を使えば catamorphism を評価することができる.

#### リストの `foldr`

次が与えられる.

- リスト $[A]$
    - 関手 $LX = 1 + A \times X$
    - 不動点 $\mu_L = ([A], \fin)$
        - $\fin = \const{\Nil} \nabla \cons$
- foldr $\banana{\varphi}$
    - ポリモーフィズム $\varphi_X = \const{c} \nabla \oplus$
        - $\const{c} \colon 1 \to X$
        - $\oplus \colon A \times X \to X$

では実際に $x \in [A]$ に対して $\banana{\varphi}~x$ を計算してみる.
$x$ が $\Nil$ か $\cons(a, \as)$ かで場合分けする.

$$\begin{align*}
\banana{\varphi}~\Nil
&= \banana{\varphi} (\fin ~ \ast) \\
&= (\banana{\varphi} \circ \fin) ~ \ast \\
&= (\varphi_A \circ F\banana{\varphi}) ~ \ast \\
&= (\varphi_A \circ (1 + 1 \times \banana{\varphi})) ~ \ast \\
&= \varphi_A \ast \\
&= \const{c} \ast \\
&= c \\
\end{align*}$$

$$\begin{align*}
\banana{\varphi}~\cons(a, \as)
&= \banana{\varphi} (\fin (a, \as)) \\
&= (\varphi_A \circ F \banana{\varphi}) (a, \as) \\
&= \varphi_A \circ (1 \times \banana{\varphi}) (a, \as) \\
&= \varphi_A (a, \banana{\varphi}~\as) \\
&= a \oplus (\banana{\varphi}~\as) \\
\end{align*}$$

後者は再帰的に $\banana{\varphi}$ を使っている.
ただしリストの長さを考えると単調減少しているので無限に再帰することはなく,
計算が有限で止まることが分かる.

### catamorphism の唯一性

次が成り立つ.

$$f = \banana{\varphi} \iff f \circ \fin = \varphi_A \circ Ff$$

つまり $f$ が catamorphism であることと,
先の CataEval の式が成り立つことは同値である.
このことは catamorphism の唯一性を示している.

### CataFusion

$f \circ \varphi_A = \psi_B \circ Ff$ のとき
$$f \circ \banana{\varphi} = \banana{\psi}$$

$$\begin{CD}
L @>\banana{\varphi}>> A @<\varphi_A << FA \\
@| @VfVV @VEfVV \\
L @>\banana{\psi}>> B @<\psi_B << FB
\end{CD}$$

が成り立つ.

### 単射は catamorphism

$f \colon A \to B$ と $g \colon B \to A$ について
$gf=1$ だとする.

$$\begin{align*}
& gf = 1 & \\
\implies & Fg \circ Ff = 1 \\
\implies & f \circ \varphi_A = f \circ \varphi_A \circ Fg \circ Ff \\
\end{align*}$$

ということで $\psi_B = (f \circ \varphi_A \circ Fg)$ ということにして
先程の CataFusion を使うと

$$f \circ \banana{\varphi} = \banana{f \circ \varphi_A \circ Fg}$$

を得る.
ここで $\varphi = \fin$ の場合を考える.
唯一性から $\banana{\fin}=1$ なので, 代入すると

$$f = \banana{f \circ \fin \circ Fg}$$

を得る.
$f$ が単射であれば $gf=1$ なる射 $g$ が存在することは同値なので,
上記の方法で $f$ を catamorphism として書くことができるがわかった.

## Anamorphisms

### AnaEval

関手 $F$,
不動点 $\mu_F = (L, \fin, \fout)$,
ポリモーフィズム $\psi_X \colon X \to FX$ について

$$\lense{\psi} = \mu(\fin \xleftarrow{F} \psi_X)$$

であった.
不動点なので
$\lense{\psi} = \fin \circ F\lense{\psi} \circ \psi_X$.
両辺に左から $\fout$ を掛けて

$$\fout \circ \lense{\psi} = F\lense{\psi} \circ \psi_X$$

$$\begin{CD}
X                 @>\psi_X>>  FX \\
@V\lense{\psi}VV            @VF\lense{\psi}VV \\
L                 @>\fout>>   FL
\end{CD}$$

を得る.
これを使って具体的に anamorphism を評価することができる.

### リストの `unfold`

$A$ のリスト型 $[A]$ は $FX = 1 + A \times X$ で与えられる.
そして `unfold` は初め $\lense{g, p}$ で定めると紹介したが,
一般の anamorphism として次のように書ける.

- $\lense{\psi} = \lense{(\const{\Nil} + g) \circ p?}$
    - where
        - $g \colon X \to A \times X$
        - $p \colon X \to \Bool$
            - 述語関数
        - $p? \colon X \to X + X$
            - $p(x)$ が真のとき $p?(x) = \iota_1(x)$
            - さもなくば $p?(x) = \iota_2(x)$

では実際に評価してみると,

$$\begin{align*}
\lense{\psi} x
& = \fin F\lense{\psi} \psi x \\
& = \fin (1 + 1 \times \lense{\psi}) (\const\Nil + g) p? x \\
\end{align*}$$

$p(x)$ が真のとき,

$$\begin{align*}
\lense{\psi} x
& = \fin (1 + 1 \times \lense{\psi}) (\const\Nil + g) \iota_1(x) \\
& = \fin (1 + 1 \times \lense{\psi}) \Nil \\
& = \fin \ast \\
& = \Nil \\
\end{align*}$$

$p(x)$ が偽のとき,
$(a, x') = g(x)$ だとして

$$\begin{align*}
\lense{\psi} x
& = \fin (1 + 1 \times \lense{\psi}) (\const\Nil + g) \iota_2(x) \\
& = \fin (1 + 1 \times \lense{\psi}) g(x) \\
& = \fin (a, \lense{\psi(x')}) \\
& = \cons(a, \lense{\psi(x')}) \\
\end{align*}$$

これがいわゆるリストの `unfold` である.

### iterate

$f \colon A \to A$ とリスト型 $F X = 1 + A \times X$ について

$$\psi_A \colon A \to FA$$
$$\psi_A = \iota_2 \circ (1_A \Delta f)$$

とする.

$$\begin{align*}
\fout \lense{\psi} (x)
& = F \lense{\psi} \psi (x) \\
& = F \lense{\psi} (x, f(x)) \\
& = (1 + 1 \times \lense{\psi}) (x, f(x)) \\
& = (x, \lense{\psi}(f(x))) \\
\end{align*}$$

左から $\fin$ を掛けて

$$\lense{\psi}(x) = \cons(x, \lense{\psi}(f(x)))$$

これを `iterate f` という.

### anamorphism の唯一性

次が成り立つ.

$$f = \lense{\psi} \iff \fout \circ f = Ff \circ \psi_A$$

### AnaFusion

$\varphi \circ f = Ff \circ \psi$ のとき
$$\lense{\varphi} \circ f = \lense{\psi}$$
が成り立つ.

### 全射は anamorphism

catamorphism のときの双対を取るとこのことがそのまま言える.
$f$ が全射のとき, 必ずある $g$ があって $fg=1$ となる.
$Ff \circ Fg = 1$ なので
$$\varphi \circ f = Ff \circ Fg \circ \varphi \circ f$$
この式に先の AnaFusion を使って

$$\lense{\varphi} \circ f = \lense{Fg \circ \varphi \circ f}$$

ここで $\varphi = \fout$ の場合を考える.
唯一性から $\lense{\fout} = 1$ なので

$$f = \lense{Fg \circ \fout \circ f}$$

すなわち全射であれば anamorphism として書けることが確認できた.

## Hylomorphisms
### HyloSplit

$gh=1$ のとき次の合成則が成り立つのだった.

$$\mu \farrow{f}{g}{F} \circ \mu \farrow{h}{j}{F} = \mu \farrow{f}{j}{F}$$

$\fin, \fout$ は逆射なので次を得る.

$$\mu \farrow{\varphi_B}{\fout}{F} \circ \mu \farrow{\fin}{\psi_A}{F} = \mu \farrow{\varphi_B}{\psi_A}{F}$$

すなわち次の合成則を得た.

$$\banana{\varphi} \circ \lense{\psi} = \envelop{\varphi, \psi}$$

### HyloShift (Shifting law)

2つの関手 $F,L$ とこれに関する
3つのポリモーフィズム

- $\psi_A \colon A \to FA$
- $\varphi_B \colon LB \to B$
- $\xi_A \colon FA \to LA$

があるとき次が成り立つ.

$\begin{align*}
\envelop{\varphi \circ \xi , \psi}_F
& = \mu \farrow{(\varphi_B \circ \xi_B)}{\psi_A}{F} \\
& = \mu \farrow{\varphi_B}{(\xi_A \circ \psi_A)}{L} \\
& = \envelop{\varphi, \xi \circ \psi}_L \\
\end{align*}$

### cata と ana の関係

HyloSplit と HyloShift から
$\banana{\varphi} = \envelop{\varphi, \fout}$,
$\lense{\psi} = \envelop{\fin, \psi}$
であることが分かる.
ここから cata と ana の関係としていくつか興味深い性質が得られる.

$\varphi$ を $L \to M$ のポリモーフィズムとしたとき,

$$\banana{\fin \circ \varphi}_L = \lense{\varphi \circ \fout}_M$$

$$\psi \circ \varphi = 1 \implies \lense{\psi}_L \circ \banana{\varphi}_L = 1$$

## Paramorphisms

### ParaEval

$\mu_F = (L, \fin, \fout)$,
$\xi_A \colon F(A \times L) \to A$ があるとき
$$\wire{\xi} = \mu(f \mapsto \xi_A \circ F(1 \Delta f) \circ \fout)$$
であった.
$\mu$ の定義から
$$\wire{\xi} = f \mapsto \xi_A \circ F(1 \Delta \wire{\xi}) \circ \fout$$
両辺に $\fin$ を掛けて
$$\wire{\xi} \circ \fin = \xi_A \circ F(1 \Delta \wire{\xi})$$
これが Paramorphism の評価規則になる.

#### リストの場合

関手 $FX = 1 + AX$ の不動点 $\mu_F = (L,\fin,\fout)$ がリスト型.
ここで $\xi_A \colon F(A \times L) \to A$ のパラモーフィズムを考える.

$$\begin{align*}
\wire{\xi} (\Nil)
& = \wire{\xi} \fin \ast \\
& = \xi_A \circ F(1 \Delta \wire{\xi}) \ast \\
& = \xi_A \ast
\end{align*}$$

$$\begin{align*}
\wire{\xi} \cons(a, \as)
& = \wire{\xi} \fin (a, \as) \\
& = \xi_A \circ F(1 \Delta \wire{\xi}) (a, \as) \\
& = \xi_A (a, (\as, \wire{\xi} (\as))) \\
\end{align*}$$

### ParaUP

$$f = \wire{\xi}_F \iff f \circ \fin = \xi \circ F(1 \Delta f)$$

### ParaFusion

$$f \circ \varphi = \psi \circ F ( 1 \times f ) \implies f \circ \wire{\varphi} = \wire{\psi}$$

### Theorem

$$f = \wire{f \circ \fin \circ F \pi_1}$$

## Parameterized Types

### Maps

リストでいう map 関数というのがある.
$A$ に関するリスト型 $[A]$ が定義でき,
$B$ に関しては $[B]$ が定義できる.
このとき $f \colon A \to B$ があるときに
$f^\ast \colon [A] \to [B]$ という射を定めることができる.

この ${}^\ast$ については次の2つが成り立っていてほしいだろう.

- $1^\ast = 1$
- $f^\ast \circ g^\ast = (fg)^\ast$

どうやらこの ${}^\ast$ は関手であるらしい.
形式的な定義を試みる.

ある双関手 $\dagger$ と対象 $A$ があるとき,
$A$ だけ固定して与えた関手 $(A \dagger)$ を考えることができる.
これの不動点を $\mu(A \dagger) = (A^\ast, \fin_A)$ とする.
また同様に対象 $B$ についても $\mu(B \dagger) = (B^\ast, \fin_B)$ とする.

ここで射 $f \colon A \to B$ があるとき,
$$f^\ast = \banana{ \fin_B \circ (f \dagger)_{B^\ast} }_{(A \dagger)}$$
だとする.

$$\begin{CD}
A^\ast @<\fin_A<< A \dagger A^\ast \\
@Vf^\ast VV \\
B^\ast @<\fin_B<< B \dagger B^\ast @<(f \dagger)_{B^\ast} << A \dagger B^\ast \\
\end{CD}$$

先の "cata と ana の関係" から次のようにも書き直せる.

$$f^\ast = \lense{(f \dagger)_{A^\ast} \circ \fout_A}_{(A \dagger)}$$

$$\begin{CD}
A^\ast @>\fout_A>> A \dagger A^\ast @>(f \dagger)_{A^\ast}>> B \dagger A^\ast \\
@Vf^\ast VV \\
B^\ast @<\fin_B<< B \dagger B^\ast \\
\end{CD}$$

以上の $f^\ast$ は一般化されたマップ関数である.
特に $A \dagger B = 1 + A \times B$ と定義すると馴染み深いリストの場合のマップ関数になる.

### Free types

関手 $F$ と対象 $A$ について
$A \dagger X = A + FX$ と定める.
このときの
$\mu(A \dagger) = (A^\ast, \fin)$
これを $A$ の上の free $F$-型 (自由 $F$ 型) と定義する.

### Map-Reduce

$\dagger$ は先程の $A \dagger X = A + FX$ を使う.
free $F$-型の $f \colon A \to B$ のマップ関数は

$$\begin{align*}
f^\ast
& = \banana{ \fin_B \circ (f \dagger)_{B^\ast} }_{(A \dagger)} \\
& = \banana{ \fin_B \circ (f + 1_{B^\ast}) }_{(A \dagger)} \\
& = \banana{ (\tau + \join) \circ (f + 1_{B^\ast}) }_{(A \dagger)} \\
& = \banana{ (\tau \circ f) ~ \nabla ~ \join } \\
\end{align*}$$

ここで $\tau = \fin \circ \iota_1, \join = \fin \circ \iota_2$ である.

射 $\varphi$ についてこれの reduction とは

$$\varphi / = \banana{ 1 \nabla \varphi }$$

だと定める.
次が成り立つ.

$$\begin{align*}
\banana{ f \nabla \varphi }
& = \banana{ (1 \nabla \varphi) \circ (f + 1) } \\
& = \banana{1 \nabla \varphi} \circ f^\ast \\
& = \varphi/ \circ f^\ast \\
\end{align*}$$

さて実は $\tau, \join$ は自然変換である.

$$\begin{CD}
A @>f>> B \\
@V\tau_A VV @V\tau_B VV \\
A^\ast @>f^\ast>> B^\ast
\end{CD}$$

$$\begin{CD}
FA^\ast @>Ff^\ast>> FB^\ast \\
@V{\join_A}VV @V{\join_B}VV \\
A^\ast @>f^\ast>> B^\ast
\end{CD}$$


このことから $f^\ast$ の評価規則を得る:

- $f^\ast \circ \tau = \tau \circ f$
- $f^\ast \circ \join = \join \circ Ff^\ast$

一方で $\varphi/$ の評価規則は普通に CataEval から次のようになる:

- $\varphi/\circ \tau = 1$
- $\varphi/\circ \join = \varphi \circ F(\varphi/)$

### モナド

任意の free type があるとき, モナドを次のようにして与えることが出来る.
つまり

- 関手 $\ast$
- 自然変換 $\tau \colon 1 \to \ast$
- 自然変換 $\join/ \colon \ast \ast \to \ast$

について

- $\join/ \circ \tau = 1$
- $\join/ \circ \tau^\ast = 1$
- $\join/ \circ \join/ = \join/ \circ (\join/)^\ast$

が成り立つ.

% Functional Programming with Bananas, Lenses, Envelopes and Barbed Wire
% https://maartenfokkinga.github.io/utwente/mmf91m.pdf
% プログラミング 圏論

$\require{AMScd}$
$\def\banana#1{(\!|#1|\!)}$
$\def\lense#1{[\!(#1)\!]}$
$\def\envelop#1{[\![ #1 ]\!]}$
$\def\wire#1{[\!\!\langle #1 \rangle\!\!]}$
$\DeclareMathOperator{\cons}{cons}$
$\DeclareMathOperator{\foldr}{foldr}$
$\def\Nil{\mathit{Nil}}$
$\def\Bool{\mathit{Bool}}$
$\def\true{\mathit{true}}$
$\def\false{\mathit{false}}$
$\def\const#1{#1^\bullet}$
$\def\VOID{\mathit{VOID}}$
$\def\join{\mathit{join}}$
$\def\triangle{\mathop{}\!\mathbin\Delta\;}$

## 概要

一般の再帰的データ構造について, ちょうど, リストに対する畳み込み (fold) といったような4種類の操作 (catamorphism, anamorphism, hylomorphism, paramorphism) を統一的に与える.

## 表記

この論文では独特な括弧が4種類導入されている.
できるだけオリジナルの見た目を模倣して, ここでは次のように表記する.

| 名称       | 表記           | 代替表記 | 備考 |
|:-----------|:--------------:|:--------:|:-----|
| バナナ括弧 | $\banana{\_}$  | `(| |)` | 果物のバナナ |
| レンズ括弧 | $\lense{\_}$   | `[( )]` | 凹レンズ |
| 封筒括弧   | $\envelop{\_}$ | `[[ ]]` | |
| 有刺鉄線   | $\wire{\_}$    | `[< >]` | $[$ と $\langle$ の重ねあわせ |

他にこの論文で使われてる表記で次のものをこの文書でも用いる.

- $\const{c}$
    - 型 $C$ の値 $c$ (或いは $c \in C$) と任意の型 (集合) $A$ について, $A \to C$ なる定数関数のこと
    - $\forall a \in A, \const{c}(a)=c$

また対象 (型, 集合) に関する表記であまり一般的に思えないものについては次のように一般的表記を用いる.

- $A \times B$
    - 対象 $A, B$ の積
    - タプル型, 集合の直積
- $A + B$
    - 対象 $A, B$ の直和
    - 直和型, 集合の直和
- $f \colon A \to B$
    - $f$ は $A$ から $B$ への射
    - あるいは関数, 演算
- $[A]$
    - 型 $A$ の要素に持つリストの型

## リストの場合

$[A]$ 型の場合を考える.

### catamorphism

"cata-" は catastrophic のそれであって, 下方へ, といった意味らしい.
リストについての catamorphism は如何のような関数 $h$ である.

- $h \colon [A] \to B$
- $h~[] = b$
- $h~(\cons(a, as)) = a \oplus h(as)$

ここで $b$ は $B$ の定数. $\oplus$ は $A \times B \to B$ なる二項演算子.
このような形の $h$ は Haskell のような言語では `foldr` として知られており
$$h = \foldr(b, \oplus)$$
のように書ける.
すなわち $h$ という関数は $b, \oplus$ によって決定するから, ここでは **バナナ括弧** で括ることで
$$h = \banana{b, \oplus}$$
と書くことにする.

例えばリストの長さを取る関数は $\banana{0, (\_,n)\mapsto n+1}$ と書けることが分かる.
他に `filter` もこの形で定義できる.

### anamorphism

ちょうど catamorphism の逆のもので, `unfold` のような名前で知られている関数 $h$ を次のように定義する.

- $h \colon B \to [A]$
- $h~b = \begin{cases} [] & \text{ when } p~b \\ \cons(a, h~b') & \text { otherwise, where } (a,b')=g~b\end{cases}$

ただしここで $p$ は $B \to \Bool$ なる述語関数 ($\Bool$ は普通の意味で).
$g$ は $B \to A \times B$ なる関数.

やはりこの $h$ は $p, g$ で決まる関数なので, 今度はレンズ括弧で括って
$$h = \lense{g, p}$$
と書いて表す.

例えば, 関数 $f \colon A \to A$ を繰り返し適用する `iterate f` という関数 $A \to [A]$ は
$\lense{a \mapsto (a, f~a), \const{\mathrm{false}}}$
と書ける.

#### map 関数

リスト $[A]$ と関数 $f \colon A \to B$ があるときに, リストの各要素に $f$ を適用することで $[A] \to [B]$ という関数を構成することができる.
Haskell では `map f` とこれを書くが, 論文に倣って $f*$ と書くことにする.
これは $[A]$ からの catamorphism として書くこともできるし, $[B]$ への anamorphism と書くこともできる.

- $f* = \banana{[], (a, b) \mapsto \cons(f~a, f*b)}$
- $f* = \lense{\cons(a, as) \mapsto (f~a, as), \mathrm{nil}}$
    - where
        - $\mathrm{nil}~[]=\mathrm{true}$
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

今度の $h$ は $c,\oplus, g,p$ によって決定されるので
$$h=\envelop{(c,\oplus), (g,p)}$$
と書き表すことにする.

そしてこれは明らかに
$$\envelop{(c,\oplus), (g,p)} = \banana{c,\oplus} \circ \lense{g,p}$$
という合成の形に分解できる.
この証明は論文にはあるが省略.
リストが一見登場しないが, この合成の形を見れば, 中間でリストを経由してることが分かる.

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
- $h~[]=b$
- $h~\cons(a,as)= a \oplus (as, h~as)$

ここで $b\colon B$, $\oplus\colon A \times([A]\times B) \to B$ である.
このような $h$ はやはり $b,\oplus$ で決定されるので,
$$h=\wire{b, \oplus}$$
と書くことにする.

$\oplus$ の型が豪華になったので, 値を蓄積しながらのような関数が書けるようになった.
例えば `tails` は
$\wire{\cons(\Nil,\Nil), (a\oplus(as,ac)=\cons(\cons(a,as),ac))}$
と書ける.

## 代数的データ型 (Algebraic data types)

### 双関手 (bifunctor)
双関手とは2つの対象の組を対象に写して2つの射の組を射に写すようなもので,
$f\colon A\to B$ と $g\colon C\to D$ を
$f \dagger g \colon A \dagger C \to B \dagger D$
とするような $\dagger$ といったもの.
ただし
$1\dagger 1=1$, $f\dagger g \circ h \dagger j = fh \dagger gj$
となるもの.
双関手の変数として $\dagger, \ddagger$ を用いる.

### 積
2つの対象 $A,B$ の積とは $A \times B$ なる対象.
$f \colon A \to B$ と
$g \colon C \to D$ との積として
$f \times g \colon A \times C \to B \times D$
を定める.
射影関数 $\pi_1 : A \times C \to A$,
$\pi_2 : B \times D \to A$ を伴う.

関数的に書くと

- $(f \times g)(x, x')=(fx gx')$
- $\pi_1(x,x')=x$
- $\pi_2(x,x')=x'$

また二項演算子 $\triangle$ を

- $(f \triangle g) x = (fx, gx)$

と定める.
例えば $f \times g = (f\pi_1) \triangle (g\pi_2)$ である.
また簡単に $\triangle$ を単項コンビネータとして用いて
$\triangle x = (x,x)$
とする.
これを用いると
$f \triangle g = (f \times g) \triangle$
と書ける.

### 和

対象 $A$ と $B$ の和を, $A$ と $B$ と加えて $\{\bot\}$ との直和として定める.
$$A+B = A \amalg B \amalg \{\bot\}$$
$f\colon A \to B, g \colon C \to D$
に対して $f+g \colon A+C \to B+D$ を定める.
これは関数的に書くと, $A$ のものは $f$ によって $B$ に, $C$ のものは $g$ によって$D$ に, そして $\bot$ は $\bot$ に写すもの.

- $(f+g) \colon A+C \to B+D$
- $(f+g) a = f a$
- $(f+g) c = g c$
- $(f+g) \bot = \bot$

自明な埋め込み射 $A \to A+B$ と $B \to A+B$ が存在する.

- $i_1 : A \to A+B$
- $i_1 a = a$
- $i_2 : B \to A+B$
- $i_2 b = b$

積の時と同様に $\triangledown$ という射に関する二項演算子を導入する.
これは選択的に射を適用するようなもので
$f\colon A \to B, g \colon C \to B$ について

- $(f \triangledown g) \colon A+C \to B$
- $(f \triangledown g) a = fa$
- $(f \triangledown g) c = gc$

のようなもの.

例えば
$f\colon A \to B, g \colon C \to D$ について
後ろに $i$ を合成すれば
$f+g = i_1 f \triangledown i_2 g$
と書ける.
そしてやはり単項コンビネータとしても流用して,

- $\triangledown \bot=\bot$
- $\triangledown (a \in A+C) = (a \in A)$
- $\triangledown (c \in A+C) = (c \in C)$

のように使う.

### 矢印

二項演算子 $\to$ を定める.
対象 $A,B$ について $A\to B$ はまた対象で, $A$ から $B$ への射全体の集まりを表す.
2つの射
$f \colon A \to C$ と
$g \colon C' \to B$ について
$$(f \to g) \colon (C \to C') \to (A \to B)$$
$$(f \to g) h = g \circ h \circ f$$
を定める.

```dot
digraph {
    node [shape=plaintext];
    rankdir=LR;
    graph [bgcolor=transparent];
    A -> C [label=f];
    C -> "C'" [label=h];
    "C'" -> B [label=g];
}
```

$(g \leftarrow f)$ を $(f \to g)$ と同じ意味で用いる.

関手 $F$ について
$$(f \xrightarrow{F} g) = g \circ Fh \circ f$$
で用いる.

また次の合成則がある.
$$(f \to g) \circ (h \to j) = (h \circ f) \to (g \circ j)$$

```dot
digraph {
    node [shape=none];
    rankdir=LR;
    graph [bgcolor=transparent];
    A -> B [label=f];
    B -> C [label=h];
    C -> D [style=dotted];
    D -> E [label=j];
    E -> F [label=g];
}
```

### 恒等関手, 定数関手

恒等関手 $1$ とは対象と射について恒等的に返すもので $1D=D, 1f=f$.

自由に選んだ対象 $D$ に対して, 全ての対象を $D$ に写すような関手 $\underline{D}$ がある.
ただし射は全て $1_D$ に写すとする.

### Lifting

関手 $F, G$ に対して関手 $FG$ を次のように定める:

- $FG(D) = G(FD)$
- $FGf = G(Ff)$

また更に双関手 $\dagger$ があるときに関手 $F \dagger G$ を次で定める:

- $(F \dagger G)D = FD \dagger GD$
- $(F \dagger G)f = Ff \dagger Gf$

### Sectioning

二項演算子 $\oplus$ があるとき, 関数 $(a \oplus)$ を $(a \oplus) b=a\oplus b$ で定める.
同様に関数 $(\oplus b) a = a \oplus b$ を定める.
この書き方を sectioning という. 必ず括弧で括る.

以上の記号を用いると,
例えば対象 $A,B$ について $(\underline{A} \dagger 1)(B)=A \dagger B=(A \dagger)B$ なので
$\underline{A} \dagger 1 = (A \dagger)$
だと言える.

### その他

終対象 (単集合) を $\mathbb 1$ と書く.
またこれの要素を $() \in \mathbb 1$ と書いて void と呼ぶ.

さて述語関数 $p : A \to \Bool$ に対して関数 $p?$ を次のように定める:

- $p? \colon A \to A+A$
- $p? a = \begin{cases}
    \bot & \text{ when } p~a = \bot \\
    i_1 & \text{ when } p~a = \true \\
    i_2 & \text{ when } p~a = \false \\
\end{cases}$

例えば
$(f \triangledown g) \circ p?$
は我々がよく知る if 文
`if p then f else g`
を表現している.

任意の値を $()$ に写す定数関数を $\VOID$ と呼ぶことにする. $\VOID \circ f=\VOID$ である.

再帰を作るために $\mu : (A \to A) \to A$ を定義する.

- $\mu~f = x$
    - where $x = f~x$

2つの関手 $F,G$ とがあるとき, 対象 $A$ に $\varphi_A \colon FA \to GA$ を与えるような $\varphi$ をポリモーフィズム (polymorphism, 多相関数) といい $\varphi \colon F \to G$ と書く. 自然関手とは可換性を保つポリモーフィズムだと言える.
$\varphi$ が自然変換であるとはポリモーフィズムであって, 射 $f : A \to B$ があるならば, $\varphi_B \circ Ff = Gf \circ \varphi_A$ という可換性を満たすもののこと.

### 再帰型

以上の操作を再帰的に行って得られる型を再帰型という (ってことだよね).

ここで次のような定理が知られている.

関手 $F$ であって連続なものを考えると,
ある対象 $L$ があって, 次を満たす2つの射 $in : FL \to L$ と $out : L \to FL$ がある:

- $in \circ out = 1$
- $out \circ in = 1$
- $1 = \mu(in \xleftarrow{F} out)$

$F$ に対して上記のような $(L,in)$ のことを $\mu_F$ と書いて最小不動点と呼ぶ.

例として関手 $LX = \mathbb 1 + A \times X$ を考えると, その最小不動点は $\mu_L = ([A], (\const{\Nil} \triangledown \cons))$ であって正にリストとその構成を表している.
同様に $NX= \mathbb 1 + N$ の最小不動点は $(\mathbb N, (\const{0} \triangledown (1+)))$ である.

## 再帰スキーム

一般の再帰型について cata-, ana-, hylo-, paramorphism を与えることをする.

関手 $F$ に対して $(L,in)=\mu_F$ であるとする.
3つのポリモーフィズム

- $\varphi_A \colon FA \to A$
- $\psi_A \colon A \to FA$
- $\xi_A \colon F(A \times L) \to A$

があるとき次を定める.

- catamorphism
    - $\banana{\varphi}_F = \mu(\varphi_A \xleftarrow{F} out)$
- anamorphism
    - $\lense{\psi}_F = \mu(in \xleftarrow{F} \psi_A)$
- hylomorphism
    - $\envelop{\varphi, \psi}_F = \mu(\varphi_B \xleftarrow{F} \psi_A)$
- paramorphism
    - $\wire{\xi}_F = \mu(f \mapsto \xi_A \circ F(1_L \triangle f) \circ out)$

ここで $A, B$ は任意の対象.
また左辺の括弧にはどの関手によって定めるものかを表す添字 ${}_F$ があるが, これは誤解がない限り省略する.

> 1つ目の
> $\varphi_L \xleftarrow{F} out$
> は $f \colon L \to A$ を取って
> $A \xleftarrow{\varphi_A} FA \xleftarrow{Ff} FL \xleftarrow{out} L$
> の合成を返す関数.
> これの $\mu$ なので
> $f = \varphi_L \circ Ff \circ out$ なる $f$ が $\banana{\varphi}$.

> 2つ目以降について型だけ書くと $\lense{\psi} \colon A \to L$, $\envelop{\varphi, \psi} \colon A \to B$, $\wire{\xi} \colon L \to L$.

リストの場合を思い出すと $\banana{e, \oplus}$ などと書いてたものは $\banana{\const{e} \triangle \oplus\!}$ と同等のものであったことが分かる.
同様に $\lense{g,p}$ と書いていたものは $\lense{(\VOID + g) \circ p?}$ と書き直される.
具体的には次に計算規則として見ていく.

## 計算規則

cata, ana, para については共通に
Evaluation Rule (対訳不明), Uniqueness Property (唯一性?), Fusion Law (融合則)
が成り立つことを見ていく.
その中で次の幾つかの定理を用いる.

<div class=thm>
#### fixed point fusion (free theorem)

関数 $f$ が正格で, $f \circ g = h \circ f$ ならば
$$f (\mu g) = \mu h$$
</div>

hylo については ana と cata とに分解できることと次の定理を利用する.

<div class=thm>
$g \circ h = 1$ ならば
$$\mu(f \xleftarrow{F} g) \circ \mu(h \xleftarrow{F} j) = \mu(f \xleftarrow{F} j)$$
</div>

### Evaluation Rule for Catamorphism (CataEval)

<div class=thm>
catamorphism の evaluation rule は次のようなものである:

関手 $F$ とポリモーフィズム $\varphi \colon F \to 1$ とその射 $\varphi_A : FA \to A$ について,
$\mu_F=(L,in)$ とすると
$$\banana{\varphi} \circ in = \varphi_A \circ F \banana{\varphi}$$

$$\begin{CD}
L @<in<< FL \\
@V\banana{\varphi}VV @VF\banana{\varphi}VV \\
A @<\varphi_A<< FA
\end{CD}$$

</div>

これは $\banana{\varphi}$ の定義から従う.
$\banana{\varphi} = \mu( \varphi_A \xleftarrow{F} out )$
であったが $\mu$ の定義より
$\banana{\varphi} = \varphi_A \circ F \banana{\varphi_A} \circ out$.
両辺の右に $in$ を掛けると, $in$ は $out$ の逆射だったので
$\banana{\varphi} \circ in = \varphi_A \circ F \banana{\varphi_A}$
を得る.

さてこの法則は evaluation rule という名前の通り, $\banana{\varphi}$ を具体的に計算するための方法を示している.

#### 例

リストの `foldr` は次のようなものだった

- 関手 $LX = 1+AX$
- $\mu_L = ([A], in)$
    - $in = \const{\Nil} \triangledown \cons$
- ポリモーフィズム $\varphi_X = \const{c} \triangledown \oplus$
    - $\const{c} \colon 1 \to X$
    - $\oplus \colon A \times X \to X$

これらに対して $\banana{\varphi}$ が foldr.
では具体的な値について foldr の計算をしてみる.

ただし $L[A]=1+A[A]$ について $() \in 1$ の場合と $(a,as) \in A[A]$ の場合に分ける.
これは $in~() = \Nil$ と $in(a,as) = \cons(a,as)$ の場合に分けてるのと同等 ($in$ は同型射なので).

$$\begin{align*}
\banana{\varphi} \Nil
& = \banana{\varphi} \circ in () \\
& = \varphi \circ L\banana{\varphi} () \\
& = \varphi \circ (1 + 1_A \banana{\varphi}) () \\
& = \varphi () \\
& = (\const{c} \triangledown \oplus) () \\
& = c
\end{align*}$$

$$\begin{align*}
\banana{\varphi} \cons(a, as)
& = \banana{\varphi} \circ in (a,as) \\
& = \varphi \circ L\banana{\varphi} (a,as) \\
& = \varphi \circ (1 + 1_A \banana{\varphi}) (a,as) \\
& = \varphi (a, \banana{\varphi} as) \\
& = (\const{c} \triangledown \oplus) (a, \banana{\varphi} as) \\
& = a \oplus (\banana{\varphi} as)
\end{align*}$$

これで全ての場合を網羅できている.

### Uniqueness Property for catamorphism (CataUP)

<div class=thm>
$$f=\banana{\varphi}_F
\iff
f \bot = \banana{\varphi}_F \bot
\land
f \circ in = \varphi \circ Ff$$
</div>

すなわち, 先の Evaluation Rule を満たすような $\banana{\varphi}$ は唯一しか存在しないことを主張する.

これもほぼ自明.
$(\Rightarrow)$ は Evaluation Rule のまんまなので自明.
$(\Leftarrow)$. $f~in=\varphi Ff \implies f=\varphi Ff~out \implies f = \mu(\varphi \xleftarrow{F} out) = \banana{\varphi}$.

### Fusion Law for catamorphism (CataFusion)

<div class=thm>
$f \circ \varphi = \psi \circ Ff$ のとき
$$f \circ \banana{\varphi} = \banana{\psi}$$

<center>
```dot
digraph {
    node [shape=plaintext];
    rankdir=LR;
    graph [bgcolor=transparent];
    L -> A [label="(|φ|)"];
    A -> FA [label="φ" dir=back];
    A -> B [label=f];
    FA -> FB [label=Ff];
    FB -> B [label="ψ"];
    L -> B [label="(|ψ|)"];
    {rank=same; L A B};
    {rank=same; FA FB};
}
```
</center>
</div>

どう証明してもいいけど,
$\banana{}$ の定義のを開けば
$$\begin{align*}
\banana{\varphi} & = \mu(\varphi \xleftarrow{F} out) \\
& = \varphi \circ F\banana{\varphi} \circ out \\
\end{align*}$$
両辺に左から $f\circ$ を掛けて
$$\begin{align*}
f \circ \banana{\varphi}
& = f \circ \varphi \circ F\banana{\varphi} \circ out \\
& = \psi \circ Ff \circ F\banana{\varphi} \circ out \\
& = \psi \circ F(f \circ \banana{\varphi}) \circ out \\
\end{align*}$$
というわけで $f \circ \banana{\varphi}$ は $\mu(\psi \xleftarrow{F} out)$ である.
一方で $\banana{\psi}$ もその $\mu$ である.
catamorphism の唯一性 (CataUP) よりそれらは等しく
$$\banana{\psi} = f \circ \banana{\varphi}$$
である.

論文では
$f \circ (\varphi \xleftarrow{F} out) = (\psi \xleftarrow{F} out) \circ f$ であることと fixed point fusion を用いて証明できる, と言っている.

#### リスト畳込み (`foldr`) の融合則

2つのリストの畳込み
$\banana{\varphi} = \banana{c \triangledown \oplus}$
と
$\banana{\psi} = \banana{d \triangledown \otimes}$ について,
ある $f$ があって,

- $d = fc$,
- $f(x \oplus xs) = y \otimes f(xs)$

のとき
$$f \circ \banana{\varphi} = \banana{\psi}.$$

### 包含射は catamorphism

射 $f \colon A \to B$ に左単位射 $g$ ($gf=1$) があるとすると,
$Fg$ は $Ff$ の逆射になるので
$f \circ \varphi = (f \circ \varphi \circ Fg) \circ Ff$
である.
CataFusion で $\psi = f \circ \varphi \circ Fg$ を代入すれば
$f \circ \banana{\varphi} = \banana{f \circ \varphi \circ Fg}$
を得る.

$$\begin{CD}
L @<in<< FL \\
@V\banana{\varphi}VV @VF\banana{\varphi}VV \\
A @<\varphi<< FA \\
@VfVV @AFgAA \\
B @. FB
\end{CD}$$

上の図式で $A=L, \varphi=in$ の場合を考える.
唯一性より $\banana{in}=1$ を得る. これらを代入することで,
$$f = \banana{f \circ in \circ Fg}$$
を得る.
これに $B=FL, f=out, g=in$ を代入すると,

$$\begin{CD}
L @<in<< FL \\
@V\banana{in}VV @VF\banana{in}VV \\
L @<in<< FL \\
@VoutVV @AF~inAA \\
FL @<F~in<< FFL
\end{CD}$$

一番下の $F(in) : F^2L \to FL$ の catamorphism を考えることで
$$\banana{out \circ in \circ F(in)} = \banana{F(in)} = out$$
を得る.

### catamorphism は正格性を保つ

まず関手 $F$ が正格性を保つ, すなわち
$f \bot=\bot \iff Ef \bot = \bot$
とする.
このとき
$$\varphi \bot = \bot \iff \banana{\varphi}_F \bot = \bot$$
が成り立つ.
添字の $F$ は $F$ の下でのバナナであることを表したのに註意.

$(\Rightarrow)$.
$\banana{\varphi} = \bot$ を仮定すると
$$\begin{align*}
\bot & = \banana{\varphi} \bot \\
     & = \banana{\varphi} in \bot \\
     & = \varphi F\banana{\varphi} \bot \\
     & = \varphi \bot
\end{align*}$$
より従う.
ここで最後の式変形には $F$ が正格性を保存することと $\banana{\varphi}\bot=\bot$ を仮定していることから $F\banana{\varphi}\bot=\bot$ を用いた.

### Evaluation Rule for Anamorphism (AnaEval)

関手 $F$ とその $\mu_F=(L,in)$ について,
$\psi_A : A \to FA$ に対して
$\lense{\psi} = \mu(in \xleftarrow{F} \psi)$ が定義だったので,
$$\lense{\psi} = in \circ F\lense{\psi} \circ \psi$$
である. この両辺に左から $out \circ$ を掛けることで次を得る.
<div class=thm>
AnaEval
$$out \circ \lense{\psi} = F\lense{\psi} \circ \psi$$

$$\begin{CD}
X                 @>\psi>>  FX \\
@V\lense{\psi}VV            @VF\lense{\psi}VV \\
L                 @>out>>   FL
\end{CD}$$

</div>
これはやはり $\lense{\psi}$ に関する評価規則を示している.

#### 例. unfold

$A$ のリスト型 $F \colon X \to 1+AX$ について,
リストのunfoldは
$g : X \to AX$
と
$p? \colon X \to X+X$
によって
$\lense{\psi} = \lense{(VOID+g) \circ p?}$
と表されると言った.
これの評価を考える.

$$\begin{align*}
\lense{\psi} x & = in F\lense{\psi} \psi x \\
& = \begin{cases}
\bot & \text{ when } p~x = \bot \\
in F\lense{\psi} () & \text{ when } p~x = \true \\
in F\lense{\psi} (a,x') & \text{ when } p~x = \false, (a,x') = g~x \\
\end{cases}
\end{align*}$$

ここで $F\lense{\psi}=1+1\times \lense{\psi}$ であるので,

- $in~F\lense{\psi}() = in() = \Nil$
- $in~F\lense{\psi}(a, x') = in(a,x') = \cons(a,x')$

となっていわゆる `unfold` を得る.

#### 例. iterate

$f:A \to A$ とリスト型 $F:X \to 1+AX$ について
$\psi_A = 1_2 \circ (1_A \triangle f) : A \to FA$ とする.

$$\begin{align*}
\psi_A x
& = i_2(1\triangle f) x \\
& = i_2(x,fx) \\
& = (x, fx) ~ \in 1+AX
\end{align*}$$

$$\begin{align*}
out \lense{\psi} x
& = F\lense{\psi} \psi x \\
& = (1+1\times\lense{\psi}) (x,fx) \\
& = (x, \lense{\psi}(fx))
\end{align*}$$

(左からinを掛けることで)
$$\lense{\psi} x = \cons(x, \lense{\psi}(fx))$$
を得る.
これは Haskell なのでは `iterate f` として知られる.


### anamorphism の唯一性 (AnaUP)

<div class=thm>
$$f = \lense{\psi}_F \iff out \circ f = Ff \circ \psi$$
</div>

### anamorphism の融合則 (AnaFusion)

<div class=thm>
$\varphi \circ f = Ff \circ \psi$ のとき
$$\lense{\varphi} \circ f = \lense{\psi}$$
</div>

<center>
```dot
digraph {
    node [shape=plaintext];
    rankdir=LR;
    graph [bgcolor=transparent];
    B -> FB [label="ψ"];
    A -> FA [label="φ"];
    L -> FL [label=out];
    B -> A [label=f];
    FB -> FA [label=Ff];
    A -> L [label="[(φ)]"];
    B -> L [label="[(ψ)]"];
    {rank=same; L A B};
    {rank=same; FL FA FB};
}
```
</center>

唯一性より従う.

### 全射は anamorphism

以上のことは単に catamorphism の双対を取れば導けた.
全く同様に, 包含射即ち左単位射を持つ射が catamorphism であったことから, 全射即ち右単位射を持つ射は anamorphism である.

全射を $f$ として, ある $g$ によって $fg=1$ であるとすると,
$$f = \lense{Fg \circ out \circ f}$$
が成立する.

これに $f=in, g=out$ を代入することで,
$$\lense{F(out) \circ in \circ in} = \lense{F(out)} = in$$
を得る.

### Splitting Hylomorphism (HyloSplit)

$gh=1$ のとき,
合成則
$\mu(f \xleftarrow{F} g) \circ \mu(h \xleftarrow{F} j) = \mu(f \xleftarrow{F} j)$
が成り立つ.
これによって次の定理が成り立つ.
<div class=thm>
$$\envelop{\varphi, \psi} = \banana{\varphi} \circ \lense{\psi}$$
</div>

### Shifting Law for Hylomorphism (HyloShift)

関手 $F,M$ があり,
$\varphi \colon ML \to B$,
$\psi \colon A \to FA$,
$\xi \colon F \to M$
とする.

<center>
```dot
digraph {
    node [shape=plaintext];
    rankdir=TB;
    graph [bgcolor=transparent];
    A -> FA [label="ψ"];
    FA -> MA [label="ξ"];
    FB -> MB [label="ξ"];
    B -> MB [label="φ" dir=back];
    A -> B [laebl="[[..]]"];
    {rank=same; A FA MA};
    {rank=same; B FB MB};
    // {rank=same; A B};
    // {rank=same; FA FB};
    // {rank=same; MA MB};
}
```
</center>

上の図式において $\envelop{\ldots} \colon A \to B$ は $F$ に於いても $M$ に於いてでも正しく定まり,
$$\envelop{\varphi_B\xi_B, \psi_A}_F = \envelop{\varphi_B, \xi_A\psi_A}_M$$
が成り立つ.

これは cata や ana と違って陽に $\mu_F, \mu_M$ が登場しないからこういうことが出来る.

### cata と ana の関係

<div class=thm>
$\mu_F = (L, in_F)$, $\mu_M = (L, in_M)$
でこの間にポリモーフィズム $\varphi \colon F \to M$ があるとき,
$$\banana{in_M\circ\varphi}_F = \lense{\varphi\circ out_F}_M$$

<center>
```dot
digraph {
    node [shape=plaintext];
    rankdir=LR;
    graph [bgcolor=transparent];
    L -> FL [label=out];
    FL -> ML [label="φ"];
    ML -> L2 [label=in];
    L2 [label=L];
    {rank=same; L L2};
}
```
</center>
</div>

<div class=thm>
$\psi \circ \varphi=1$ のとき, $\mu$ の合成則より
$$\lense{\psi} \circ \banana{\varphi} = 1$$
</div>

例えば `foldr` してから `unfold` した結果が元に戻るための十分条件として, ポリモーフィズムのレベルで合成が $1$ であることがある.

### Evaluation Rule for Paramorphism (ParaEval)

定義がだいぶ前なので, 改めて paramorphism の定義を書くと,
$\mu_F=(L,in)$ について
ポリモーフィズム $\xi_A \colon F(AL) \to A$ があるとき $\wire{\xi}$ とは,
$f \colon L \to L$ なる射によって
$$\wire{\xi} \equiv \mu(f \mapsto \xi_L \circ F(1 \triangle f) \circ out)$$
と書かれるもの.

従って
$$\wire{\xi} = \xi_L \circ F(1_L \triangle \wire{\xi}) \circ out$$
両辺に右から $in$ を掛けることで
$$\wire{\xi} \circ in = \xi_L \circ F(1_L \triangle \wire{\xi})$$
を得、これが paramorphism の評価規則になっている.

#### 例. リスト

$FX=1+AX$ について
$\xi_A \colon F(AL) \to A$ の paramorphism を考える.

$F(1_L \triangle \wire{\xi}) x = (1+1 \times (1_L \triangle \wire{\xi})) x$
は $x \in 1$ なら $() \in 1$, さもなくば $x=(a,b)=A \times L$ であって値は $(a, (b, \wire{\xi}~b))$ であることに註意すると,

$$\begin{align*}
\wire{\xi} \Nil
& = \wire{\xi} in~() \\
& = \xi F(1 \triangle \wire{\xi}) () \\
& = \xi ()
\end{align*}$$

$$\begin{align*}
\wire{\xi} \cons(a,as)
& = \wire{\xi} in(a,as) \\
& = \xi F(1 \triangle \wire{\xi}) (a, as) \\
& = \xi (a, (as, \wire{\xi}~as))
\end{align*}$$

### 唯一性 (ParaUP)
<div class=thm>
$$f = \wire{\xi}_F \iff f \circ in = \xi \circ F(1 \triangle f)$$
</div>

### 融合則 (ParaFusion)
<div class=thm>
$f \circ \varphi = \psi \circ F(1 \times f)$ のとき
$$f \circ \wire{\varphi} = \wire{\psi}$$

$$\begin{CD}
L                 @>out>>       FL                \\
@V\lense{\psi}VV                @.                \\
L                 @<\varphi<<   F(1 \times L)     \\
@VfVV                           @VVF(1\times f)V  \\
L                 @<\psi<<      F(L \times L)
\end{CD}$$

</div>

### 定理

<div class=thm>
$$f = \wire{f \circ in \circ F\pi_1}$$
</div>

## Parameterized Types (パラメータ化された型)

最初のほうで map 関数というものをやった.
即ち型 $A,B$ に対しては型 $[A], [B]$ というものを定義することが出来,
射 $f\colon A \to B$ に対して $f* \colon [A] \to [B]$ というものを定めることが出来た.
また明らかに $1*=1$, $f* \circ g* = (fg)*$ が成り立つ.
この意味で $*$ は関手である $(A* = [A])$.
これを一般化する.

### Sectioning について (復習???)

双関手 $\dagger$ とある対象 $A$ について,
$$(A \dagger) = \underline{A} \dagger 1$$
であった. つまりこれは関手であって,

- $(A\dagger)B = A \dagger B$
- $(A\dagger)f = (\underline{A} \dagger 1) f = 1_A \dagger f$

と写す.

射 $f \colon A \to B$ について
$(f \dagger)$ はポリモーフィズムであって (!!),

- $(f \dagger) \colon (A\dagger) \to (B\dagger)$
- $(f \dagger)_X \colon (A\dagger X) \to (B\dagger X)$
- $(f \dagger)_X = f \dagger 1_X$

### Maps

関手 $*$ を次のように定義し直す.

ある双関手 $\dagger$ と対象 $A$ について
$\mu(A\dagger) = (A*,in_A)$ であると定義する.
同様に対象 $B$ については $\mu(B\dagger) = (B*,in_B)$

ある射 $f \colon A \to B$ があるとき,
$$\varphi = in_B \circ (f \dagger)_{B*} \colon A\dagger B* \to B*$$
が定まる.
この catamorphism を $f*$ であると定義する.
$$f* = \banana{in_B \circ (f \dagger)_B{*}}_{(A\dagger)}$$

$$\begin{CD}
A*   @<in_A<< A\dagger A* \\
@Vf*=\banana{\varphi}VV \\
B*   @<in_B<< B\dagger B* @<(f\dagger)_{B*}<< A \dagger B*
\end{CD}$$

先の "cata と ana の関係" でも見たように,
$$f* = \lense{(f \dagger)_{A*} \circ out_A}_{(A\dagger)}$$

$$\begin{CD}
A* @>out_A>> A \dagger A* @>(f\dagger)>> B \dagger A* \\
@Vf*=\lense{\psi}VV \\
B* @<in_B<< B \dagger B*
\end{CD}$$

と書き直すことも出来る.

以上で関手 $*$ が定義された.
これはリストのマップとして定義した $*$ の一般化になっている.
$A\dagger B = 1+A \times B$ とすればリストの場合が導出出来る.

#### 合成

合成に関して次が成立する.
$$\begin{align*}
f* \circ g*
& = \banana{in \circ (f\dagger)} \circ \banana{in \circ (g\dagger)} \\
& = \banana{in \circ (f\dagger) \circ (g\dagger)} \\
& = \banana{in \circ ((f \circ g) \dagger)} \\
& = (f \circ g)*
\end{align*}$$

### Map-Reduce

関手 $F$ と対象 $A$ について
$A \dagger X = A + FX$
としたときの
$(A*,in)=\mu(A \dagger)$
を $A$ の上の free $F$-type と呼ぶ.

$f \colon A \to B$ について,
$f* = \banana{in_B \circ (f\dagger)_{B*}}$
であったが,
今
$\tau_B = in \circ i_1 \colon B \to B*$,
$\join_B = in \circ i_2 \colon B* \to B*$
とすると,
$$f* = \banana{(\tau_B \circ f) \triangledown \join_B}$$
と書き直せる.

射 $\varphi$ に対して次で定める $\varphi/$ を $\varphi$ の reduction と呼ぶ:
$$\varphi/ = \banana{1 \triangledown \varphi}$$
これに関して次が成り立つ.
$$\begin{align*}
\banana{f \triangledown \varphi}
& = \banana{(1 \triangledown \varphi) \circ (f + 1)} \\
& = \banana{1 \triangledown \varphi} \circ f* \\
& = \varphi/ \circ f*
\end{align*}$$

さて実は $\tau, \join$ は自然変換である.
$$\begin{CD}
A @>f>> B \\
@V\tau_AVV @V\tau_BVV \\
A* @>f*>> B*
\end{CD}$$
$$\begin{CD}
FA* @>Ff*>> FB* \\
@V{\join_A}VV @V{\join_B}VV \\
A* @>f*>> B*
\end{CD}$$
このことから $f*$ の評価規則を得る:

- $f* \circ \tau = \tau \circ f$
- $f* \circ \join = \join \circ Ff*$

一方で $\varphi/$ の評価規則は普通に CataEval から次のようになる:

- $\varphi/\circ \tau = 1$
- $\varphi/\circ \join = \varphi \circ F(\varphi/)$

### モナド

free type があるとき, モナドを次のようにして与えることが出来る.
つまり

- 関手 $*$
- 自然変換 $\tau \colon 1 \to *$
- 自然変換 $\join/ \colon ** \to *$

について

- $\join/ \circ \tau = 1$
- $\join/ \circ \tau* = 1$
- $\join/ \circ \join/ = \join/ \circ \join/*$

が成り立つ.

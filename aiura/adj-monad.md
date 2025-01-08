% 随伴が導くモナド
% 2019-02-08 (Fri.)
% 圏論

$\def\A{\mathcal A}
\def\B{\mathcal B}
\def\Hom{\mathrm Hom}
\def\Sets{\mathrm Sets}
\def\Gr{\mathrm Gr}$
$\require{amscd}$

## 概要

随伴 $F \dashv U$ があるとき $UF$ はモナドになる.

このことを確認する前に随伴とモナドについて復習する.

## 復習

### 随伴

2つの互いに逆方向の関手
$F \colon \A \to \B$
と
$U \colon \B \to \A$
とがあって,
任意の $X \in \A, Y \in \B$ について,
$$\Hom_\B(FX, Y) \simeq \Hom_\A(X, UY)$$
という **自然な** 同型関係ががあるとき,
$$F \dashv U$$
であると書いて, $F, U$ が随伴であるという.

この同型の対応を
$$\Phi \colon \Hom_\B(FX, Y) \rightleftharpoons \Hom_\A(X, UY) \colon \Psi$$
と書くことにする.

ここでまず同型関係であるので, 左右の $\Hom$ に一対一対応があること.
つまり $\Phi$ と $\Psi$ は互いに逆の関数になっている (Hom は集合とする).

しかもその対応が自然であることを要請する.
自然であるということの意味はここでは次の通り.

任意の $g \colon X' \to X, h \colon Y \to Y'$ について次が可換.
$$\begin{CD}
\Hom_\B(FX, Y) @>\Phi>> \Hom_\A(X, UY) \\
@Vh-FgVV @VUh-gVV \\
\Hom_\B(FX', Y') @>\Phi>> \Hom_\A(X', UY') \\
\end{CD}$$
ここで縦の射は

- $(h-Fg) : f \mapsto h \circ f \circ Fg$
- $(Uh-g) : f \mapsto Uh \circ f \circ g$

という関数のこと.
左上から $f : FX \to Y$ という射を自由に取ってくれば,
次の等式が成り立つことが可換性である.

<div class=thm>
($\Phi$ の自然性)
$$\Phi(h~f~Fg) = Uh~\Phi f~g$$
</div>

同様に $\Psi$ も自然である必要がある.
([といっても, 一方が自然ならその逆も自然になる](http://cympfh.cc/taglibro/2019/01/22.html).)
向きが逆なだけで全く同様に,

$$\begin{CD}
\Hom_\B(FX, Y) @<\Psi<< \Hom_\A(X, UY) \\
@Vh-FgVV @VUh-gVV \\
\Hom_\B(FX', Y') @<\Psi<< \Hom_\A(X', UY') \\
\end{CD}$$

<div class=thm>
($\Psi$ の自然性)
$$\Psi(Uh~f~g) = h~\Psi f~Fg$$
</div>

2つの自然性の式はあとで使うので使いやすい形にだけしておいてメモしておく.

<div class=thm>
**memo**

$$\Phi(h) = Uh~\Phi 1$$
$$\Psi(Uh~f) = h~\Psi f$$

それぞれ適切に $1$ を代入すればこれが出てくる.
</div>

### モナド

モナドと言ったが個人的には Kleisli Triple の形の方がわかりやすい (定義も書きやすい) のでこちらを使う. モナドとは同値な概念で変換も簡単なのでどっちでも良い.

ここでは次の $(T,\eta,-^\sharp)$ を圏 $\A$ の Kleisli Triple と呼ぶ.

<div class=thm>

- 関手 $T : \A \to \A$
    - (実際には対象の対応付だけで十分)
- ポリモーフィズム $\eta : 1 \to T$
    - ポリモーフィズムとは自然である必要はない自然変換
    - ここでは各対象 $X \in \A$ について $\eta_X : X \to TX$ なる射を与えるもの
- $-^\sharp \colon \Hom(A,TB) \to \Hom(TA, TB)$
    - $f \mapsto f^\sharp$

であって次の3つが成立するもの.

1. $\eta_X^\sharp = 1_{TX}$
1. $f = f^\sharp \eta_X$ ($f \colon X \to TY$)
1. $(g^\sharp f)^\sharp = g^\sharp f^\sharp$

</div>

以上が Kleisli Triple である.

> $\eta$ は適当に自然変換になって,
> $\mu_X = 1_{TX}^\sharp$
> とすれば $(T,\eta,\mu)$ がいわゆるモナドそのものになる.

## 随伴の合成はモナド

主張は以下の通りであった.

> 随伴 $F \dashv U$ について $UF$ はモナド.

$F \colon \A \to \B$,
$U \colon \B \to \A$
とすると
$$UF \colon \A \to \A$$
であり,
随伴の対応関係を前に書いたように $\Phi, \Psi$ とすると,
$$\eta_X = \Phi(1_{FX})$$
$$f^\sharp = U(\Psi f)$$
としたときに
$(UF, \eta, -^\sharp)$
が実は Kleisli Triple になっていることを示す.

### 証明のコツ

$1_X$ は常に存在すること.
自然変換の添字や恒等射 $1$ の添字は気にしない.
適用や合成はただの掛け算.
型だけ正しく揃える.

では Kleisli Triple に要請される3つの条件を満たすことを見ていく.

### 1. $\eta_X^\sharp = 1_{TX}$

$$\begin{align*}
\eta_X^\sharp
& = U(\Psi \eta_X) \\
& = U(\Psi \Phi(1_{FX})) \\
& = U1 \\
& = 1_{UFX}
\end{align*}$$

$T=UF$ なので確かに型もあってる.
ただしこれ以降は $1$ の添字は省略してく.

### 2. $f = f^\sharp \eta_X$

右辺から始める.

$$\begin{align*}
f^\sharp \eta_X & = U(\Psi f) \Phi(1) \\
\end{align*}$$

ここで **memo** を思い出すと,
$$\begin{align*}
U(\Psi f) \Phi(1)
& = \Phi(\Psi(f)) \\
& = f
\end{align*}$$

最後は $\Phi$ は $\Psi$ の逆関数であることを使った.

### 3. $(g^\sharp f)^\sharp = g^\sharp f^\sharp$

$$\begin{align*}
(g^\sharp f)^\sharp
& = U(\Psi(g^\sharp ~ f)) \\
& = U(\Psi((U \Psi g) ~ f)) \\
\end{align*}$$

やはり **memo** を思い出すと,
$\Psi((U \Psi g) ~ f) = (\Psi g) (\Psi f)$
なので,
$$\begin{align*}
(g^\sharp f)^\sharp
& = U ( (\Psi g) (\Psi f) ) \\
& = U(\Psi g) ~ U(\Psi f) \\
& = g^\sharp f^\sharp
\end{align*}$$

最後は $U$ が関手なので分配できることを使った.
一方で $\Phi$ や $\Psi$ は関手ではないので分配できないことに註意.

以上から確かに $UF$ は適切な操作によって Kleisli Triple になる.
そして $\mu_X = 1_{UFX}^\sharp = U(\Psi 1_{UFX})$ とすることでモナドである.

## 例 - リストモナド

定番の例として自由関手と忘却関手.
ここでは集合の圏 Sets と群からなる圏 Gr を考える.

$$F : \Sets \to \Gr$$

は与えられた集合の要素からなる自由群を構成する.
例えば $F\{a,b\} = \langle a,b \rangle = (\{ \epsilon, a, b, ab, ba, a^2b, aba, \ldots \}, \times)$.

$$U : \Gr \to \Sets$$

は与えられた群の元の全てからなる集合を構成する (群の構造を忘れる).
例えば $U \langle a,b \rangle = \{ \epsilon, a, b, ab, ba, a^2b, aba, \ldots \}$.

従って, 集合 $X = \{a,b\}$ について
$$UFX = \{ \epsilon, a, b, ab, ba, a^2b, aba, \ldots \}$$
これは, 要素が $a,b$ からなる文字列のこと.
あるいはリストのこと.

## 例 - 状態モナド

[状態モナド](https://wiki.haskell.org/State_Monad) もやはり随伴の組み合わせで定めることができて
$$- \times A \dashv (-)^A$$
を使う (参考: [冪が随伴であること](power-eval.html)).
これによって
$T_A = (- \times A)^A$
がモナドであることがわかる.

随伴の対応を
$$\Phi \colon \Hom(X \times A, Y) \to \Hom(X, Y^A)$$
とする.

$\eta$ (いわゆる return) は,
$$\eta_X \colon X \to (X \times A)^A$$
$$\eta_X = \Phi(1_{X \times A})$$
$$\eta_X(x) = (a \mapsto (x, a))$$
で与えられる.

以上.

> 逆に任意のモナドは自明でない随伴に分解出来るのかな?

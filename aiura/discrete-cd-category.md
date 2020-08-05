% 離散確率分布のCD圏
% 2020-08-03 (Mon.)
% 確率論 圏論 CD圏 マルコフ圏

$\def\C{\mathcal C}\def\Sets{\mathbb{Sets}}\def\D{\mathcal D}\def\Kl{\mathcal{Kl(D)}}$

## 概要

CD圏は Copy/Discard と呼ばれる特別な射を持つ対称モノイド圏 (symmetric monoidal category) のことで,
確率を一般化して表現できることからマルコフ圏とも呼ばれる.

ここではCD圏の定義と簡単なケースとして離散確率分布を表現する方法を紹介する.

## 参考文献

- [マルコフ圏 A First Look -- 圏論的確率論の最良の定式化 - 檜山正幸のキマイラ飼育記 (はてなBlog)](https://m-hiyama.hatenablog.com/entry/2020/06/09/154044)
- [Disintegration and Bayesian Inversion,Both Abstractly and Concretely](https://www.cs.ru.nl/K.Cho/papers/disintegration.pdf)

## notation

単集合 $1 = \{\ast\}$ をドメインとする写像 $f \colon 1 \to X$ があるとき,
値 $f(\ast)$ も記号を乱用して単に $f ~(\in X)$ と書く.

## CD圏

考える圏は対称モノイド圏だとする.
すなわちテンソル積 $\otimes$ と対象 $I$ があって,

- $X \otimes I \simeq I \otimes X \simeq X$
- $(X \otimes Y) \otimes Z \simeq X \otimes (Y \otimes Z)$

が成り立つ.

ここに更に, 各対象 $X$ について copy 射 $c_X$ と discard 射 $d_X$ があるとする.

- $c_X \colon X \to X \otimes X$
- $d_X \colon X \to I$

この二つは次を満たすことを要請する:

- $(d_X \otimes 1_X) c_X = (1_X \otimes d_X) c_X = 1_X$
- $(c_X \otimes 1_X) c_X = (1_X \otimes c_X) c_X$

特にこの二つ目は $X$ から copy 射によって作った $(X \otimes X) \otimes X$ と $X \otimes (X \otimes X)$ が等しいことを言っている.
したがって単に $c_X^3 \colon X \to X \otimes X \otimes X$ などと書いていいし一般に
$c_X^n \colon X \to X^{\otimes n}$
があると言っていい.

以上の copy/discard 射を持つ対称モノイド圏を CD 圏という.

### 用語の定義

CD圏 $\C$ において,
射 $f \colon X \to Y$ が $d_Y f = d_X$ を満たす時,
$f$ は **因果的 (causal)** という.
因果的な射のことを **チャンネル (channel)** という.

$\C$ のすべての射が因果的であるとき, $\C$ は **affine** であるという.

チャンネル $\omega$ のドメインが $I$ のとき, つまり $\omega \colon I \to X$ のとき,
$\omega$ を $X$ 上の **状態 (state)** という.

## 離散確率分布

離散確率分布をまずモナドとして定式化し, そこから導かれるクライスリ圏がまさに確率分布を表現する圏であることを, これから見ていく.

### 離散確率分布の定義

集合 $X$ について,
これの有限部分集合 $\{x_1,x_2,\ldots,x_n\} \subset X$ を取り出して,
これらに確率分布 $(r_1,r_2, \ldots,r_n); ~~ r_i \in [0,1], \sum_i r_i=1$ を載せたものが離散確率分布と呼ばれる.
ここでは便利さのために, 関数

- $\omega: X \to [0,1]$
    - $\sum_{x \in X} \omega(x) = 1$
    - $\{ x \mid \omega(x) \ne 0\}$ が有限集合

のことを $X$ の上の **離散確率分布** と呼ぶことにする.

### 離散確率分布モナド

$X$ に対して, $X$ 上の離散確率分布すべてを集めたもの（これは集合になる）を $\D(X)$ と書く.
すると $\D$ は $\Sets$ 上のモナドになる.

- functor
    - $f \colon X \to Y$ に対して
    - $\D f \colon DX \to DY$
        - $\omega \mapsto \psi$
        - $; \psi(y) = \sum_{y = fx} \omega(x)$
- return
    - $\eta_X \colon X \to \D(X)$
        - $x \mapsto \omega$
        - $; \omega(x) = 1$
- 掛け算
    - $\mu_X \colon \D^2(X) \to \D(X)$
        - $\phi \mapsto \omega$
        - $; \omega(x) = \sum_{\omega' \in \D(X)} \phi(\omega') \cdot \omega'(x)$
        - 補足: $\D^2(X)$ というのは分布の分布
            - 事前分布 $\omega'$ が与えられる確率が $\phi(\omega')$ で, その上で $x$ が与えられる確率 $\omega'(x)$ を掛け算してる
- bind
    - $f \colon X \to \D(Y)$ に対して $f^\ast \colon \D(X) \to \D(Y)$ は,
        - $\omega \mapsto \psi$
        - $; \psi(y) = \sum_x \omega(x) \cdot f(x)(y)$

### 離散確率分布のクライスリ圏

モナド $\D$ についてのクライスリ圏 $\Kl$ が定められる.
これは次のようなもの

- 対象は $\Sets$ と同じ
- 射 $f \colon X \to Y$ とは $\Sets$ での写像 $f \colon X \to \D(Y)$ のこと
    - 恒等射 $1_X \colon X \to X$ は写像 $\eta_X$
    - $f \colon X \to Y; g \colon Y \to Z$ の合成は bind を用いて $g^\ast f \colon X \to Z$

### $\Kl$ は affine CD 圏

copy/discard 射を導入できればオッケーだけどこれは次の通り.

- copy
    - $c_X \colon X \to X \otimes X$
    - $c_X(x)(x, x) = 1$
        - NOTE: $c_X(x)$ は $X \otimes X$ 上の離散確率分布
- discard
    - $d_X \colon X \to I$
        - 集合の $I$ は単集合で終対象の $1$.
        - そして $\D(I) = 1$.

以上から $\Kl$ は CD 圏であり,
$\D(I)$ が終対象であることに由来して affine である.

### 確率, 同時確率

$\Kl$ は確率分布としての機能を備えている.

状態と定義した $I \to X$ の形をしたチャンネル $p$ があるとき,
$p$ は $X$ の上の離散確率分布を表している.
このことから, 対象 $X$ のことを確率変数だと,
$p(x)$ のことを確率 $P(X=x)$ だと思うことができる.

同時確率はテンソル積への射である.
すなわち状態 $\omega \colon I \to X \otimes Y$ があるとき,
これは $X \otimes Y$ の上の確率分布を与えるから $\omega(x,y)$ は $P(x, y)$ を表す.

### 射のテンソル積

$\Kl$ における射 $f \colon X \to Y$,
$g \colon U \to V$ があるとき,
$$f \otimes g \colon X \otimes U \to Y \otimes V$$
$$(x, u) \mapsto ((y, v) \mapsto f(x)(y) \times g(u)(v))$$

### 周辺化

次に確率の周辺化を考える.
これは確率変数 $X,Y$ について同時確率 $P(x,y)$ があるとき, $X$ の確率が
$$P(x) = \sum_y P(x,y)$$
で求まるというものだった.

$\Kl$ では同時確率 $P(x,y)$ を状態 $\omega \colon I \to X \otimes Y$ が与えるとする.

周辺化によって確率変数 $Y$ を消すことを考える.
これは discard $d_Y$ を合成することが対応する.
ちゃんというと, $X \otimes Y$ の $Y$ にだけ discard を適用したいので $(1_X \otimes d_Y)$ を合成する.

射の合成の定義に振り返るとこれは $\Sets$ において bind すればいいのだった.

- $1_X \colon X \to X \in \Kl$ は $\eta_X \colon X \to \D(X) \in \Sets$
    - $\eta_X(x)$ は $x$ のときだけ 1 という分布
    - $x'=x$ かどうか判定する特徴関数 $1[x'=x]$ にもなっている
- $d_Y \colon Y \to I \in \Kl$ は $DI \simeq I$ に注意して $d_Y \colon Y \to I$

$(\eta_X \otimes d_Y)^\ast(\omega) = \psi$ と置くと,
$$\begin{align*}
\psi(x) & = \sum_{(x',y') \in X \otimes Y} \omega(x',y') \cdot (\eta_X \otimes d_Y)(x',y')(x) \\
& = \sum_{(x',y')} \omega(x',y') \cdot 1[x'=x] \\
& = \sum_{y' \in Y} \omega(x,y')
\end{align*}$$

を得る.
これはまさに $\sum_y P(x,y)$ と対応している.

### 条件付き確率

チャンネル $f \colon X \to Y$ があるとき, これは条件付き確率 $P(y \mid x)$ とみなせる.
状態 $\omega \colon I \to X$ との合成を考えると,
$$(f \circ \omega)(y) = \sum_x \omega(x) \cdot f(x)(y)$$
となって, これは
$$P(y) = \sum_x P(x) P(y|x)$$
に対応している.

### 確率の乗法定理

今度は $X$ の確率 $\omega \colon I \to X$ から始めて, これをコピーしてから $f \colon X \to Y$ を適用してみる.
すなわち $$(1 \otimes f) c_X \sigma \colon I \to X \otimes Y$$ という合成射を考える.
全体としてみるとこの射は状態 $I \to X \otimes Y$ なので単に同時確率 $P(x,y)$ を表していそう.

この射を $\Sets$ に持ってくると,
$$(\eta_X \otimes f)^\ast c_X^\ast \sigma \colon I \to \D(X \otimes Y)$$
実際の値を計算すると,
$c_X(x_0)(x_1,x_2) = 1 \iff x_0=x_1=x_2$ と
$\eta_X(x)(x_1) = 1 \iff x=x_1$
に注意して,
$$\begin{align*}
\ast \mapsto (x,y)
& \mapsto \sum_{x_0} \sigma(\ast)(x_0) \times \sum_{(x_1,x_2)} c_X(x_0)(x_1,x_2) \times (\eta_X \otimes f)(x_1,x_2)(x,y) \\
& = \sigma(\ast)(x) \times f(x)(y)
\end{align*}$$
この右辺値は $P(x) \times P(y|x)$ に相当していて結局
$$P(x,y) = P(x) P(y|x)$$
を表している.

このように $\sigma$ と $f$ をうまく合成することで同時確率を得る操作を **integration** という.

### Disintegration

integration の逆の操作を考えることができる.

確率の等式
$$P(y|x) = \frac{P(x,y)}{P(x)}$$
を考えると次のようなことができる.

状態 $\omega \colon I \to X \otimes Y$ があるとき,
確率 $P(x)$ は周辺化によって取り出せて,
$$\omega_1 \colon I \to X$$
$$\omega_1 = (1 \otimes d_Y) \omega.$$
これを用いて
$$f \colon X \to Y$$
$$f(x)(y) = \frac{\omega(x,y)}{\omega_1(x)}$$
ただし $\omega_1(x)=0$ のときは適当な（なんでも良い）確率分布を割り当てればオッケー.

このようにすると
$$\omega = (1 \otimes f) c_X \omega_1$$
という分解ができる.

$\omega \colon I \to X \otimes Y$ からこのような $f \colon X \to Y$ （或いは $Y \to X$）を作ることを **disintegration** という.

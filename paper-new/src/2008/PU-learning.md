% Learning Classifiers from Only Positive and Unlabeled Data
% https://cseweb.ucsd.edu/~elkan/posonly.pdf
% PU 学習おいて Unlabeled を損失関数に取り入れる方法
% Semi-Supervised PU

$$
\def\N{\mathbb{N}}
\def\Pr{\mathop{\mathrm{Pr}}}
$$

## その他の参考文献

- [PU learningことはじめ](https://mamo3gr.hatenablog.com/entry/2020/11/29/123147)
- [PU Learningについて勉強した](https://www.jonki.net/entry/2020/02/22/185542)

## Intro

ラベルとして Positive, Negative の二値を考える場合でも, 現実では「ラベルが不明」という状態を表す Unlabeled というラベルがある.
Positive と Negative だけからなるデータセットで学習する枠組みを PN 学習というのに対して, Positive と Unlabeled だけからなる学習をする PU 学習をこの論文では考える.

## PU 学習

### 問題設定

データ空間 $X$ の各点についてラベル $Y = \{ 0, 1 \}$ が対応している. $1$ が Positive で $0$ が Negative の意味.

学習データとして有限のサンプル点集合が与えられるのだが,
Positive だと分かってるデータ点の集合と,
ラベルが不明なデータ点の集合だけが与えられる.
ここからラベルの予測器を学習する問題を PU 学習という.

与えられる学習データは次の $V$.
$$P = \{ (x,y,s=1) \}$$
$$N = \{ (x,s=0) \}$$
$$V = P \cup N$$

ここで $s$ はラベルが付与されているかどうかを示している.
$x,y$ に加えて $s$ も確率変数だと見なして議論を進めていく.

### 前提

- Negative にはラベルは付与されてない
    - $p(s=1 \mid x, y=0) = 0$
- Positive の中でラベルが付与されてるかどうかは無作為
    - $p(s=1 \mid x, y=1) = p(s=1 \mid x)$

### 方針

- nontraditional classifier $g$ を構築する
    - これは「ラベルが付与されてそうかどうか」を予測する
    - $g(x) \approx p(s=1 \mid x)$
- $g$ から traditional classifier $f$ を構築する
    - これは普通にラベルを予測する機械
    - $f(x) \approx p(y=1 \mid x)$

### $g$ の学習

「ラベルが付与されているかどうか」はデータセット全てについて分かることなので自由な方法で学習する.

### Lemmma 1

ラベルがついているなら必ず Positive だとしてるので,

$$\begin{align*}
p(s=1 \mid x)
& = p(s=1 \land y=1 \mid x) \\
& = p(y=1 \mid x) \cdot p(s=1 \mid x, y=1) \\
& = p(y=1 \mid x) \cdot p(s=1 \mid y=1) \\
\end{align*}$$

ここで $p(s=1 \mid y=1)$ はデータ分布のみによる定数なので, 定数 $c$ だとおくと,
$$p(s=1 \mid x) = c \cdot p(y=1 \mid x)$$
という関係を得る.

左辺と右辺に出てくる確率は結局欲しかった $g,f$ なので
$$g(x) = c f(x)$$
という比例関係を得る.

> $g$ を学習するというのはこの比例関係の意味で $f$ を学習することと同値.
> そしてこれは「ラベルがついてないものを全て Negative だと思った PN 学習」に等しい.

### $c$ の推定

3つ方法が提案されている

1. Positive なデータ $x$ を持ってきたときの $g(x)$ を $c$ として使う方法
    - $c = p(s=1 \mid y=1) = g(x=1)$
2. 全体の濃度で決める方法
    - $c = \sum_{x \in P} g(x) / \sum_{x \in V} g(x)$
3. 実用上
    - $c = \max_{x \in V} g(x)$

基本的には 1 が一番オススメされてる.

Lemmma 1 によると $f = g/c$ で $f$ が確率として well-defined なためには
$f \leq 1 \iff g \leq c$
なことが必要十分条件になってる.
3 の方法はこれが約束されるので嬉しい.

### Weighting unlabled examples

Lemmma 1 をそのまま使っても $g$ から $f$ を構築できるが,
学習データの重みに使う方法も提案されている.

ラベルが付与されていない $(x, s=0)$ について
$$\begin{align*}
p(y=1 \mid x, s=0)
& = \frac{1-c}{c} \frac{p(s=1\mid x)}{1 - p(s=1 \mid x)} \\
& = \frac{1-c}{c} \frac{g(x)}{1 - g(x)} \\
\end{align*}$$
になる, らしい.

これがラベルが付与されていない場合に $y=1$ である確率.
これを重みに掛けて学習すればよい.

$h(x,y)$ をデータ $x$ を予測して正解ラベルが $y$ であるときの損失関数だとする.
$$\mathcal{L} = \sum_{x \in P} h(x,1) + \sum_{x \in U} p(y=1 \mid x, s=0) h(x,1) + \sum_{x \in U} p(y=0 \mid x,s=0) h(x,0)$$
として学習する.

% Collaborative Filtering for Implicit Feedback Datasets (Weighted Regularized Matrix Factorization)
% http://yifanhu.net/PUB/cf.pdf
% 推薦システム 行列分解

## 概要

協調レコメンドである行列分解に正則化と重み付けを足した.

[RecSys2018 Spotify チャレンジ](https://arxiv.org/pdf/1810.01520.pdf) で spotif.ai というチームが用いていた.

## 手法

### 通常の行列分解

$m$ ユーザーと $n$ アイテムがあって, 既に何かしらの指標 $r_{ui}$ が各ユーザー $u$, アイテム $i$ ごとにある.
この指標は例えば視聴したとか購入したとかで,
$$p_{ui} = \begin{cases}1 & \text{ if } r_{ui} > 0 \\ 0 & \text{ otherwise}\end{cases}$$
と量化して使う.
この $p$ を学習データにして $p$ を予測する.

ここで普通のよくある行列分解では潜在ベクトル次元を $f$ として,
ユーザーベクトル $X \in \mathbb R^{m \times f}$ と
アイテムベクトル $Y \in \mathbb R^{n \times f}$ を作る.
それぞれの行ベクトルを $x_u, y_i$ などと書くことにする.

ここで $x_u^T y_i$ が $p_{ui}$ になるようなものを目指す.
したがって損失関数が次で与えられる.
$$\mathcal L = \sum_{u,i} \| p_{ui} - x_u^T y_i \|^2$$

### 正則化

ここで $x_u, y_i$ をL2正則化することが考えられる.
$$\mathcal L = \sum_{u,i} \| p_{ui} - x_u^T y_i \|^2 + \lambda \left( \|x_u\|^2 + \|y_i\|^2 \right)$$

### 重み付け

彼らは更にこの第一項のところに重みをつけた.
$p$ は $r$ を量化して作ったが, $r$ を重みとして用いたい.
より積極的に高評価があるものはよく反映するべきだし, また $p=0$ は必ずしも不評ではなく単に欠損値であるだけかもしれないから重みは小さくていい.
$r$ が大きければ大きくなって, $r=0$ のときに $1$ であるような値として

- $c_{ui} = 1 + \alpha r_{ui}$
- $c_{ui} = 1 + \alpha \log (1 + r_{ui} / \epsilon )$

を提案している.
彼らの実験では１つ目を使っている.

$$\mathcal L = \sum_{u,i} c_{ui} \| p_{ui} - x_u^T y_i \|^2 + \lambda \left( \|x_u\|^2 + \|y_i\|^2 \right)$$

### 最適化

（直接上の損失関数の最小化を勾配法とかでやってもいいと思うけど）$X,Y$ の片方を止めて微分をして極値の条件を求めるとと次の２つの関係が出てくる.

- $x_i = (Y^T C^u Y + \lambda I_f)^{-1} Y^T C^u p^u$
- $y_u = (X^T C^i X + \lambda I_f)^{-1} X^T C^i p^i$

ただしここで $C^u$ は対角行列であって $C^u_{ii} = c_{ui}$ というもの.
同様に $C^i$ は対角行列であって $C^i_{uu} = c_{ui}$ であるもの.
$p^u$ は $n$ 次元ベクトルで $p^u_i = p_{ui}$ であるもの.
同様に $p^i$ は $m$ 次元ベクトルで $p^i_u = p_{ui}$ であるもの.

この２つの関係式を使って, 一方を止めて他方を最適化, というのを交互に繰り返すことで最適化ができる.

### 説明的推薦

先の関係式を用いると, アイテムどうしの類似度が出てきて, 「このアイテムを購入したからこれがお薦め」という説明が可能.
ユーザー $u$ へのアイテム $i$ のスコアは $y_i^T x_u$ で計算できるが,
$x_u$ は先の関係から $C^u, p^u, Y$ で表現できて
$$s^u_i = y_i^T (Y^T C^u Y + \lambda I_f)^{-1} Y^T C^u p^u$$
一旦この真中の
$(Y^T C^u Y + \lambda I_f)^{-1}$
を $W^u$ と書くと
$$s^u_i = y_i^T W^u Y^T C^u p^u$$
$p^u$ で 1 が立っているところを $j_1, j_2, \ldots$ とする.
それ以外はゼロなので
$$s^u_i = \sum_j c_{uj} (y_i^T W^u y_j)$$
になる.
$y_i^T W^u y_j$ という値を $i$ と $j$ との類似度と見ることが出来て,
結局スコアは $u$ が過去視聴/購入したアイテムとの類似度との線形結合である, と解釈できる.

## 感想

手法自体は既にある正則化付き行列分解に重みを付けただけだけど, 最適化の式とアイテムの類似度の算出が面白い.
その類似度が本当に説明になっているのかは眉唾だが, 「良い推薦システムは説明的であるべき」という主張は同意できる.

ところで重みなしにしたかったら $C^u=I, C^i=I$ にすればいいだけで, 正則化なしにしたかったら $\lambda = 0$ にすればいいだけなのだが,
その場合 $W^u = Y^T Y$ であり, $i$ と $j$ の類似度として
$s_{ij} = y_i^T Y^T Y y_j = (Yy_i)^T (Yy_j)$
となる.
これはどんな値なんだろう.
$Y y_j$ は $(y_k^T y_j)_k$ なるベクトルで,
$Yy_i = (y_k^T y_j)_k$ との内積をとると
$s_{ij} = \sum_k (y_k^T y_i) (y_k^T y_j)$.

何も考察せずにアイテムどうしの類似度を出せと言われたらつい $y_i^T y_j$ を計算してしまう.
この単純な内積による類似度を $t_{ij}$ ということにすると,
$s_{ij} = \sum_k t_{ik} t_{kj}$
となる.
$k$ を仲介にした類似度?

## 関連

- [ALS Implicit Collaborative Filtering](https://medium.com/radon-dev/als-implicit-collaborative-filtering-5ed653ba39fe)
    - 解説記事. タイトルの ALS とは最適化の手法名で, パラメータをどれか止めて一つだけを最適化するのを交互にやる方法らしい
- [implicit](https://implicit.readthedocs.io/en/latest/als.html)
    - Python で実装されたライブラリ

% [1810.05997] Predict then Propagate: Graph Neural Networks meet Personalized PageRank
% https://arxiv.org/abs/1810.05997
% 深層学習 グラフ学習

![](https://i.imgur.com/mrT1Z10.png)

## オリジナル PageRank (1998)
頂点にいる確率ベクトル $\pi$ と隣接行列（を正規化したもの） $A$ を使って,
$$\pi = A \pi$$
を解く.

## Personalized PageRank (1998)
テレポート（リスタート）を表す teleport vector $i$ を使って,
$$\pi = (1-\alpha) A \pi + \alpha i$$
ここで $\alpha$ は $0 < \alpha \leq 1$ でテレポートする確率を表す.

これを陽に解くと次の式になる.
$$\pi = \alpha ( I_n - (1-\alpha) A )^{-1} i$$

このモデルは次のように使われる.

頂点 $x$ からスタートして頂点 $y$ のスコアを知りたい.
$x$ に当たるところだけ bit を立てた one-hot vector を $i$ として使う.
上の式を解いて得た $\pi$ の $y$ に当たる成分が得たかったスコア
$I(x,y)$
である.

## Personalized Propagation of Neural Predictions (PPNP)

以上の手法にニューラルネットを適用する.

頂点 $i$ に特徴ベクトル $x_i \in \mathbb R^m$ があるとき,
パラメータを $\theta$ とするニューラルネットワーク $f_\theta$ を使って
$$h_i = f_\theta(x_i)$$
とする.
ただしここでグラフの頂点数を $n$ だとして $h_i \in \mathbb R^n$ とする.
というのも $h$ が先程の $i$ 相当だから.

$$z = \mathrm{softmax}( \alpha ( I_n - (1-\alpha) A )^{-1} h_i )$$
これの $j$ 成分がスコア $(i,j)$ になる.

全ての頂点に関するスコアを求めるとしたら,
$x_i$ を並べた行列 $X$ から $(i,j)$ として得られる.

以上を使うことでグラフに関するニューラルネットワーク計算が end-to-end に完了できる.
ただしこの通りに行列演算するのはあまりに非効率である.

> 特に逆行列なんて計算するのが無理だろう.

## Approximate PPNP (APPNP)

PageRank を Random walk with restart で近似的に計算するのと同じことをする.

- $z_0 = h = f_\theta(x)$
- For each $k=1,\ldots, K$
    - $z_k = (1-\alpha) A z_{k-1} + \alpha h$
- $z = \mathrm{softmax}(z_K)$

とは言え行列の掛け算をするので, 頂点数 $N$, イテレーション数 $K$ に対して $O(K N^2)$ は時間が掛かる.
彼らの実験では $N < 2e4$, $K \leq 20$ 程度.



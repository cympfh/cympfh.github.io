% [1711.00937] Neural Discrete Representation Learning (VQ-VAE)
% https://arxiv.org/abs/1711.00937
% 深層学習 オートエンコーダ 生成モデル VAE

$\def\sg{\mathrm{sg}}$

## 概要

VAE で困るのが, posterior collapse してしまう現象.
この論文で提案される VQ-VAE は VAE に Vector Quantization を導入する.

## 方法

### (離散) 潜在空間

潜在空間を
$$e = \left[ e_1, e_2, \ldots, e_K \right] \in \mathbb R^{D \times K}$$
で表現する (codebook).
この空間のサイズは $K$ であって, 各点 $e_i$ はさらに $D$ 次元実ベクトルで表現される.
この空間自体もあとで同時に学習する.

### エンコード

エンコーダー $E$ は入力 $x$ を
$$E \colon \mathcal X \to \mathbb R^D$$
$$E \colon x \mapsto E(x)$$
で一旦写した後, 量子化を行う. それは次で定義される.
$$Q \colon \mathbb R^D \to \mathbb R^D$$
$$Q(z) = e_k ~~\text{ where }~~ k = \mathrm{argmin}_j \| z - e_j \|$$
従って固定された $e$ に対して $Q$ の値域は実質 $K$ みたいなもの.

VAE のエンコード部分を $$Q(E(x))$$ に置き換えて使う.

### デコード

適当に $z = Q(E(x))$ を $x$ に戻すような $D(z)$ を定義する.

### 学習

学習の中では $e$ も併せて更新していく.
ただのオートエンコーダーとしては
$$L = \| x - D(Q(E(x))) \|^2$$
とか
$$L = \log p\left( x \mid D(Q(E(x)) \right)$$
を損失関数とするが, これに $e$ の更新要素を加えてく.
$$L' = \| \sg[Q(E(x))] - E(x) \|^2 + \beta \| Q(E(x)) - \sg[E(x)] \|^2$$
を足す.
ここで $\sg[\cdot]$ は勾配計算を止めるだけの操作 (stop gradient).

> つまり $\| \sg[a] - b \|^2$ の最小化は $a$ は止めて $b$ だけを $a$ に近づけるように更新する.

また $\beta$ はハイパーパラメータ.
この値は変えても結果は大して変わらなくて $0.1$ から $2.0$ の間ぐらいならなんでもよかったらしい.
最終的に $0.25$ を使ったそう.

### A.1 VQ-VAE dictionary updates with Exponential Moving Averages

損失関数の $\| \sg[Q(E(x))] - E(x) \|^2$ 部分について.

$n$ 個の $z_1^i = E(x_1), \ldots, z_n^i = E(x_n)$ が, $e_i = Q(z_j^i)$ であったとする.
上の部分を最小化するには当然
$$e_i = \frac{1}{n} \sum_j z_j^i$$
とすれば良いだけになる.
ただミニバッチごとにこれをすれば必ずしも損失関数全体が最小化されるわけではないので,
少しずつそれに近づける (exponential moving) ことをする.
$$e_i \leftarrow \gamma e_i + (1-\gamma) \frac{1}{n} \sum z_j^i$$
ここで $\gamma$ は 0 と 1 の間の定数で, 彼らは経験的に $0.99$ を設定したという.

### 事前分布

VAE を十分学習した後,
潜在分布に対する事前分布を見積もる.
よくわからん.

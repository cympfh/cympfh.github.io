% [1802.03426] UMAP: Uniform Manifold Approximation and Projection for Dimension Reduction
% https://arxiv.org/abs/1802.03426
% 多様体学習 次元圧縮

## 実装

[lmcinnes/umap](https://github.com/lmcinnes/umap)

## 概要

データの次元圧縮として t-SNE や PCA など他諸々あり、特に可視化を目的としたとき、t-SNE が特に優っている.
多様体学習という点で t-SNE に似てるが UMAP を提案する.
t-SNE に優っている点として、視覚的に分かり良いプロットが出来上がること、
大域的な構造が保たれること、データサイズが t-SNE のときより多くても計算可能であること (計算量が少ない?) を挙げている.

## アルゴリズム

$\def\M{\mathcal{M}}\def\R{\mathbb{R}}\def\P{\mathcal{P}}$

まずはじめに、データが乗っている多様体自体を推定する必要がある.
多様体は既知のもの (例えば $\R^n$) としてしまう場合もある.
さもなくばデータから推定する.
そしてリーマン計量を推定してリーマン多様体とする.

データは実際 $\R^n$ の点として与えられるので、多様体は $\R^n$ の中に埋め込まれたもののようであるが、
ただし計量は別である.
つまり外側では普通のユークリッド距離を用いる.

### Lemma 1

リーマン多様体 $(\M,g)$ を考える.
ただし $\M \subset \R^n$ とする.
点 $p \in \M$ について、十分小さな近傍 $U$ を取ると、$g$ は $U$ の中では定数でしかも対角行列と見なせると仮定する (!!)
$$g_{i,j} = k \cdot \delta_{i,j}$$
$p$ を中心とする開球 $B \subset U$ をさらにとる.
$B$ は $\R^n$ で測って半径 $r$ の図形だとする.

外側の $\R^n$ での座標を $x^1,\ldots,x^n$ とすると、$B$ の $\M$ での体積は、計量 $g$ を用いて
$$V(B) = \int_B \sqrt{\mathrm{det}(g)} dx^1 \cdots dx^n$$
と表される.

今 $B$ の中で $g$ は定数だとしているので、$g$ の項は外に出せて、
$$V(B) = \sqrt{\mathrm{det}(g)} \int_B dx^1 \cdots dx^n$$
となって、結局 $\R^n$ での体積に係数を掛けただけのものになっている.

一般に $\R^n$ での半径 $r$ の球の超体積は、
$$\frac{\pi^{n/2} r^n}{\Gamma(n/2 + 1)}$$
である.

というわけで、
$$V(B) = \sqrt{\mathrm{det}(g)} \frac{\pi^{n/2} r^n}{\Gamma(n/2 + 1)}$$

$B$ の半径を慎重に調整することで
$$V(B) = \frac{\pi^{n/2}}{\Gamma(n/2 + 1)}$$
に出来たとする.
即ち、
$$\mathrm{det}(g) = \frac{1}{r^{2n}}$$
とできたとする.
この時の半径 $r$ を用いると、計量 $g$ は、その対角成分が定数だと仮定してるので、
$$g_{i,j} = \frac{1}{r^2} \delta_{i,j}$$
と表される.

曲線の長さは、内積の平方根の積分で与えられるものであるので、
$\M$ 上の $g$ の下での距離は、$\R^n$ での距離の $\sqrt{g}$ 倍.
即ち、2点 $p,q \in \M$ の間の距離は、
$$d_{\M}(p,q) = \frac{1}{r} d_{\R^n}(p,q)$$
で求まる.

以上が Lemma 1.
$\M$ から一様にデータがサンプリングされたとする ($X = X_1,\ldots,X_m$).
$X$ から $k$ 近傍法を用いて、点 $X_i$ を中心とする開球を推定する.
$k$ 番目までの ($\R^n$ での) 距離を半径 $r$ として、$\M$ での $X_i$ の周りでの計量を、 Lemma 1 で近似する.

### Definition 1

ここでは、圏 $\Delta$ とは、有限の順序付き集合
$$[n] = \{1,\ldots,n\}$$
の全体 ($[0],[1],\ldots,[n],\ldots$) で、射はその間の (non-strictly に) 順序を保つような写像であるようなものとして定義する.

> ここらへんの理論は
> David I Spivak. "Metric realization of fuzzy simplicial sets."
> で作られている.

### Definition 2

simplicial set (簡易版集合?) とは、
$\Delta^{op}$ から Sets への関手のこととして定義する.
Sets は対象が集合で射が写像の圏.

### Definition 3

$I$ を区間 $(0,1] \subset \R$ とする.
位相として $(0,a) : a \in (0,1]$ を入れる.
開集合を対象とし、包含関係を射として位相空間を圏と見做す.

$I$ 上の前層 (presheaf) $\P$ を、$I^{op}$ から Sets への関手と定義する.
fuzzy set とは、 $I$ 上の前層であって、単射であるものと定義する.

### Definition 6

extended-psuedo-metric space (拡張擬距離空間?) とは次の $(X,d)$ と定義する.

集合 $X$, $d:X \times X \to \R_{\geq 0}\cup\{\infty\}$ について次が成り立っている:

1. $d(x,y) \geq 0$ and $x=y \Rightarrow d(x,y)=0$
2. $d(x,y)=d(y,x)$
3. $d(x,z) \leq d(x,y) + d(y,z)$

つまり $d(x,y)=0 \Rightarrow x=y$ だけが無い距離空間.

対象を拡張擬距離空間とし、射をその間の non-expansive mapping
($d(f(x), g(y)) \leq d(x,y)$ なる $f$)
を射とする圏を
*EPMet*
と呼ぶことにする.
EPMet の部分圏であって、対象を有限集合に限ったものを
*FinEPMet*
と呼ぶことにする.

...わからん

## 使ってみる

ほぼほぼ
https://www.kaggle.com/mrisdal/dimensionality-reduction-with-umap-on-mnist
のコピペだけど。

```bash
pip install mnist
pip install umap-learn  # not `umap`
```

```python
import mnist
import umap

M = 10000  # 数秒でやるにはこのくらいの数が限度
X = mnist.train_images()[:M]
X = X.reshape((X.shape[0], X.shape[1] * X.shape[2]))
y = mnist.train_labels()[:M]

embedding = umap.UMAP(n_neighbors=5,
                      min_dist=0.3,
                      metric='correlation').fit_transform(X)

import matplotlib.pyplot as plt

plt.figure(figsize=(12,12))
plt.scatter(embedding[:, 0], embedding[:, 1], c=y)
plt.axis('off');
```

![](https://i.imgur.com/wDbuyYN.png)

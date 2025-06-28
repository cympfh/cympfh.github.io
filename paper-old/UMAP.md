% [1802.03426] UMAP: Uniform Manifold Approximation and Projection for Dimension Reduction
% https://arxiv.org/abs/1802.03426
% 多様体学習 次元圧縮

$\def\M{\mathcal{M}}\def\R{\mathbb{R}}\def\C{\mathcal C}\def\P{\mathcal{P}}\def\op#1{#1^{\text{op}}}\def\Sets{\mathrm{Sets}}$

## リンク

- [arxiv](https://arxiv.org/abs/1802.03426)
- [github:lmcinnes/umap](https://github.com/lmcinnes/umap)
- [docs](https://umap-learn.readthedocs.io/en/latest/how_umap_works.html)

## 概要

t-SNE のようなデータの次元圧縮の方法を提案する.
観測されるデータはあるリーマン多様体の上に一様分布にあるものだと仮定し,
それを推定した上で,
低次元ユークリッドと同距離写像が引けるようにマッピングする.

## イントロ

データの次元圧縮として t-SNE や PCA など他諸々あり, 特に可視化を目的としたとき, t-SNE が特に優っている.
多様体学習という点で t-SNE に似てるが (結果もまあまあ似ているが)
視覚的に分かり良いプロットが出来上がること,
大域的な構造が保たれること,
t-SNE よりも大きなデータサイズでも高速に計算可能であることを挙げている.
それから t-SNE と違ってしっかりとした数学的背景があることを推してる.

## アルゴリズムの概要

データが乗っているリーマン多様体 $(\M, g)$ を推定する.
直接のデータは $\R^n$ の点として与えられているとすると,
$\M$ は $\R^n$ に埋め込んだものとみなせるが, 計量 $g$ はまた別に推定して与える.
計量の推定に次の Lemma を用いる.

### Lemma

リーマン多様体 $(\M, g)$ を考える.
ただし $\M \subset \R^n$ とする.

今次のような仮定を置く.
すなわち, 点 $p \in \M$ について, 十分小さな近傍 $U$ を取ると, $g$ は $U$ の中ではある定数 $k$ があって次のような対角行列であるとする:
$$g_{i,j} = k \cdot \delta_{i,j}$$
$p$ を中心とする開球 $B \subset U$ をさらにとる.
$B$ は $\R^n$ で測って半径 $r$ の図形だとする.

外側の $\R^n$ での座標を $x^1,\ldots,x^n$ とすると, $B$ の $\M$ での体積は, 計量 $g$ を用いて
$$V(B) = \int_B \sqrt{\mathrm{det}(g)} dx^1 \cdots dx^n$$
と表される.

今 $B$ の中で $g$ は定数だとしているので, $g$ の項は外に出せて,
$$V(B) = \sqrt{\mathrm{det}(g)} \int_B dx^1 \cdots dx^n$$
となって, 結局 $\R^n$ での体積に係数を掛けただけのものになっている.

一般に $\R^n$ での半径 $r$ の球の超体積は,
$$\frac{\pi^{n/2} r^n}{\Gamma(n/2 + 1)}$$
である.

というわけで,
$$V(B) = \sqrt{\mathrm{det}(g)} \frac{\pi^{n/2} r^n}{\Gamma(n/2 + 1)}$$

$B$ の半径を慎重に調整することで
$$V(B) = \frac{\pi^{n/2}}{\Gamma(n/2 + 1)}$$
に出来たとする.
即ち,
$$\mathrm{det}(g) = \frac{1}{r^{2n}}$$
とできたとする.
この時の半径 $r$ を用いると, 計量 $g$ は, その対角成分が定数だと仮定してるので,
$$g_{i,j} = \frac{1}{r^2} \delta_{i,j}$$
と表される.

距離を考える.
$(\M, g)$ での距離を $d_\M$, 外のユークリッド空間での距離を $d_{\R^n}$ と書くことにする.

曲線の長さは, 内積の平方根の積分で与えられるものであるので,
$\M$ 上の $g$ の下での距離は, $\R^n$ での距離の $\sqrt{g}$ 倍.
即ち, 2点 $p,q \in \M$ の間の距離は,
$$d_{\M}(p,q) = \frac{1}{r} d_{\R^n}(p,q)$$
で求まる.

この Lemma はある点 $p$ に注目したときに, $p$ の近くにある $q$ との距離を,
適切に球を取ることでユークリッド距離から計算できることを言っている.
例えば,
$\M$ から一様にデータ
$$X = \{ X_1, \ldots, X_N \}$$
がサンプリングされたとする.
$X$ から $k$ 近傍法を用いて, 点 $p=X_i$ についてその近傍
$$p=p_0, p_1, p_2, \ldots, p_k$$
を得たとき,
$$d_\M(p, p_j) = \frac{d_{\R^n}(p, p_j)}{d_{\R^n}(p, p_k)}$$
とできる.

$U$ の中では単なるユークリッド空間の定数倍であるが,
別の点に注目した時の周りでの距離はまた別の定数倍の空間が広がっている.
それらを比較することができる.

## 準備 - Fuzzy topological representation

さてここからが厄介であるが, UMAP では
データ (点列) を Fuzzy topological representation という方法で表現する.
これを定義するに当たって, この論文では圏論の言葉で説明されている.
(圏論を知らなくても読める説明は
[機械学習の数理 Advent Calendar 2018](https://umap-learn.readthedocs.io/en/latest/how_umap_works.html)
に書きたいなあと思ってます.)
(ただまあ自然変換まで真面目に勉強すれば読めると思う.)

元ネタは
`David I Spivak, "Metric realization of fuzzy simplicial sets."`
であるそう.

ひたすら概念を定義していく.

#### 圏 $\Delta$

有限順序集合
$[n] = \{1,\ldots,n\}$
$(n \geq 1)$
を対象にする集合.
射は順序を保つ写像 $f : [n] \to [m], a \leq b \implies fa \leq fb$.

#### simplicial set (単体的集合)

関手 $\op{\Delta} \to \Sets$ のこと.
($\Sets$ は集合全体からなる圏のこと.)

要するに $A$ が simplicial set であるとは,
$[n]$ という集合について, 集合 $A_n$ を割り当てるようなもののこと.

> 集合についてその個数しか見ないという点で simplicial なのかな?

#### unit interval $I$

実数の上の半開区間
$$I=(0,1]$$
を考える.
これはまた $a \in I$ を対象にし $a \leq b$ を射にする圏だとみなせる.

この論文の書き方だと対象は $a$ ではなくて $[0,a)$ だけど, ここでは前者で書くことにする.

#### 前層 (presheaf)

$\P$ が圏 $\C$ の上の前層であるとは $\P$ が関手
$$\op{\C} \to \Sets$$
であること.

#### fuzzy set

$\P$ が fuzzy set であるとは $I$ の上の前層であって,
$\P(a \leq b)$ が包含写像であること.

つまり $I$ の上では射 $a \leq b$ があり,
$\P$ は関手なのでこの射を $\Sets$ の上に反対向きに写す.
そのときその射が単なる包含写像であるので
$$\P(a) \supset \P(b)$$
となること.

例えば実数の単調増加列
$$0 < a_1 \leq a_2 \leq \cdots \leq 1$$
に対して
$$\P(a_1) \supset \P(a_2) \supset \cdots \supset \P(1)$$
という集合の列を与えるものが "fuzzy set".

> フィルタのような何かを思わせる.

これが "fuzzy set" であることの気持ちを知っておく必要がある.
通常の集合 $X$ とは要は要素 $x$ に属してるかどうかだけを情報として持つ.
次のような membership 関数がある.

$$\mu_X(x) = \begin{cases}
1 & \text{ if } x \in X \\
0 & \text{ o/w }
\end{cases}$$

fuzzy set の fuzzy さの所以はこの数字を $(0,1]$ に拡張したことである
($0$ を許さなくなったので真の拡張ではないけど).

$$\mu_\P(x) = \text{ strength of membership }(x \in X)$$

$\P$ 自体は「属する強さ」$0 < a \leq 1$ を与えたときに,
その強さ (以上) で属してる値すべてを集めてきた集合 $X_a = \P(a)$ を返すような関数と思える.
だから強さが最大の $\P(1)$ は最も小さく, $\lim_{a \to 0} \P(a) = \bigcup_{a \in I} \P(a)$ が最も大きい.

#### 圏 Fuzz

対象が fuzzy set 全てであるような圏を Fuzz と呼ぶ.
射は, 対象を関手と見たときの自然変換.

#### fuzzy simplicial set

$\op{\Delta}$ から Fuzz への関手のこと.
Fuzz の対象は fuzzy set であって, それは $\op{I}$ から $\Sets$ への関手であった.
というわけで型を書けば
$$\op{\Delta} \to \op{I} \to \Sets$$
となるが, これは
$$\op{(\Delta \times I)} \to \Sets$$
と同型.

というわけで fuzzy simplicial set のことを
$\Delta \times I$ の上の前層と同一視することにする.
むしろこちらのほうが扱いやすい.

#### 圏 $\def\sFuzz{\mathrm{sFuzz}}\sFuzz$

対象が fuzzy simplicial set であるような圏のこと.
射は, 対象を関手と見たときの自然変換.

#### Extended-Pseudo-Metric Space

extended-pseudo-metric space とは次の $(X,d)$ と定義する.

$X$ は集合.
$d$ は $X \times X \to \R_{\geq 0}\cup\{\infty\}$.
ただし次の3つを要請する.

1. $d(x,y) \geq 0$ and $x=y \Rightarrow d(x,y)=0$
2. $d(x,y)=d(y,x)$
3. $d(x,z) \leq d(x,y) + d(y,z)$

すなわち $d$ の値として $\infty$ を許し,
また $d(x,y)=0 \implies x=y$ を一般に要請しないような距離空間.

対象を extended-pseudo-metric-space とし,
その間の non-expansive mapping ($d(f(x), g(y)) \leq d(x,y)$ なる $f$) を射とする圏を
**EPMet**
と呼ぶことにする.
EPMet の部分圏であって, 対象を有限空間に限ったものを
$\def\FinEPMet{\mathrm{FinEPMet}}\FinEPMet$
と呼ぶことにする.

#### 関手 $\def\FinReal{\mathrm{FinReal}}\FinReal$

関手 $\FinReal : \sFuzz \to \FinEPMet$ を定義する.

まず対象の対応付を定義する.
$\FinReal$ は fuzzy simplicial set をある(EPM)距離空間に写す.
$([n], a) \in \Delta \times I$ を単に $\Delta^n_a$ と書くことにすると

$$\FinReal (\Delta^n_a) = (\{x_1,\ldots,x_n\}, d_a)$$
ただし
$$d_a(x_i, x_j) = \begin{cases}
- \log(a) & \text{ if } i \ne j \\
0 & \text{ o/w }\end{cases}$$

#### 関手 $\def\FinSing{\mathrm{FinSing}}\FinSing$

逆向きの関手は次のように定義できる.
$$\FinSing : \FinEPMet \to \sFuzz$$
$$\simeq \FinEPMet \to \op{(\Delta \times I)} \to \Sets$$
$$\FinSing(Y)(\Delta^n_a) = \mathrm{Hom}(FinReal(\Delta^n_a), Y)$$

さて再び現実データの話に戻る.
現実データ $X$ は先の Lemma によって距離空間にすることができるのであれば,
これを $\FinSing$ によって fuzzy simplicial set に写せる.

先の Lemma によって与えられる距離は
$X_i \in X$ の周りで $X_i$ との距離だけであった.
他の点同士の距離を定める必要がある.
$X_i$ の周りでは点は $X_i$ とだけ連結であるとし,
彼らは次のように仮定した:

- $X_i$ から見て異なる二点どうしは十分離れている
    - その二点間の距離は無限
- $X_i$ との最近傍の点との距離はゼロ

> ゼロや無限を使うのは後々の便宜上で,
> ゼロだとその二点は接続されてる (1-単体が生えてる) ことになって,
> 無限だと接続されてないことになるのが嬉しいから, だと思う.

というわけで
$X_i$ の周りで見る距離 $d_i$ は, $\M$ 上での距離 $d_\M$ を用いて,

$$d_i(X_j, X_k) = \begin{cases}
0 & \text{ if } j = k \\
d_\M(X_i, X_k) - \rho & \text{ if } j=i \\
\infty & \text{ o/w }
\end{cases}$$

ここで $d_\M$ は Lemma によって推定される距離であり,
$\rho$ は $X_i$ との最近傍との点との $d_\M$ の値.

#### Fuzzy Topological Representation

データ $X = \{X_1, \ldots, X_N\} \subset \R^n$ について,
extended-pseudo-metric space の族
$$\{(X, d_i)\}_{i=1,2,\ldots,N}$$
を与える.
ここで $d_i$ とは $X_i$ の周りでの距離であって上で定義したもの.

これについて, $X$ の fuzzy topological representation とは,
$$\bigcup_{i=1}^N \FinSing(X, d_i).$$

UMAP において「データセットの表現」とはこれを言う.

> この union はどういう意味???
> $\FinSing(X,d_i) \in \Sets$
> なのでこの値についての union だろうか???

## 次元削減の方法

データセット $X$ のその表現を同じ記号 $X$ で書く.

これに対応する低次元のデータ
$$Y = \{Y_1, \ldots, Y_N \} \subset \R^d$$
を推定したい $(d \ll n)$.
ただし $Y$ は $\R^d$ そのものを多様体とする空間の中に一様分布するものだとする.
従って距離もユークリッド距離そのもので与えられる.

2つの表現 $X, Y$ があるときに, この2つの距離を, 理想的なときに最短になるように定義する.
そのためにさっきやったように "the strength of membership" に変換して, その cross entropy を距離と定める.

つまり fuzzy set $\P$ の membership 関数とは
$$\mu(x) = \sup \{ a \in (0,1] ~|~ x \in \P(a) \}$$
で与えられる.

2つの表現からそれぞれの membership $\mu, \nu$ があるとき,
その2つの距離を次のように定義する.
ただし $\mu, \nu$ の定義域は同じ $A=\lim \P$ だとする.
$$C(\mu, \nu) = \sum_{a \in A}
\mu(a) \log \frac{\mu(a)}{\nu(a)} +
(1 - \mu(a)) \log \frac{1 - \mu(a)}{1 - \nu(a)}$$

$X$ が与えられたときに, この $C$ を最小にするような $Y$ を見つけてくればよくて,
それには t-SNE と同様に確率的勾配降下法などを用いればよいらしい.

> $X,Y$ は fuzzy simplicial set であって $C$ は fuzzy set の距離なのだが,
> simplicial はどこで外れた??
> どこかで $\Delta^n$ を固定する必要があるのだが.

## 実装

以上の理論と実際の実装はそれなりに離れてるぽい.
まず 1-simplex しか実際には見ない.
つまり $[2] \in \Delta$ についてしか考えない.
なので fuzzy simplicial set での表現してても実際には simplicial set である.

学習するデータ $X$ の表現は具体的には次のようになる.

- 各点 $X_i$ の周りで距離 $d_i$ を作る
    - (最近傍がゼロで $k$ 番目が $1$ になるような例のやつ)
- 各2点 $(X_i, X_j)$ を結ぶエッジ (=1-simplex) について
    - これを含む strength を $\exp(-d_i(X_i, X_j))$ とする simplicial set $\bar{X}$ を作る

$\bar{X}$ を $X$ の fuzzy topological representation とする.

$Y$ については, まず大雑把に $X$ を低次元ユークリッド空間に写す.
これには "Laplace-Beltrami operator" を使ったそう.
それから, 各エッジについて距離乃至 strength of membership についてのクロスエントロピーを最小化するように $Y$ を動かす.
strength が正のものと, ゼロのもの (つまり距離が無限) を negative sampling して上手く選んでSGDに突っ込む.

## 使ってみる

ほぼほぼ
https://www.kaggle.com/mrisdal/dimensionality-reduction-with-umap-on-mnist
のコピペだけど。

```bash
pip install mnist
pip install umap-learn  # not `umap` (!!)
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

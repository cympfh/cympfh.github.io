% Deep Perm-Set Net: Learn to predict sets with unknown permutation and cardinality using deep neural networks
% https://openreview.net/forum?id=rJVoEiCqKQ
% 深層学習 集合学習

$$\def\D{\mathcal D}$$

## 概要

集合がターゲットであるような予測器を構成する

## 手法

### 尤度

（空でない有限サイズの）集合の確率を次のように考える.
集合にはサイズがあり, そして要素には順序がない.
サイズに関してはサイズそのものの事前分布があり, またサイズに指数的に比例する項があるとする.
順序については順序を入れてリストとして扱う方が確率を考える上では扱いやすい.
それの周辺確率を求めればよい.

したがって $Y = \{y_1, \ldots, y_m\}$ の確率は
$$p(Y) = p(m) \times U^m \times \sum_{\pi} p(\pi) p_m(y_{\pi_1}, \ldots, y_{\pi_m})$$
で表せる.
ここで $U$ がさっき述べた $m$ に指数的に比例するための項で,
論文では "U is the unit of hyper-volume in the feature space" といってるが feature space がなんのことかよくわからない.
適当な補正項と思うことにする.
$\pi$ は $(1,2,\ldots,m)$ の置換であって $m!$ 通りあることになる.
そして $p_m$ は長さ $m$ のリストの同時確率.

ところでリスト
$(y_{\pi_1}, \ldots, y_{\pi_m})$
は $Y^m_\pi$ と書くことにする.

今の $Y$ の確率を, 入力 $x$ とモデルのパラメータ $w$ によって条件付ければ予測器になる.
$$p(Y \mid x,w) = p(m \mid x,w) \times U^m \times \sum_{\pi} p_m(Y^m_\pi, \pi \mid x,w)$$

### 事後確率

ではパラメータ $w$ をデータセット
$\D = \{(x_i, Y_i)\}_i$
から事後確率の形で最尤推定する.

$$\begin{align*}
p(w \mid \D)
& = p(\D \mid w) p(w) / p(\D) \\
& \propto p(\D \mid w) p(w) \\
& = p(w) \prod_i p(Y_i \mid x_i, w)
\end{align*}$$

さて $p(m \mid x,w), p(\pi \mid x,w)$ というのがあるが,
実際には彼らはポアソン分布なり二項分布なりを使ったそう.

### 学習

$\pi$ はもちろん $m!$ 全通りは試せないのでサンプリングして使う.


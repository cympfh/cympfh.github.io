% Knows When it Doesn't Know: Deep Abstaining Classifiers
% https://openreview.net/forum?id=rJxF73R9tX
% 機械学習 深層学習 分類器

## 概要

"deep abstaining classifier (DAC)" を提案する.
こいつは学習の時点で学習を難しくするような事例を棄却することを許されている.
DAC は noisy or confusiong examples からも台となる構造を学習し,
noisy example についてはそれが noise であることを特定でき,
out-of-category であることを検出できる.

## DAC

多クラス分類
$$X \to (Y = \{1,2,\ldots,k\})$$
を考える.

普通は分類器として確率
$$p_i(x) = p(y=i | x; w)$$
の近似値を出力するマシンを DNN で構成し, 交差エントロピーを損失関数にする.

DAC では $k+1$ 番目のクラスを付け足す.
すなわち $p_{k+1}$ があって,
損失関数を以下にする:
$$\mathcal{L}(x) = \left( 1 - p_{k+1}(x) \right) \left( - \sum_{i=1}^k t_i \log \dfrac{p_i(x)}{1-p_{k+1}(x)} \right) + \alpha \log \dfrac{1}{1 - p_{k+1}(x)}$$
ここで $t_i$ は $x$ の真のラベルが $y=i$ である時に限り $1$ であるインジケータ.
$\alpha$ は正の定数.

1項目は分類に関する損失で $p_{k+1}=0$ で真のラベルを $p_i=1$ で予測するとき最小になる.
或いは $p_{k+1}=1$ にしてもゼロで最小になるので, 分類を諦める (棄却) ことを許している.
2項目は棄却することに対する罰則で, $\alpha (>0)$ がそのペナルティの強さに係ってる.
$\alpha$ が十分小さいと全て諦めるのが最適解になる.

### Auto-tuning $\alpha$

DNN の最終層の出力が
$$a_1, \ldots, a_k, a_{k+1}$$
でこれを softmax して
$$p_1, \ldots, p_k, p_{k+1}$$
にしているとする.

損失関数について次が言える.
$x \in X$ について, 真のラベルを $y=j$, 交差エントロピー $g = - \sum_{i=1}^k t_i \log p_i(x)$ とすると,

$$\begin{align*}
\frac{\partial \mathcal L}{\partial a_{k+1}}
& = p_{k+1} \left[ (1-p_{k+1}) \left[ \log \frac{1}{1 - p_{k+1}} - g \right] + \alpha \right] \\
& = p_{k+1} \left[ (1-p_{k+1}) \left[ \log \frac{p_j}{1 - p_{k+1}} \right] + \alpha \right]
\end{align*}$$

勾配法で最適化するならば,
$\frac{\partial \mathcal L}{\partial a_{k+1}}$ が負のとき, $a_{k+1}$ (と $p_{k+1}$) は増加する.
上の式からその条件は
$$\alpha < - (1-p_{k+1}) \left[ \log \frac{p_j}{1 - p_{k+1}} \right]$$
といえる.
この値が auto-tuning のための基準になる.

最初の $L$ エポックは abstaining なし ($\alpha=\infty$) で学習する.
$L$ エポック目に上の値を基準に $\alpha$ をセットする.

## Lemma 2

固定の $\alpha$ で無限エポック回した時,
abstention rate は $0$ または $1$ に収束する.

ずっと学習を回してると DAC は全部捨てるか全部分類するかしようとしてしまう.

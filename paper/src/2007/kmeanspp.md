% k-means++: The Advantages of Careful Seeding
% http://ilpubs.stanford.edu:8090/778/1/2006-13.pdf
% k-means の改良
% クラスタリング k-means

$$
\def\N{\mathbb{N}}
\def\Pr{\mathop{\mathrm{Pr}}}
$$

## その他の参考文献

- [[https://ja.wikipedia.org/wiki/K-means%2B%2B%E6%B3%95]]

## Intro

k-means 法は
$\phi = \sum \min \|x_i - \mu_j\|^2$
の最小化する割当 $(i \mapsto j)$ を求める問題を考えているが, この最適化問題は NP-hard で現実的には厳密に解けない.
k-means 法が提案している繰り返し最適化は局所解を求める方法に過ぎず, 理論上は最適解と比べていくらでも悪い局所解に陥るケースが知られている.

## k-means

初期の centroid の選び方を工夫する.
各点 $x$ について次の重みを与える.

- For all $x$ について
    - $x$ から見た最近傍 $y$ との距離を $D(x)$ とする
    - $D(x)^2$ を重みとする
- 重みを正規化して
    - $p(x) = \frac{D(x)^2}{\sum_{y \in S} D(y)^2}$ とする

$p$ を確率分布だとして $k$ 個の点をランダムに選ぶ.
これを初期値にして k-means 法を実行する.
$D^2$ weighting と呼んでいる.

## 性能評価

理論的な性能評価がなされている.
最適解と比較して上限はこのくらいという上からの抑え込みがなされてる.
よくわからないのでパス.

## 実験

現実データセットで実験した.
$\phi$ の値も大幅に向上してるだけでなく実行時間も短縮されている.

% X-means: Extending K-means with Efficient Estimation of the Number of Clusters
% http://www.cs.cmu.edu/~dpelleg/download/xmeans.pdf
% クラスタ数を自動的に決定するクラスタリング手法
% クラスタリング k-means

$$
\def\BIC{\mathrm{BIC}}
\def\Pr{\mathop{\mathrm{Pr}}}
$$

## その他の参考文献

- [[https://kaiseh.hatenadiary.org/entry/20090628/1246223266]]

## Intro

K-means アルゴリズムはクラスタ数 $k$ を自分で考えないといけない.
提案手法は BIC (または AIC など) を指標にして再帰的に k-means を適用することで最適なクラスタ数を決定する.

## X-means

### アルゴリズム

- 適当な小さいクラスタ数の k-means を適用
- 以下を繰り返す
    - 各クラスタについて $k=2$ で k-means を適用した場合を考える
        - もっとも BIC (または別の情報量基準) が最高になるものがあれば分割する

### ベイズ情報量規準 (BIC)

- $D$: $p$ 次元空間の点の集合
- $D$ の分割 $D = D_1 \cup D_2 \cup \cdots \cup D_k$
- $\mu_i$: $D_i$ の重心

これについて BIC は次の式で定まる.

$$\BIC = \ell(D) - \frac{p}{2} \log |D|$$

ここで $\ell$ は空間を$p$変量の正規分布を仮定した時の対数尤度である.

$$\ell(D) = \log \prod_{x \in D} P(x)
= \sum_{i=1}^k \sum_{x \in D_i} \left[
- \log ( \sqrt{2 \pi} \sigma ^p )
- \frac{1}{2 \sigma^2} | x - \mu_i |^2 + \log \frac{R_i}{R}
\right]
$$

$\sigma$ は全体の分散
(the variance under the identical spherical Gaussian assumption)
であるが、

$$\sigma^2 = \frac{1}{R - k} \sum_{i=1}^k \sum_{x \in D_i} (x - \mu_i)^2$$

以上が今回の BIC の定義.

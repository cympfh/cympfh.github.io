% x-means法
% http://www.cs.cmu.edu/~dpelleg/download/xmeans.pdf
% 機械学習 クラスタリング

## 参考

- 論文; http://www.cs.cmu.edu/~dpelleg/download/xmeans.pdf
- 記事; [適切なクラスタ数を推定するX-means法 - kaisehのブログ](http://d.hatena.ne.jp/kaiseh/20090628/1246223266)
- さらなる拡張の論文: http://www.rd.dnc.ac.jp/~tunenori/doc/xmeans_euc.pdf
- [kd木 - Wikipedia](http://ja.wikipedia.org/wiki/Kd%E6%9C%A8)

## Intro

k-means法ってゆうクラスタリング手法がある。
これは使う側がクラスタ数 $k$ を決めないといけないために、
曰く、 `it scales poorly computationally` である。

x-means法では再帰的に $2$-means をやっていって、
Bayesian Information Criterion (BIC)
(または Akaike ... (AIC))
といった情報量基準を以って再帰を停止する。
したがって、クラスタ数の推定も同時に行う。

/// 曰く、BICは自然世界に則していて、かつ計算も速いと。

また、論文の実装では、
multiresolution $k$d-tree (k次元木)
を用い、ノードに統計量を持つことで、
全体の計算量を大幅に削減したとある。

## notation

- $p$ 次元点の集合 $D$
- $R = |D|$
- $D$を$\{ D_i \}$に分割する ($i = 1, 2 .. K$)
- $R_i = |D_i|$
- $D_i$ の重心を $\mu_i$ と書く

## ベイズ情報量基準 (BIC)

再帰の停止条件にBICなる情報量基準を用いる。
これは、大きいほどクラスタリング精度が上がっているような量になっている。

$D$ に対してのモデル (分割のしかた) $M$ の
BIC は近似的に次の式で求める。

$$BIC(M) = I(D) - p/2 \cdot \log(R)$$

ここで、説明してないのは $I$であるが、
これは
正規分布を$p$変量の正規分布を仮定した時の
対数尤度である。

$$I(D) = \sum_{x \in D} P(x)
= \sum_{D_i} \sum_{x \in D_i} - \log ( \sqrt{2 \pi} \sigma ^p )
- \frac{1}{2 \sigma^2} | x - \mu_i |^2 + \log \frac{R_i}{R}$$

$\sigma$ は全体の分散
(the variance under the identical spherical Gaussian assumption)
であるが、

$$\sigma^2 = \frac{1}{R - K} \sum_{D_i} \sum_{x \in D_i} (x - \mu_i)^2$$

である。これで計算できることになった。

分割前のBICを持っておいて、分割した後のBICとを比較し、
大きくなるなら、その分割をして、
再帰的に分割を試みる。
そうでないなら分割せずに停める。

つまり、1つのクラスタ$C$があって、それを2-meansで$\{C_1, C_2\}$に分割する。$BIC(\{C\})$と$BIC(\{C_1, C_2\})$との大小を比較する。
分割したら、$C_1$に対して、$BIC(\{C_1\})$を計算する必要がある。

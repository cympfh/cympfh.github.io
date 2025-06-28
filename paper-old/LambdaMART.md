% From RankNet to LambdaRank to LambdaMART: An Overview - Microsoft Research
% https://www.microsoft.com/en-us/research/publication/from-ranknet-to-lambdarank-to-lambdamart-an-overview/#
% 順序学習

## 概要

[RankNet](ranknet.html) というのがあった.
大小比較に関する確率をスコアの差で表現するというやつだった.
それをベースにした LambdaRank があり、さらにそれを決定木にしたのが **LambdaMART** というやつ.
"2010 Yahoo! Learning To Rank Challenge" とかいうやつの 1 位.

## RankNet

アイテム $x_i, x_j$ に対してスコア $s_i, s_j$ を算出する.
この算出する過程を訓練可能なものにする.
このスコアから確率
$$P_{ij} = Pr\left[x_i \succ x_j\right] = \sigma(-k (s_i - s_j))$$
を仮定して学習を行う.
ここで $\sigma$ はシグモイド関数.
[^1] でもオリジナル論文 [^3] でも、シグモイド関数として $\sigma$ を使ってないばかりか、
パラメータ (実数) として $\sigma$ を使っている、のだが個人的に紛らわしいので、シグモイド関数は $\sigma$ とするし、パラメータは $k$ とする.
オリジナル論文ではパラメータなんてものはそもそも無かったと思うけど.

教師信号として、
$\bar{P}_{ij} \in \{ 0, 1/2, 1\}$
を使う.
$x_i \succ x_j$ が与えられてたら
$\bar{P}_{ij} = 1$.
$\bar{P}_{ij} = 1/2 \iff i=j$.
こんな感じで.

損失関数は交差エントロピー.
$$C = - \bar{P_{ij}} \log P_{ij} - (1 - \bar{P_{ij}}) \log (1 - P_{ij})$$

$C$ からスコアまでの勾配を求めると、
$$\frac{\partial C}{\partial s_i}
= k \left( 1 - \bar{P}_{ij} - \sigma( - k (s_i - s_j) ) \right)
= - \frac{\partial C}{\partial s_j}$$

$x_i$ からスコアを算出する機械に関する勾配は、そのパラメータ $w$ に就いて、
$$\delta w
= \eta \frac{\partial C}{\partial w}
= \eta \left[
\frac{\partial C}{\partial s_i} \frac{\partial s_i}{\partial w}
+ \frac{\partial C}{\partial s_j} \frac{\partial s_j}{\partial w}
\right]$$
これで $w \leftarrow w - \delta w$ とかやって更新できる.
ここで $\eta$ は適当な学習係数.

### 学習の高速化

我々は $C$ の値そのものではなく、その勾配に興味がある.

データセットを $I = \{ (i,j) : x_i \succ x_j \}$ というペアの集合だとする.
予め
$\delta w$

データセット $I$ 中の全てのペアについて上の $\delta w$ を求めて $w$ を更新するのは、結局、
予め全てのペアについて
$$\delta w = \eta \sum_{(i,j) \in I}
\left[
\lambda_{ij} \frac{\partial s_i}{\partial w} + \lambda_{ji} \frac{\partial s_j}{\partial w}
\right]$$
という和を計算して使うのと同じ.

ここで、先程の $\frac{\partial C}{\partial s_i}$ を $\lambda_{ij}$ と書いている.
さらに、
$$\lambda_i = \sum_{j, (i,j) \in I} \lambda_{ij} - \sum_{j, (j,i) \in I} \lambda_{ij}$$
とすると、
$$\delta w = \eta \lambda_{i} \frac{\partial s_i}{\partial w}$$
となる.
この等号は分かりにくい.

## LambdaRank

RankNet において

$$\lambda_{ij}
= \frac{\partial C}{\partial s_i}
= k \left( 1 - \bar{P}_{ij} - \sigma( - k (s_i - s_j) ) \right)$$

だったわけだが、これを簡略化して
$$\lambda_{ij} = - k ~ \sigma( - k (s_i - s_j) ) |\Delta Z|$$
としてしまったほうが経験的に良いらしい.
ここで $\Delta Z$ は NDCG (そういう名前のランキングの指標があるらしい [^4]) の変化率.
他にも ERR なりなんなりでも良いらしい [^2].
要するに最終的な評価指標の勾配 (の絶対値) を直接ここに入れてしまう.

これは $(i, j) \in I$ に対して
$$C_{ij} = \log (1 + \exp( - (s_i - s_j) ) ) |\Delta Z|$$
を損失関数にしたときのそれに相当するそう.

これが LambdaRank.

## LambdaMART

LambdaMART は LambdaRank に MART という boosted tree model を組み合わせたものらしい.

### MART

読む

### LambdaMART

読む

## 参考文献

[^1]: [From RankNet to LambdaRank to LambdaMART: An Overview - Microsoft Research](https://www.microsoft.com/en-us/research/publication/from-ranknet-to-lambdarank-to-lambdamart-an-overview/#)
[^2]: [Learning To Rank之LambdaMART的前世今生 - Stay hungry, Stay foolish - CSDN博客](http://blog.csdn.net/huagong_adu/article/details/40710305)
[^3]: [RankNet のオリジナル論文](http://icml.cc/2015/wp-content/uploads/2015/06/icml_ranking.pdf)
[^4]: [予測ランキング評価指標：NDCGの2つの定義と特徴の比較 - 人間だったら考えて](http://szdr.hatenablog.com/entry/2017/02/24/235539)

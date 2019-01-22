% Learning to Rank (RankNet)
% http://icml.cc/2015/wp-content/uploads/2015/06/icml_ranking.pdf
% 順序学習

## ランク学習 (ランキング学習)

点列 $\{x_i\}$ について (全) 順序 $x_i \succ x_j$ を学習及び予測したい.

## RankNet [^1]

RankNet では実関数
$$f : \mathcal{X} \to \mathbb{R}$$
を構成することで
$$f(x_i) > f(x_j) \iff x_i \succ x_j$$
として順序付けを行う.
参考 [^2] では $f(x)$ のことをスコアと読んでる.

スコアは単に大小でランキングを定めるだけでなく確率も定める.
$o_{ij} = f(x_i) - f(x_j)$ として、
$$Pr\left[ x_i \succ x_j \right] = \frac{\exp o_{ij}}{1 + \exp o_{ij}}$$
であるとし、$P_{ij}$ と書く.
所見で気づかなかったが、シグモイド関数と呼んだ方が馴染み深い.
$$P_{ij} = \sigma(o_{ij}) = \frac{1}{1 + \exp (-o_{ij})}$$

$o_{ji} = - o_{ij}$ から $P_{ji} = 1 - P_{ij}$ になってることが確認出来る.

```gnuplot
set xlabel "o"
set grid
set key bottom right
set xrange [-5:5]
plot exp(x) / (1 + exp(x))
```

というわけで、スコアを直接学習するのではなく、確率を学習するものだと思うことにする.
教師信号は実際の大小関係 $(\succ)$ を使って、

$$P_{ij}^* = \begin{cases}
1   & \text{when} ~ x_i \succ x_j \\
0   & \text{when} ~ x_i \prec x_j \\
0.5 & \text{when} ~ x_i=x_j
\end{cases}$$

教師信号でも矢張り $P_{ji}^* = 1 - P_{ij}^*$ が成立するようになっている.

これを使って損失関数は binary cross-entropy を用いる.
$$\mathcal{L} = - P_{ij}^* \log P_{ij} - P_{ji}^* \log P_{ji}$$

$P_{ij}$ の式を頑張って代入すると、
$$\mathcal{L} = - P_{ij}^* o_{ij} + \log \left( 1 + \exp o_{ij} \right)$$

```gnuplot
set xlabel "o"
set grid
set xrange [-5:5]
plot (-x + log(1 + exp(x))) title "L(P^*=1)", (log(1 + exp(x))) title "L(P^*=0)", (-x/2 + log(1 + exp(x))) title"L(P^*=0.5)"
```

### 確率合成

確率が先ほどのようにスコアの差のシグモイドで表現できていると仮定すると、
$P_{ij}, P_{jk}$ から $P_{ik}$ を求める事ができて、

$$P_{ik} = \frac{P_{ij} P_{jk}}{
1 + 2 P_{ij} P_{jk} - P_{ij} - P_{jk}
}$$

## 参考文献

[^1]: [http://icml.cc/2015/wp-content/uploads/2015/06/icml_ranking.pdf](http://icml.cc/2015/wp-content/uploads/2015/06/icml_ranking.pdf)
[^2]: [ニューラルネットワークを用いたランク学習(ChainerによるRankNetの実装) - Qiita](http://qiita.com/sz_dr/items/0e50120318527a928407)

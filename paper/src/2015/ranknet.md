% Learning to Rank using Gradient Descent
% http://icml.cc/2015/wp-content/uploads/2015/06/icml_ranking.pdf
% ニューラルネットワークで順序やランキングを学習するための損失関数の設計
% 順序学習

$$
\def\N{\mathbb{N}}
\def\R{\mathbb{R}}
\def\Normal{\mathcal{N}}
\def\ip#1#2{\langle #1, #2 \rangle}
\def\Pr{\mathop{\mathrm{Pr}}}
$$

## その他の参考文献

- [[https://qiita.com/sz_dr/items/0e50120318527a928407]]

## Intro

点列 $\{x_i\}$ について (全) 順序 $x_i \succ x_j$ を学習及び予測したい.

## RankNet

RankNet では実関数
$$f \colon \mathcal{X} \to \R$$
を上手に構成することで
$$f(x_i) > f(x_j) \iff x_i \succ x_j$$
が成り立つようにし, これによって順序付けを行う.

便宜的にこの $f$ の値のことをスコアと呼ぶ.

スコアは単に量や大小関係を定めるだけでなく、スコアの差を学習することで確率を定めることができる.
$o_{ij} = f(x_i) - f(x_j)$ として,

$$\Pr\left[ x_i \succ x_j \right] = \sigma(o_{ij}) = \frac{\exp o_{ij}}{1 + \exp o_{ij}}$$

であるとする. ここで $\sigma$ はシグモイド関数のこと.
この値を $P_{ij}$ と書くことにする.
$o_{ji} = - o_{ij}$ から $P_{ji} = 1 - P_{ij}$ になってることが確認出来る.

<center>

```@gnuplot
set xlabel "o"
set grid
set key bottom right
set xrange [-5:5]
plot exp(x) / (1 + exp(x))
```

</center>
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

<center>

```@gnuplot
set xlabel "o"
set grid
set xrange [-5:5]
plot (-x + log(1 + exp(x))) title "L(P^*=1)", (log(1 + exp(x))) title "L(P^*=0)", (-x/2 + log(1 + exp(x))) title"L(P^*=0.5)"
```

</center>

### 確率の合成

確率が先ほどのようにスコアの差のシグモイドで表現できていると仮定すると、
$P_{ij}, P_{jk}$ から $P_{ik}$ を求める事ができて、

$$P_{ik} = \frac{P_{ij} P_{jk}}{
1 + 2 P_{ij} P_{jk} - P_{ij} - P_{jk}
}$$

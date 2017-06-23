% Learning to Rank: From Pairwise Approach to Listwise Approach
% http://www.machinelearning.org/proceedings/icml2007/papers/139.pdf
% ランク学習

## 概要

[RankNet](ranknet.html) では $(x_1, x_2) : x_1 \succ x_2$ というペアから学習するのに対して、
この論文が提案する **ListNet** は、純粋にランキング
$$(x_1, x_2, \ldots, x_n) : x_1 \succ x_2 \succ \cdots \succ x_n$$
から学習する.
RankNet が pairwise であると呼ばれるのに ListNet は listwise だと言われる.

## ListNet [^1]

### 置換確率 (permutation probabilities)

オブジェクト (あるいは素性) の列
$$x = (x_1, x_2, \ldots, x_n)$$
が与えられた時に、これの **置換確率** というものを考える.

$$\phi : \mathcal{X} \to \mathbb{R}$$

置換 $\pi$ とは $(1,2,\ldots,n)$ を並び替えてできる列のこと (対称群の元としての置換).

これらについて置換確率
$$P_x(\pi; \phi) = \prod_{j=1}^n \frac{\phi(y_j)}{\sum_{k=j}^n \phi(y_k)}$$
ただし $y$ は $x$ を $\pi$ によって置換してできる列 ($y=\pi(x)$).

### 置換確率の性質

いくつか重要な性質が定理として紹介され論文では証明が載ってる.

<div class=thm>
この $P_x$ は置換群の上の確率に確かになっていて、
$$\sum_{\pi \in \Omega} P_x(\pi ; \phi) = 1$$
</div>

<div class=thm>
列 $x$ が降順 ($x_1 \succ x_2 \succ \cdots \succ x_n$) であって、この順序に関して $\phi$ が単調増加関数であるとき、
$P_x$ は $\pi = (1, 2, \ldots, n)$ のとき最大.

swap sort みたいなことを考えると確かめられる.
</div>

<div class=thm>
$\phi$ が $\phi(ax) = a\phi(x)$ $(a>0)$ を満たす時
(全部定数倍になるだけなので)
$$P_x(\pi; \phi) = P_{\lambda x}(\pi; \phi)$$

全く同様に、

$\phi$ が $\phi(x) = \exp(x)$ のとき、
$\phi(x + a) = \exp(a) \phi(x)$ なので
$$P_x(\pi; \phi) = P_{x + \lambda}(\pi; \phi)$$

が成立する.
</div>

基本的には $\phi$ には線形関数とか指数関数そのものみたいに簡単な関数が来ることを想定してるらしい.

### top $k$ の確率

ランキングの top $k$ についてだけ考えるなら、初めの $k$ 項の積だけ計算すれば周辺確率を計算することになって、
$$P_x^k(\pi; \phi) = \prod_{j=1}^k \frac{\phi(y_j)}{\sum_{k=j}^n \phi(y_k)}$$
となって計算量が削減できる.

ところで softmax 関数は $k=1$ で $\phi = \exp \circ f$ という場合に一致する.

### 学習・予測

というわけで、置換確率を損失関数に入れて、$\phi$ を学習、予測は $\phi(x_i)$ をスコアにしてランキングを作ればよい.

損失関数は具体的にはあらゆる (top $k$ の) 置換での確率を計算してその交差エントロピーを計算する.

- データ列 $x$
- 真のスコア $s(x_i)$
    - 真のランキングを作るようなスコアを与える
        - 参考 [^2] によると、大体適当なスコアで良いらしい
        - というのもスコアそのものを学習するわけではないし、前述したようなスケーラビリティがあるから
    - 真の置換確率 $p(\pi) = P_x(\pi ; s)$
- 学習する $\phi(x_i)$
    - 予測のの置換確率 $q(\pi) = P_x(\pi ; \phi)$
- 損失関数はこの $p, q$ の交差エントロピー
    - $\mathcal{L} = - \sum_{\pi} p(\pi) \log q(\pi)$

## 参考
[^1]: [A Probabilistic Framework for Learning to Rank(final-7).dvi - 139.pdf](http://www.machinelearning.org/proceedings/icml2007/papers/139.pdf)
[^2]: [ランク学習のListNetをChainerで実装してみた - Qiita](http://qiita.com/koreyou/items/a69750696fd0b9d88608)

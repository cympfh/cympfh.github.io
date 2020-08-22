% BPR: Bayesian Personalized Ranking from Implicit Feedback
% https://arxiv.org/ftp/arxiv/papers/1205/1205.2618.pdf
% 推薦システム

## Implicit Feedback

ユーザーにアイテムを推薦するモデルを教師あり学習で構成することを考える.
この学習データとしてユーザーから明示的に与えられるアイテムごとのレーティングを Explicit Feedback というのに対して,
そうでないものを Implicit Feedback という.
例えば購入履歴や視聴履歴である.
これらは明示的にレーティングの量を言っていないし,
仮にポジティブに扱うしかなく, ネガティブデータが与えられない (Pisitive-Unlabeled Data).
仕方がないので, よくある方法としては, 購入してない, 視聴してないアイテムの中からランダムにいくつかサンプリングしてきたものをネガティブとして扱うのが普通 (Negative Sampling).
アイテム空間は普通膨大で, そのほとんどはユーザーにとって興味のないネガティブなものである確率が高いという仮定による.

## Personalized Ranking

ユーザー集合 $U$,
アイテム集合 $I$ に対して,
Implicit Feedback とは $S \subset U \times I$ のこと.

ここで Personalized Ranking は各ユーザー $u \in U$ ごとに $I$ の上の全順序 $<_u$ を定めるタスクを言う.

### notation

- $I_u^+ := \{ i \in I \mid (u,i) \in S\}$
- $I_u^- := I \setminus I_u^+$
- $U_i^+ := \{ u \in U \mid (u,i) \in S\}$
- $U_i^- := U \setminus U_i^+$

さて, 先に述べたように $U \times I$ の内, $S$ を正例とし,
$U \times I$ を擬似的に負例にするのだが, もしこれらに完全にフィッティングさせた場合は,
$S$ へ属するかどうかを判定する機械にしかならない.
そのために正則化を入れるなど汎化性能を担保するテクが必ず必要.

さてランキング（すなわち全順序）を pair-wise に学習することを考える.
ランキングのためのデータセットは次のようになる:
$$D_S = \{ (u, i, j) \mid u \in U, i \in I_u^+, j \in I_u^- \}$$
これはもちろん $i >_u j$ を表している.

### Bayesian Personalized Ranking (BPR)

確率 $P(i >_u j \mid \Theta)$ を尤度にベイズ推定してく.

$$\begin{align*}
P(> \mid \Theta)
& = \prod_u P(>_u \mid \Theta) \\
& = \prod_u
    \left[ \prod_{(i,j) \in I_u^+} P(i >_u j \mid \Theta)
        \times \prod_{(i,j) \in I_u^-} \left( 1 - P(i >_u j \mid \Theta) \right)
    \right] \\
& = \prod_{(u,i,j) \in D_s} P(i >_u j \mid \Theta) ~~~~~~~~\cdots(\text{!}) \\
P(\Theta \mid >) & \propto P(> \mid \Theta) P(\Theta)
\end{align*}$$

(!) のところは $D_s$ が性質の良い部分集合であることを仮定してる気がする.
少なくとも近似だと思う.

シグモイド関数 $\sigma$ を用いると確率は適当な値 $x$ を以て,
$$P(i >_u j \mid \Theta) = \sigma\left(x_u^{ij}(\Theta)\right)$$
と表せる.
この $x$ を推定することにする.
これを入れて, さっきの式の対数をとると,
$$O := \log P(\Theta \mid >) = \sum_{(u,i,j) \in D_s} \log \sigma(x_u^{ij}) + \log P(\Theta)$$
これを最大化する $\Theta$ を探索すればよい.

### BPR Learning

さっきの $O$ を微分して勾配法をする.

$$\begin{align*}
\frac{\partial O}{\partial \Theta}
& = \sum_{(u,i,j) \in D_s} \frac{\partial}{\partial \Theta} \log \sigma(x_u^{ij}) + \frac{\partial}{\partial \Theta} \log P(\Theta) \\
& = \sum_{(u,i,j) \in D_s} (\sigma(x_u^{ij}) - 1) \frac{\partial x_u^{ij}(\Theta)}{\partial \Theta} + \frac{\partial}{\partial \Theta} \log P(\Theta) \\
\end{align*}$$

ここで, 最後の $+ \log P(\Theta)$ 及びその微分 $+\frac{\partial}{\partial \Theta} \log P(\Theta)$ はいわゆる罰則化項に対応している.
ここは具体的に与えることは出来ないので, 例えば適当に $\log P(\Theta) = - \lambda \| \Theta \|^2$ などとして計算する.

## 行列分解への適用

$x$ に関して次のようにモデル化をする.

- $x_u^{ij} := x_u^i - x_u^j$
- $x_u^i := w_{uk} h^{ki}$
    - ここで $w_u, h^i$ はそれぞれ同じ長さの実ベクトルで, これの内積を取っている

$w_{uk}, h^{ki}$ は全体としては二次元ベクトルで, 行列 $W, H$ によって与えることが出来る.
モデルのパラメータはこれが全てなので,
$$\Theta = (W, H)$$
としてよい.

勾配を計算するのに
$\frac{\partial x_u^{ij}}{\partial \Theta}$
が必要だが, これは

$$\begin{cases}
\frac{\partial x_u^{ij}}{\partial \Theta} = \frac{\partial x_u^i}{\partial \Theta} - \frac{\partial x_u^i}{\partial \Theta} \\
\frac{\partial x_u^i}{\partial w_{uk}} = h^{ki} \\
\frac{\partial x_u^i}{\partial h^{ki}} = w_{uk} \\
\end{cases}$$

これだけ.


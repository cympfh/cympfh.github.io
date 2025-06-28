% [1205.2618] BPR: Bayesian Personalized Ranking from Implicit Feedback
% https://arxiv.org/abs/1205.2618
% 暗黙的な正フィードバックからランキング学習で推薦システムを構築
% 推薦 行列分解

$$
\def\N{\mathbb{N}}
\def\R#1{\mathbb{R}^{#1}}
\def\Normal{\mathcal{N}}
\def\ip#1#2{\langle #1, #2 \rangle}
\def\Pr{\mathop{\mathrm{Pr}}}
$$

## Intro

ユーザー対アイテムの推薦モデルを構築する.
学習データとして暗黙的 (implicit) な positive feedback だけが使える状況を考える.
例えばユーザーの購入履歴や視聴履歴などである.

このような状況で学習するために提案される BPR 含めてよく使われる手法はネガティブサンプリングである.
つまり, ユーザーがインタラクトしてないアイテムの大半は真にネガティブであることを仮定し, ここからランダムサンプリングしてきたものを負例として扱う.

提案される BPR はランキング学習である.
つまりアイテムの適合度スコアを直接学習せず,
代わりにスコアの大小関係を目的に学習する.

## Personalized Ranking

ユーザー集合 $U$, アイテム集合 $I$ があり,
有限のサンプル $S \subset U \times I$ が与えられる.
これが Implicit feedback.

ここで Personalized Ranking とは,
ユーザー $u$ ごとの大小関係 $\gt_u$ のことを言う.
ここで $\gt_u$ は $I \times I$ 上の
[全順序](https://ja.wikipedia.org/wiki/%E5%85%A8%E9%A0%86%E5%BA%8F)
を言っている.

> 暗にスコアが実数で与えられ, その大小で比較することになる.
> ただし大小だけが問題であって実数に意味はない.

$S$ から次を定める.

- $I_u^+ := \{ i \in I \mid (u, i) \in S \}$
    - ユーザー $u$ がインタラクトしたアイテム
- $I_u^- := S \setminus I_u^+$
    - ユーザー $u$ がインタラクトしていないアイテム

ランキング学習のためのデータセットは次の三組の集合

$$D = \{ (u, i, j) \mid u \in U, i \in I_u^+, j \in I_u^- \}$$

ただし $i$ に対しての $j$ の選び方はいくつか考えられる.
一旦は一様ランダムに選ぶものとしておく.
$$(u,i,j) \in D \implies i \gt_u j$$
だとして学習を進めていく.

### Bayesian Personalized Ranking (BPR)

確率 $\Pr(i \gt_u j \mid \Theta)$ を尤度にベイズ推定していく.

$$\begin{align*}
\Pr(D \mid \Theta)
&= \prod_u \Pr(\gt_u \mid \Theta) \\
&= \prod_{(u,i,j) \in D} \Pr(i \gt_u j \mid \Theta) \\
\end{align*}$$

$$\begin{align*}
\Pr(\Theta \mid D)
&\propto \Pr(D \mid \Theta) \Pr(\Theta) \\
&= \prod_{(u,i,j) \in D} \Pr(i \gt_u j \mid \Theta) \Pr(\Theta) \\
\end{align*}$$

最後の値の対数尤度（のマイナス）を取る.

$$\mathcal{L} = - \sum_{(u,i,j) \in D} \log \Pr(i \gt_u j \mid \Theta) - \log \Pr(\Theta)$$

ここである実数 $x_u^{ij}$ があって,
$\Pr(i \gt_u j \mid \Theta) = \sigma(x_u^{ij})$
と書けることにする.
略記してるが本当は $x$ はパラメータ $\Theta$ に依存する関数.
ここで $\sigma$ はシグモイド関数.
これを代入したら

$$\mathcal{L} = - \sum_{(u,i,j) \in D} \log \sigma(x_u^{ij}) - \log \Pr(\Theta)$$

を得る.
これを最小化する $\Theta$ を求めれば良い.

$\Pr(\Theta)$ は正則化項だと思える.
勝手に $\Theta \sim \Normal(0, \lambda I)$ を仮定すると
$\log \Pr(\Theta) = - \lambda \|\Theta\|^2$
というよくある自乗正則化項が得られる.
これを採用して,

$$\mathcal{L} = - \sum_{(u,i,j) \in D} \log \sigma(x_u^{ij}) + \lambda \|\Theta\|^2$$

とすると扱いやすい.

### 行列分解モデル (BPR-MF)

では $x$ をどうやってモデル化するかを考える.

$$x_u^{ij} = x_u^i - x_u^j$$

だとする.
結局ユーザー対アイテムの適合度 $x_u^i$ を暗に持つことになる.
$x_u^i$ を持つとはつまり行列 $X \in \R{U \times I}$ を持つということになる.
行列 $X$ を予測すると言えば行列分解だ.

$$X \approx WH^t$$

ここで $W \in \R{U \times k}$, $H \in \R{k \times I}$.
$k$ は潜在次元数 $(k \ll U, k \ll I)$.

$x_u^i$ は内積 $\ip{w_u}{h_i}$ で与えられる.
もちろん一般のカーネルに置き換えても良い.

というわけで $\Theta = (W, H)$ として $\mathcal L$ の最適化問題を解けば行列分解モデルの BPR を学習したことになる.

### kNN モデル (BPR-kNN)

行列分解以外のモデルも考案されている.

ユーザー $u$ の未知アイテム $i$ への適合度は,
その人が過去にインタラクトした他のアイテム,
つまり $I_u^+$ の中で $i$ と良く似たアイテムがどれだけ近いものがあるかで決まると思える.

対称行列 $C \in \R{I \times I}$ を考える.
$C_{ij}$ はアイテム $i$ と $j$ の類似度を表す.

$$x_u^i = \sum_{i\ne j, j \in I_u^+} C_{ij}$$

この $C$ を BPR で最適化するのが BPR-kNN である.

追加で2つアプローチのヒントが書いてある.

$C$ として次は初期値のヒューリスティックとして良さそう

- $c_{ij} = \frac{|U_i^+ \cap U_j^+|}{\sqrt{|U_i^+| \cdot |U_j^+|}}$
    - ここで $U_i^+ = \{ u \in U \mid (u,i) \in S \}$.

汎化のために $H \in \R{I \times k}$ をパラメータ $\Theta$ だとして
$$C = H H^t$$
として使う.

> どこが kNN なの？

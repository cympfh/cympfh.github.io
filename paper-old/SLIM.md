% SLIM: Sparse Linear Methods for Top-N Recommender Systems
% http://glaros.dtc.umn.edu/gkhome/node/774
% 推薦システム 行列分解

## 概要
行列分解と同じようなことを疎な線形回帰でやる.
行列分解よりも精度良く計算の効率がいい.

## 手法
行がユーザー、列がアイテムな疎行列 $A \in \mathbb R^{|U| \times |V|}$ があるとき,
ある疎行列 $W \in \mathbb R^{|V| \times |V|}$ として
$$\tilde{A} = A W$$
で未観測の値を予測する.

すなわち, ユーザー $i$ アイテム $j$ に関する値を
$$\tilde{a}_i^j = a_i w^j$$
で予測する.

### 学習

学習はアイテムごとに行う.
$A$ の $j$ 番目の行ベクトル $a^j$ を取り出して, これをさっきの $\tilde{a}$ だと思って
$$\min \| a^j - A w^j \|^2$$
をする.

実際にはこれに罰則化のためのL2ノルム, L1ノルムを加える.
この罰則化自体が $W$ を疎にするのに役立つらしい.

また $A^j$ を見れば答えの $\tilde{a}^j = a^j$ が入っていて $W=I$ という自明解があるので,
対角成分はゼロ ($w_j^j = 0$) という制約を設ける.

さらに加えて $w_i^j \geq A 0$ ともする（これはなぜ？）.

結局次のような最適化問題

- $\min \| A - AW \|_F^2 + \lambda_1 \| W \|_F^2 + \lambda_2 \|W\|_1$
- such that
    - $W \geq 0, W_j^j = 0$


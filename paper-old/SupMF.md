% [1603.05572] Supervised Matrix Factorization for Cross-Modality Hashing
% https://arxiv.org/abs/1603.05572
% 行列分解

## Abstract

Supervised Matrix Factorization Hashing; SMFH を提案する.
これは非負行列分解をクロスモーダルな問題に適用する.

## Non-negative Matrix Factorization; NMF

非負値だけを取り扱う

- $X = [x_1, \ldots, x_N] \in \mathbb R^{d \times N}$
    - $N$ はサンプル数
    - $d$ は特徴量次元

について2つの行列 $U,Y$ の積で近似する.

- $X \simeq UY$

ここで

- $U = [u_1,\ldots,u_r] \in \mathbb R^{d \times r}$
- $Y = [u_1,\ldots,v_N] \in \mathbb R^{r \times N}$

これらもやはり非負値を取ることにする.

近似 $\simeq$ の意味は次のフロベニウス距離の最小化で表現する.

- $\min_{U,Y} \| X-YU \|_F^2$

## クロスモーダル

2つの異なるモーダルで $X^1, X^2$ があるからそれぞれ行列分解したい.
ここで $Y$ だけ共有させたい.
すなわち

- $X^1 \simeq U^1 Y$
- $X^2 \simeq U^2 Y$

次の目的関数を設定する.

- $\min \sum_t \lambda_t \| X^t - U^t Y \|_F^2$

この論文では特に $Y$ が $Y \in \{0,1\}^{r \times N}$ な binary code であるとして
これをサンプル $i \in N$ のハッシュとして利用したいそうだ.
なのでここでは行列分解のことをハッシュ関数だと思ってる.

## Supervised Hash Function

一つのサンプルが今2つのモダリティを持っていてそれぞれを
$x^1,x^2$
とする.
一つのサンプルは $e=(x^1,x^2)$.
ハッシュ関数 $\ell$ はこれを binary code に映す.

- $\ell \colon X^1 \times X^2 \to \{0,1\}^r$
- $\ell \colon e \mapsto y$

さてこれを教師付きでやりたい.
それはすなわち, 2つの $e_i, e_j$ については $\ell(e_i)=\ell(e_j)$ であるようにしたいといったこと.

ハッシュどうしの距離としてハミング距離とする.
内積の大小が距離の大小の逆になる.

類似度の行列

- $A_{ij} = \ell(e_i)^T \cdot \ell(e_j)$

この行列を教師として与えることにしてやる.

$Y$ の列ベクトル $Y_i, Y_j$ の距離が $A_{i,j}$ になっているはずだから,

- $\min_Y \sum_{i,j} \| Y_i - Y_j \|^2 A_{i,j}$

を考える. $A$ を重みにして $Y$ を近づける.

> 自明な解として $Y=0$ があるのだが, 気にしないらしい.
> 次の行列分解に関する目的関数も含ませるのでそれで良いのとむやみに大きな値を持たせないようにする罰則項を兼ねてるのかも.

行列分解が出来ることにもして, 適当な重み $\alpha$ を持たせて

- $\min_Y \min_{U^1,U^2} \sum_t \lambda_t \| X^t - U^t Y \|_F^2 + \alpha \sum_{i,j} \| Y_i - Y_j \|^2 A_{i,j}$

これが最終的な目標関数.

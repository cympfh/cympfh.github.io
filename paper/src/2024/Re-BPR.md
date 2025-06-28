% [2409.14217] Revisiting BPR: A Replicability Study of a Common Recommender System Baseline
% https://arxiv.org/abs/2409.14217
% BPR は本当はめちゃ強いぞ
% 推薦 行列分解

$$
\def\N{\mathbb{N}}
\def\R#1{\mathbb{R}^{#1}}
\def\Normal{\mathcal{N}}
\def\ip#1#2{\langle #1, #2 \rangle}
\def\Pr{\mathop{\mathrm{Pr}}}
$$

## Intro

Bayesian Personalized Ranking
([BPR](../2012/BPR.html) の BPR-MF のこと)
は新しい推薦システムを提案する際にほぼ必ずベンチマークとして登場する.
その際にオープンソースなライブラリ実装が使われるが,
その実装は BPR の原論文の実装とは異なることが多い.
最悪なケースで 50% 以上本来の BPR よりも悪い性能を示すことがある.

適切なライブラリを選べ.
[cornac](https://cornac.preferred.ai) を使え.

## BPR の概要

- ユーザー集合 $U$, アイテム集合 $I$
    - $I_u^+$: ユーザー $u$ がインタラクトしたアイテム
    - $I_u^-$: ユーザー $u$ がインタラクトしていないアイテム
- データセット
    - $D = \{ (u, i, j) \mid u \in U, i \in I_u^+, j \in I_u^- \}$
- 適合度
    - $X \in \R{U \times I}$
- 予測モデル
    - $X \simeq W H^t$
    - $\Pr(i \gt_u j \mid W, H) = \sigma(x_u^i - x_u^j)$
        - $x_u^i = \ip{w_u}{h_i}$
        - $x_u^j = \ip{w_u}{h_j}$
- 学習
    - $\mathcal L(W,H) = -\sum_{(u,i,j) \in D} \log \Pr(i \gt_u j \mid W, H) + \Omega(W,H)$
        - $\Omega(W,H)$: 正則化項

## BPR の気にするべきオプション

### 正則化項

$(u,i,j) \in D$ に対して
$$\lambda_u \|w_u\|^2 + \lambda_i \|h_i\|^2 + \lambda_j \|h_j\|^2$$
という正則化項が使える.
ここで重み $\lambda$ として, ユーザーに使うもの, ポジティブアイテムに使うもの, ネガティブアイテムに使うものをそれぞれ別に持つことが出来る.

> 元論文で既にこの3つがあると言われてるでしょ, と書いてあるが,
> どこに書いてあるのか分からなかった.
> $\lambda_\Theta$ という1つになってるようにしか見えないんだが.

ライブラリによって $\lambda$ は一種類だったりする.

### 最適化

元論文では普通の SGD で学習している.
現代なら他に Momentum SGD や Adam などがある.

### ネガティブサンプリング

一様ランダムに選ぶだけでなく,
その時点で最も予測を外してしまうアイテムを選んでネガティブサンプルとして使うという adaptive sampling が考えられる.
通常こちらの方が良い.

> これも元論文にあると書いてあるけど, どこ？
> "bootstrap sampling" というのはあるけど, これのことか？

### アイテム/ユーザーのバイアス

内積 $\ip{w_u}{h_i}$ にバイアス項を加えて
$$\ip{w_u}{h_i} + b_u + b_i$$
とすることが考えられる.

アイテムのバイアス項は有用.
ユーザーのバイアス項は不要.

## 実験

上記したオプションをフルに実装した彼ら独自のものと, 有名どころのライブラリを比較した.
各ライブラリの実装は Table 2 にまとめてある.
フルに実装されてるものはオリジナルも含めて全く存在しない.

いくつかのデータセットで実験しなおした.
彼らの実装及び cornac がいつも同率一位.

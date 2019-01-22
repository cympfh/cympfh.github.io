% [1901.00056] SynonymNet: Multi-context Bilateral Matching for Entity Synonyms
% https://arxiv.org/abs/1901.00056
% 自然言語処理 類似度学習

## 概要

2つの entity (語句?) が与えられた時にそれらがシノニムかどうかを判定する.
Siamese Network 的に訓練/予測で対で比較させる.

## SynonymNet

![](https://i.imgur.com/k3vGP6u.png)

### Context Retriever

entity $e$ について獲得できるコンテキストの集合
$$C = \{ c_0, \ldots, c_P \}$$
を集める.
各コンテキスト $c_p$ は単語の列
$$c_p = ( w_p^0,\ldots,w_p^T )$$

### Confluence Context Encoder

各コンテキスト $c_p$ を BiLSTM で読ませて特徴ベクトル $h_p$ を得る.
コンテキストの集合 $C$ から $H = \{h_1,\ldots,h_P\}$ を得る.

ある自然数 $d$ によって $h_p \in \mathbb R^d$ だとする.

### Bilateral Matching with Leaky Unit

エンティティ $e$ については $H = \{h_1,\ldots,h_P\}$ が,
別なエンティティ $k$ については $G = \{g_1,\ldots,g_Q\}$ が Confluence Context Encoder によって得られたとする.

このときに双方向的にマッチングをしたい.

$H \to G$ マッチング:
各 $h_p \in H, g_q \in G$ について
$$m_{p \to q} = \dfrac{\exp(h_p W g_q^\top)}{\sum_{p'}\exp(h_{p'} W g_q^\top)}$$

$W$ は $\mathbb R^{d \times d}$ なる重み行列.
この $W$ 故にこの $m$ は非対称.

$H \leftarrow G$ マッチング:
$$m_{p \leftarrow q} = \dfrac{\exp(g_q W h_p^\top)}{\sum_{q'}\exp(g_{q'} W h_p^\top)}$$

これらの2種類の $m$ は要するに $HWG^\top$ の softmax として得られる.

さらに一部の context は uninformative であるから, leaky unit に掛ける.
これは $l \in \mathbb R^{1 \times d}$ によって (簡単のためにゼロベクトルに固定する),

$$m_{l \to q} = \dfrac{\exp(l W g_q^\top)}{\exp(l W g_q^\top) + \sum_{p'}\exp(h_{p'} W g_q^\top)}$$

とする. つまり softmax にもう1クラスを追加したもの.
さっきの $m_{p \to q}$ も次のように修正する.

$$m_{p \to q} = \dfrac{\exp(h_p W g_q^\top)}{\exp(l W g_q^\top) + \sum_{p'}\exp(h_{p'} W g_q^\top)}$$

### Context Aggregation

$H$ を畳み込む.

- $a_p = \max \{ m_{p \leftarrow q} \mid q \in Q \}$
- $a_q = \max \{ m_{p \to q} \mid p \in P \}$

を重みにして,

- $\bar{h} = \sum_p a_p h_p$
- $\bar{g} = \sum_q a_q g_q$

> 実質 Attention?

### Training

Siamese または Triplet 的に学習する.

#### Siamese 方式 (Pairwise)

入力のエンティティ $e,k$ がシノニムである場合とでない場合のための損失関数をそれぞれ次のようにする.

- $L_+(e,k) = \dfrac{1}{4} \left( 1 - s(\bar{h} - \bar{g}) \right)^2$
- $L_-(e,k) = \left( [ s(\bar{h} - \bar{g}) ]^+ \right)^2$

ここで $s$ は適当な類似度関数.
また $[ \cdot ]^+ = \max(0, \cdot)$.

全体としては $y \in \{0,1\}$ として
$$\mathcal L_s = y L_+ + (1-y) L_-$$
とする.

#### Triplet 方式

エンティティ $e$ とそれとシノニムである $k_+$ と, でない $k_-$ とを用意して,
それらから $\bar{h}, \bar{g}_-, \bar{g}_+$ が得られた時,
$$\mathcal L_t = [ s(\bar{h}, \bar{g}_-) - s(\bar{h}, \bar{g}_+) + m ]^+$$
とする.

### Inference

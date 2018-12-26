% [1809.00946] Twin-GAN -- Unpaired Cross-Domain Image Translation with Weight-Sharing GANs
% https://arxiv.org/abs/1809.00946
% 画像生成

変数は極力, 一文字にして (添字は長かったりするけど),
関数適用のカッコは積極的に省略する.
例えば, $DGEx$ は $D(G(E(x)))$ のこと.

## リンク

- [arxiv:1809.00946](https://arxiv.org/abs/1809.00946)
- [github:jerryli27/TwinGAN](https://github.com/jerryli27/TwinGAN)
- [ブログ](https://github.com/jerryli27/TwinGAN/blob/master/docs/blog/blog_EN.md)

## 概要

GANによるきれいな画像生成をしたい.
異なるドメインへの変換 (例えばアニメ絵と写真との間の変換) が出来るようになる.

手法は CycleGAN の応用.
また
[Progressive Growing of GANs (PGGAN)](https://arxiv.org/abs/1710.10196)
の手法も用いてる.

## 手法

対応付もされていない2つのドメイン (画像データ集合) $X_1$ と $X_2$ を用意する.
TwinGAN の目標はドメイン間の相互の変換 $F_{12}$ と $F_{21}$ とを用意することで,
$F_{12}(x_1)$ がドメイン 2 の画像になって $F_{21}(x_2)$ がドメイン 1 の画像になるようにさせること.
より詳細にはドメインごとのエンコーダ $E_1, E_2$,
ジェネレータ $G_1, G_2$ 及び判別機 $D_1, D_2$ を用意してやって,
変換を $F_{12} = G_2 \circ E_1$, $F_{21} = G_1 \circ E_2$ と定める.

### アーキテクチャ

1. Progressive GAN
1. Encoder and UNet
1. Domain-adaptive Batch Renormalization

### 学習

画像集合 $X_1, X_2$ があるとき, 以下を定義する.

- $X_i \subset \mathrm{Images}$ (適切にサイズの揃った画像データ)
- $E_i \colon \mathrm{Images} \to \mathbb R^m$ (または $X_i$ に制限)
- $G_i \colon \mathbb R^m \to \mathrm{Images}$
- $D_i \colon \mathrm{Images} \to \{0,1\}$

<figure>
<img src="https://i.imgur.com/8e3Shfp.png" width="80%" />
<figcaption>githubから引用</figcaption>
</figure>

$i, j \in \{1,2\}$ についてドメイン $i$ からドメイン $j$ への変換を考える.

#### GAN Loss

以下がまず普通の GAN.

$$L_{\text{VANILLA}}^{i \to j} = \mathbb{E}_{x_j \sim X_j} \log D_j(x_j) + \mathbb{E}_{x_i \sim X_i} \left[ \log ( 1 - D_jG_jE_ix_i ) \right]$$

安定性の為に DRAGAN の方法を真似て以下の正則項を付け足す.

$$L_{\text{DRAGAN}}^j = \lambda \mathbb{E}_{x_j \sim X_j, \delta \sim N(0,cI)} \| \Delta_x D_j(x + \delta) \| - k$$

$\Delta_x$ は微分作用素.
$D$ に対する正則項として機能する (ちょうど傾き $k/\lambda$ くらいの関数になるようにしてる).

GAN としてのロスは $i,j$ について4通りの上のロスの和.

$$L_{\text{GAN}} = \sum_i \sum_j \left[ L_{\text{VANILLA}}^{i \to j} + L_{\text{DRAGAN}}^j \right]$$

#### Cycle Consistency Loss

以下を加える.
すなわちエンコーダとジェネレータだけを合成したら autoencoder になってるようにする.
ただし $L_1$ は L1 ロス ($L_1(x,y) = \|x-y\|_1$).

$$L_{\text{cyc}}(E,G) = \mathbb{E}_{x_1} L_1(x_1, G_1 E_1 x_1) + \mathbb{E}_{x_2} L_1(x_2, G_2 E_2 x_2)$$

#### Semantiv Consistency Loss

エンコーダの出力は画像の意味的表現になってること.
そしてその意味はドメインにかかわらず比較可能であること.

$$L_{\text{sem}}(E,G) = \mathbb{E}_{x_1} L_1(E_1x_1, E_2G_2E_1x_1) + \mathbb{E}_{x_2} L_1(E_2x_2, E_1G_1E_2x_2)$$

つまり $E_i \circ G_i = \mathrm{id}$ であることを要請する.

#### Overall Loss

以上を全部足して TwinGAN のロスとする:
$$\mathcal L = \lambda_1 L_{\text{GAN}} + \lambda_2 L_{\text{cyc}} + \lambda_3 L_{\text{sem}}$$
これを普通の GAN のように $D$ については $\max$ を取らせて $E,G$ については $\min$ を取らせる.

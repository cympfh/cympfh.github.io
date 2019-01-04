% [1807.06358] IntroVAE: Introspective Variational Autoencoders for Photographic Image Synthesis
% https://arxiv.org/abs/1807.06358
% 深層学習 オートエンコーダ 生成モデル VAE

$\require{AMScd}$
$\def\KL{D_{\text{KL}}}$

関数適用の括弧は極力省略する.

## 概要

VAE を introspective にやる.

## IntroVAE

### VAE

VAE を思い出すと,

$$\begin{CD}
X @>q_\phi>> Z @>p_\theta>> X
\end{CD}$$

encoder 部分を確率分布 $q_\phi(z|x)$,
decoder 部分を確率分布 $p_\theta(x|z)$ とし,
損失関数は

- $L_{\text{AE}} = - \mathbb{E}_{z \sim q_\phi} p_\theta(x|z)$
- $L_{\text{REG}} = \KL(q_\phi(z|x) \| p(z))$

の和.
$p(z)$ は予め (普通正規分布に) 決めておく.

### Adversarial distribution matching

VAE に GAN を足す.

実際のデータ $x$ と,
$p(z)$ からサンプリングした $z'$ を元に生成した $x'$ とで GAN をする.

- generator $G \colon Z \to X$
- inference model $E \colon X \to \mathbb R$
    - $E(x) = \KL(q_\phi(z|x) \| p(z))$

を用いて以下の損失関数を設計する:

- $L_E(x,z) = E(x) + \left[ m - EGz \right]^+$
    - $\left[ \cdot \right]^+ = \max \{ 0, \cdot \}$
- $L_G(z) = EGz$

$L_E$ の 1 項目はさっきの $L_{\text{REG}}$ で, 2 項目は生成するデータの分布が真の分布と $m$ 以下しか離れてないようにするもの.
ここで $m$ は正の定数.

GAN の方式で従って
$$\min_E \mathbb{E}_{x \sim p(x), z \sim p(z)} L_E(x,z)$$
$$\min_G \mathbb{E}_{z \sim p(z)} L_G(z)$$
によってそれぞれを訓練する.

#### Theorem 1

ナッシュ均衡に達した時点の $(E,G)$ を $(E^*, G^*)$ とする.
また $\forall x \in X, p(x) > 0$ とする.
このとき,
$$p(x) = p(G^*(z))$$
$$E^*(x) = \gamma; \gamma \in [0,m], \text{fixed}$$

### Introspective variational inference

以下のように修正する:

- $L_E(x,z) = E(x) + \left[ m - EGz \right]^+ + L_{\text{AE}}(x)$
- $L_G(z) = EGz + L_{\text{AE}}(x)$

AE で罰金項だったのが Discriminator になってる.

![](https://i.imgur.com/sxkwju9.png)

## Results

![](https://i.imgur.com/ozHK9Rp.png)


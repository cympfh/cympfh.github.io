% [1912.11160] RecVAE: a New Variational Autoencoder for Top-N Recommendations with Implicit Feedback
% https://arxiv.org/abs/1912.11160
% 推薦システム 深層学習

## 流れ

1. Matrix Factorization
2. Collaborative Denoising AutoEncoder (CDAE)
3. Multinomial Variational Auto-Encoder (Mult-VAE)
4. RecVAE

## Background

### CDAE

入力にノイズを乗せてこれを denoising してくれるような AutoEncoder を作る.
ノイズとしては入力の一部をランダムにゼロにする（つまり Dropout?）.

ユーザーのインタラクション履歴を表現するベクトル
$y$
について,
これの一部をランダムにゼロにした
$\tilde{y}$
を作る.
一層ずつの Encoder/Decoder で $\tilde{y} \mapsto y$ な AutoEncoder を作る.

### Mult-VAE

VAE でやる (ELBO).
$$\mathcal{L} = \mathbb{E}_{q(z)} \left[ \log p(x \mid z) - \mathrm{KL}\left( q(z \mid x) \| p(z) \right) \right]$$

観測データ $x$ に対して, これを潜在ベクトル $z$ から生成される確率 $p(x \mid z)$.
事前分布 $p(z)$.
潜在ベクトルに逆生成する確率を近似した $q(z \mid x)$.

ある意味この KL は罰則項になってる.
$beta$-VAE のやり方ではここを和らげるために, $\beta$ 倍した KL を使う.
$$\mathcal{L} = \mathbb{E}_{q(z)} \left[ \log p(x \mid z) - \beta \mathrm{KL}\left( q(z \mid x) \| p(z) \right) \right]$$
この $\beta$ は $0$ からスタートして学習過程で徐々に上げて, ちょうどいい $beta$ で止めるというやり方が良いらしい.

さて多項分布でいく.

ユーザー $u$ の潜在ベクトル $z \in \mathbb R^k$.
生成モデル $f_\theta \colon \mathbb R^k \to \mathbb R^I$.
ここで $I$ はアイテム空間.
ユーザーのインタラクションが $n$ 個あるとする.

次の分布を仮定する.

- $z \sim \mathcal{N}(0, I)$
- $\pi(z) = \mathrm{softmax}(f_\theta(z))$
- $x \sim \mathrm{Mult}(n, \pi(z))$

とすると,
$$\log p(x \mid z) = \log \mathrm{Mult(x \mid n,\pi(z))} = \sum_i x_i \log p_i + C$$

## RecVAE

Mult-VAE の改良.

![](https://i.imgur.com/rjXjabi.png)

### Composite prior

$p(z \mid x)$ の見積もり.
VAE なら $q(z \mid x)$ にするが,
強化学習で forgetting と呼ばれる学習が不安定になる現象が起こる.
この安定化のために一定度合い矯正させるように
$$p(z \mid x) = \alpha \mathcal{N}(z \mid 0,I) + (1-\alpha) q(z \mid x)$$
というブレンドを使う.

### Rescaling KL

MultVAE なんかでは $\beta$ をゼロから上げてくテクニックが重要だと言われた.
RecVAE ではこの現象は特にミられず, 固定で良かった.
それよりも良い方法を提案する.

各ユーザー $u$ について,
$$\beta_u = \gamma \sum_i x_{ui}$$
という, つまりインタラクションした個数に比例させるやり方が良かった.

### Alternating Training

Encoder (Embedding) 側と, Decoder (Generate) 側は互いに一方を固定し,
交互に学習させるのがよい.
行列分解の Alternating least squares (ALS) と同様.

## 実験

Accuracy 評価で強い.
データセットによっては EASE がもっと強い.

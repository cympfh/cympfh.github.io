% [1912.11160] RecVAE: a New Variational Autoencoder for Top-N Recommendations with Implicit Feedback
% https://arxiv.org/abs/1912.11160
% 推薦システム 深層学習

## 流れ

1. Matrix Factorization
2. Collaborative Denoising AutoEncoder (CDAE)
3. Multinomial Variational Auto-Encoder (Mult-VAE)
4. RecVAE

## CDAE

入力にノイズを乗せてこれを denoising してくれるような AutoEncoder を作る.
ノイズとしては入力の一部をランダムにゼロにする（つまり Dropout?）.

## Mult-VAE

推薦モデルにおける生成モデルとは,
適当な $k$ 次元製剤ベクトル $\mathbb R^k$ からアイテム集合 $I$ に対応するベクトル $\mathbb R^I$ への変換のこと.
$$f_\theta \colon \mathbb R^k \to \mathbb R^I$$

## 手法

ディープに VAE をやる.
Mult-VAE の改良.


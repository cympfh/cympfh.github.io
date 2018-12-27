% [1810.06640] Adversarial Text Generation Without Reinforcement Learning (LaTextGAN)
% https://arxiv.org/abs/1810.06640
% 自然言語生成 オートエンコーダ 生成モデル

## 概要

low-dimentional representation of sentences を学習してくれるような autoencoder を作る.
GAN によって分散表現を自然な文に decode する.

## LaTextGAN

### Architecture

![](https://i.imgur.com/uEj2x9p.png)

Stage 1 が autoencoder で Stage 2 が GAN.

autoencoder は単語単位でLSTMで読ませる.
decode 部分も LSTM で出力する. 各 time-step で確率最大の単語を選ぶ.

GAN部分は全結合層で全部構成するがResNetを取り入れてる.

### Training

Improved Wasserstein GAN を使う.
generator は $g : \mathbb R^m \to \mathbb R^n$,
discriminator は $f_w : \mathbb R^n \to \mathbb R$ として次を目的関数にする:
$$\max \mathbb{E}_z f_w(g(z)) - \mathbb{E}_x f_w(x)$$

> GANの機構から Discriminator は普通に真の文かどうかを判定してくれ,
> Encoder は Decode しやすく Discriminator にも分かってくれるようなエンコードをしてくれる.
> Discriminator に分かってくれることは文の空間が密になってくれることに効くのかも??

### Results

![](https://i.imgur.com/o8M5UIT.png)

> うーん.
> まだまだだ.
> GAN がどう効いてくるのかも不明.


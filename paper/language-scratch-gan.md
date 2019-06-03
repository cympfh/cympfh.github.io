% [1905.09922] Training language GANs from Scratch
% https://arxiv.org/abs/1905.09922
% 自然言語生成

## 概要

GAN は画像分野だとうまく行ってるがテキストではまだ難しい.
ここでは unconditional な word generation を Scratch GAN (スクラッチとは事前学習ナシのこと) でやることを考える.
この論文の主張は次の３つ

1. 本気を出せば Scratch GAN は最尤推定で生成するものと肩を並べられる
1. 重要なテク: バッチサイズを大きくすること, 稠密な報酬 (Dense rewards), そして判別器の正則化 (regularization)
1. 今の評価指標はクソ: 質と生成の多様性の双方を評価する方法はない

## 各手法

### 最尤推定 (MLE)

いつもどおり, 文 $x=(x_1,\ldots,x_T)$ の生成確率を
$$p(x;\theta) = \prod_{t=1}^T p(x_t \mid x_1,\ldots,x_{t-1}; \theta)$$
だと仮定して, これを最大にする $\theta$ を見つける方法.

### GAN

いつもの:
$$\min_\theta \max_\phi \mathbb E_{\mathrm{real}~x} \log D(x;\phi) +
\mathbb E_{\mathrm{generate}~x;\theta} \log(1-D(x;\phi))$$

ところで Goodfellow はこの後ろとして $\mathbb E \left[ - \log D(x;\phi) \right]$ を推してるらしい.

### 教師信号

判別器からの値で報酬 $R(x)$ を作ってこれで生成器を更新する (REINFORCE gradient estimator).
$$\nabla_\theta \mathbb E_{p(x;\theta)} R(x) = \mathbb E_{p(x;\theta)} \left[
R(x) \nabla_\theta \log p(x;\theta)
\right]$$

> この傾きを使って $\max_\theta R(x)$ を目的関数にするということ??

例えばこの報酬として $R(x) = p_{\text{real}}(x) / p(x;\theta)$ とすると,
上の式は

$$\begin{align*}
\mathbb E_{p(x;\theta)} \left[
R(x) \nabla_\theta \log p(x;\theta)
\right]
& =
\mathbb E_{p(x;\theta)} \left[
\frac{p_{\text{real}}(x)}{p(x;\theta)}
\nabla_\theta \log p(x;\theta)
\right] \\
& =
\mathbb E_{\text{real}} \left[
\nabla_\theta \log p(x;\theta)
\right] \\
& =
\nabla_\theta
\mathbb E_{\text{real}} \left[
\log p(x;\theta)
\right] \\
\end{align*}$$

となってこれは最尤推定 (MLE) でやるのと同じになる.

## テク

### Dense Rewards

最終目標は文章全体を生成することだが, 完璧な文(章)を生成しないと報酬がもらえないとすると生成器がなかなか学習されないので, 報酬を稠密化する.

判別器 $D(;\phi)$ は生成の方法と同様にして, 文の先頭断片を得て次の単語が妥当かを返す:
$$D(x_t \ mid x_1,\ldots,x_{t-1}; \phi)$$
これに関して GAN のあの目標関数を $\sum_{t=1}^T$ する.

$x' = p(x_t \mid x_1,\ldots,x_{t-1})$ に対する報酬は
$$R_t = \sum_{s=t}^T \gamma^{s-t} r_s$$
where
$$r_t = 2D(x' \mid x_1,\ldots,x_{t-1}) - 1$$
とする.

> ほんとに強化学習やな

### Large Batch

わからんけど大きくすればいい？

### Discriminator Regularization

normalization, dropout, L2 weight decay を入れろ.

## Evaluation

- local/global consistency
- devirsity
- quality


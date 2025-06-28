% [2003.09855] TanhExp: A Smooth Activation Function with High Convergence Speed for Lightweight Neural Networks
% https://arxiv.org/abs/2003.09855
% 深層学習 活性化関数

## 概要

TanhExp と呼んでる関数
$$f(x) = x \tanh(e^x)$$
を活性化関数として使いましょう.

## ReLU 族

活性化関数として今まで $\tanh$ とシグモイド関数 $\sigma$ （これは $\tanh$ と同型である）くらいしかないところに
ReLU が提案されてから深層学習は進展したが,
ReLU を更に改良したとされる活性化関数はいくつか提案されてきた.
TanhExp もその一つである.

- ReLU
    - $f(x) = \max(0, x)$
- Swish
    - $f(x) = x \sigma(\beta x)$
- Mish
    - $f(x) = x \tanh \left( \log (1+e^x) \right)$

![Fig 1](https://i.imgur.com/7rAReNd.png)

## 性能

### 実験

KMNIST, CIFAR-10, CIFAR-100 の Accuracy 勝負で多くのネットワーク構造で TanhExp が最良.

### 計算時間

活性化関数そのものとその微分関数の計算時間は学習時間に影響する.
流石に ReLU が最速で, 次が TanhExp か Mish かくらい.


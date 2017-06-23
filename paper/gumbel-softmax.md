% Categorical Reparameterization with Gumbel-Softmax
% https://arxiv.org/abs/1611.01144
% 深層学習 sampling

## 概要

$\text{softmax}(f(x))$ からのサンプリングを微分可能な式で表現するためのテクニック

クラス数 $k$ として

$$\pi = ( \pi_1, \pi_2, \ldots, \pi_k) = \text{softmax}(f(x)) \in \mathbb{R}^k$$

とする. ここから確率分布 $\pi$ に従って one-hot ベクトル $z$ をサンプリングする.
例えば

$$z = (0, 1, 0, \ldots, 0)$$

みたいな感じ.

## 手法

1. $i=1,2,\ldots,k$ について
    - $g_i = -\log \left( -\log u \right)$
        - where $u \sim_u (0,1]$ (一様分布)
1. $z = \text{onehot}\left( \text{arg max}_i \{ g_i + \log \pi_i \} \right)$

直接 $\pi_i$ の $\text{arg max}$
を見るのではなく適当なノイズを加えることでサンプリングを擬似的に再現してる.




% [1704.02227] Training Triplet Networks with GAN
% https://arxiv.org/abs/1704.02227
% 距離学習 類似度学習 GAN

## 概要

分類タスクを GAN によって半教師的に補強する研究は一般的であるが、
本論文は [Triplet Network](triplet-network.html) の学習を GAN によって補強する方法を報告している.

## あらまし

### Triplet Network

ちょうどこれについては昔読んで書いた記事が
[これ](triplet-network.html)
なので詳細は省くが、

triplet $(x, x^+, x^-)$ から共通のネットワーク $T$ を用いて
$(z, z^+, z^-)$ を作って、

$$\max \frac{\exp \| z - z^- \| }{\exp \| z - z^+ \| + \exp \| z - z^- \| }$$

を目指すのであった.

この値はちょうど $0$ から $1$ の範囲に収まる値なので、
本論文ではこの値を
「$x$ と $x^+$ とが同じクラスである確率」
$p_T(x, x^+, x^-)$
と表現している.
(これの対数尤度を損失関数として設計してある.)

### GAN

こちらも詳細は省くが、
2つの機械 $D, G$ について

$$V(D, G) = \mathbb{E}_{x\text{ is real }} \log D(x)
+ \mathbb{E}_{z \sim P_z} \log (1 - D(G(z)))$$

を定めた時、
$$\min_G \max_D V(D, G)$$
を目指すものであった.
典型的には、一方を固定して他方を最大化/最小化することを繰り返すことで、
学習を進める.

## Triplet Training with GAN

GAN の $D$ の前半 (というか大部分) を、triplet network の特徴ベクトルを構成する機械 $T$ だと見做すことにする.
具体的には次のようにそれぞれを構成する.

- $T: \mathcal{X} \to \mathbb{R}^n$
    - これは NNs でよしなに構成する
- $D: \mathcal{X} \to \mathbb{R}$
- $D(x) = \frac{Z}{Z + 1}$
    - where
        - $t = (t_1, t_2, \ldots, t_n) = T(x)$
        - $z_i = \exp t_i$
        - $Z = \sum_i z_i$

Triplet の学習としてはこの $T$ を行い、
GAN の学習としてはこの $D$ と何か $G$ を用意して行う.

### 実験評価

実験では MNIST/Cifar-10 の分類性能を行っている.
また Triplets を分類性能で比較するのか...
GAN だけ、Triplets だけと比較して良い.
例えば MNIST では、ラベル付きデータを 100 個だけを使って正解率 97.61% を達成.

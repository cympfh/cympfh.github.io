% [1704.06904] Residual Attention Network for Image Classification
% https://arxiv.org/abs/1704.06904
% 深層学習 物体認識

## 概要

ResNet に attention を盛り込んだ.
$N$ 層 Resnet を `ResNet-N` と呼称するのと同様に `Attention-N` と呼称している.

### Benchmark

パラメータ数とエラー率.
Attention-452 で ResNet-1001 を超えている.

| Network      | \#parameters | CIFAR-10 | CIFAR-100 |
|:------------:|-------------:|---------:|----------:|
|ResNet-1001   | 10.3e6       | 4.64     | 22.71     |
|WRN-28-10     | 36.5e6       | 4.17     | 20.50     |
|Attention-92  | 1.9e6        | 4.99     | 21.71     |
|Attention-236 | 5.1e6        | 4.14     | 21.16     |
|Attention-452 | 8.6e6        | 3.90     | 20.45     |

## 手法 - attention learning

詳細は Figure 2 をよく見ればいいと思う.

### notation

画像を $x \in \mathbb{R}^{H \times W \times C}$ で表す.
空間上の位置 $i \in \{1, \ldots, H\} \times \{1,\ldots,W\}$ とチャンネル $c \in \{1,\ldots,C\}$ で
$$x_{i,c} \in \mathbb{R}$$
を指す.
関数の成分についても同様に.

### 通常の attention module

普通に $x$ から特徴を取り出す
$$T : \mathbb{R}^{H \times W \times C} \to \mathbb{R}^{H' \times W' \times C'}$$
に同型のマスク関数 $M$ を掛けて
$$H_{i,c} = M_{i,c} \cdot T_{i,c}$$
とする.

順伝播でも $M$ がマスクとして機能するだけでなく、
$T$ の更新のための逆伝播においても、そのパラメータを $\phi$ とすると
$$\frac{\partial H}{\partial \phi}(x) = M(x) \frac{\partial T}{\partial \phi}$$
となって、同様にマスクが機能する.
これによってノイズラベルに強くなるらしい.

### 提案手法

マスクの最後に要素ごとの sigmoid を掛けて
$$M : \mathbb{R}^{H \times W \times C} \to [0, 1]^{H' \times W' \times C'}$$
として、
$$H_{i,c} = (1 + M_{i,c}) \cdot F_{i,c}$$
とする.
この $H$ の学習を彼らは "residual attention laerning" と呼んでいる.

実際には $F, M$ を複数個 residual unit を積んで構成している (Figure 2).

### Soft Mask Branch

マスク $M$ を構成する.

- Residual Networks 本体では使われなかった max pooling を使う
    - 最初の入力だけ
- 前半は Conv で後半は Deconv
- 最終層は sigmoid
    - 三通り試したが結局 sigmoid が最も良かったそう

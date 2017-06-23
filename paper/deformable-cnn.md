% Deformable Convolutional Networks
% https://arxiv.org/abs/1703.06211
% 深層学習 物体認識

## links

1. [original paper](https://arxiv.org/abs/1703.06211)
1. [a note](https://medium.com/@phelixlau/notes-on-deformable-convolutional-networks-baaabbc11cf3#.o1nd2nv1t)

## 概要

所謂CNNはカーネルが固定だけど、それ自体を学習可能にする.
その点を以って "deformable" と形容する.
同様の方式でプーリングも行える.
これを RoI (region-of-interest) pooling と呼称する.

## 手法

### CNN

通常のCNNは次のように定式化出来る.

カーネルとは二次元グリッド上のオフセットの集合

$$\mathcal{R} = \{ p_i = (x_i, y_i) \}_{i \in I}$$

のこと.
例えば "3x3 カーネル" とは

$$\mathcal{R} = \{ (x, y) : -1 \leq x \leq 1, -1 \leq y \leq 1 \}.$$

CNN はグリッド上の点 $p$ 及び、グリッドの上の重み $w(p)$ と入力の値 $x(p)$ を以って

$$y(p) = \sum_{p_i \in \mathcal{R}} w(p_i) x(p + p_i)$$

という計算によって $x$ から $y$ を求める手続きのこと.
ここで $w(p_i)$ のみを訓練する.

### deformable CNN

ここでカーネルの各点にオフセットを設けることで、カーネルの形を変更する:

$$y(p) = \sum_{p_i \in \mathcal{R}} w(p_i) x(p + p_i + \Delta p_i)$$

$\Delta p_i$ がカーネルの各点のオフセット.

この $\Delta p_i$ 自体がどこから来るかというと、これは通常の CNN の一つのカーネルから計算/学習をする.

$$\Delta p_i = \sum_{p_i \in \mathcal{R}} v(p_i) x(p + p_i)$$

$\Delta p_i$ は $i=1,2,\ldots,N$ ($N=|\mathcal{R}|$) だけあって、
各々は実際にはグリッド上の点を表現するために $(x, y)$ であるので、
$\Delta p_i$ 全てを求めるために、$2N$ 個の CNN を使っている.

### RoI (Region-of-interest) Pooling

同様にカーネルを学習可能にした Average Pooling を RoI Pooling として提案している.

$$y(p) = \frac{1}{N} \sum_{p_i \in \mathcal{R}} x(p + p_i + \Delta p_i)$$

やはりオフセット $\Delta p_i$ を学習可能な CNN で計算する.

## 実験

物体検知の各手法に本手法を差し込むことで僅かながら性能向上が確認出来た.

## 感想

実装がただ大変なだけで、期待するほどの性能向上がなくて残念.

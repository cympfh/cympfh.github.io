% Squeeze-and-Excitation Networks
% https://arxiv.org/abs/1709.01507
% 深層学習 画像認識

$\def\relu{\mathrm{relu}}\def\fc{\mathrm{fc}}
\def\height{\mathrm{height}}
\def\width{\mathrm{width}}
$

## リンク

- [arxiv](https://arxiv.org/abs/1709.01507)
- [github](https://github.com/hujie-frank/SENet)
- [chainer 実装](https://github.com/nutszebra/SENets/blob/master/se_residual_net.py#L30)

## 概要

提案する Squeeze-and-Excitation (SE) ブロックを画像認識のネットワークに挿入すると強くなる.
実験ではこれを組み込むことで ResNet, ResNeXt, VGG, BN-Inception, Inception-ResNet-v2 が強くなったことを確認した.

## SE Module

入力 $x$ は画像で3次元のテンソル $(ch, \height, \width)$ とする.
これを一回の (average) pooling で $(ch,)$ に潰す操作を $F$ とする.
またベクトルを受け取って長さ $m$ のベクトルを出力する関数を $\fc^m$ とする.

SE ブロックは次の関数.
$$SE(x) = x \odot \sigma(\fc^{ch}(\relu(\fc^{\frac{ch}{r}}(F(x)))))$$
$r$ は $4$ くらいの定数.
$\odot$ はチャンネルごとの乗算.

### SE-ResNet Module

ResNet の文脈に突っ込んで作るブロック.
$$x \oplus g(x)$$
であった箇所を
$$x \oplus SE(g(x))$$
にしたもの.

% [1708.04552] Improved Regularization of Convolutional Neural Networks with Cutout
% https://arxiv.org/abs/1708.04552
% 深層学習 物体認識

## 概要

CNN において Dropout や Denoising と同様な正則化 (regularization) 或いはデータ水増し (data augmentation) のためのテクニック、Cutout を提案する.
Cutout は Dropout の一種だと見ることもできるが、Figure 1 にあるように、入力からその空間的にある一箇所のデータを完全に落としてしまう.

![](http://i.imgur.com/gcMpxCx.png)
画像は全て [^1] からの引用です.

## 実装

ランダムな箇所の矩形領域をエポック毎に選択し、画素をゼロで埋める (zero-mask) ことをする.
Dropout とは異なり、テスト時のための特別なことはしない.

矩形領域の形よりもその領域の大きさのほうが重要であると彼らは主張している.
なので領域の形は矩形でしかも正方形に限った.
Figure 3 ではその大きさ (一辺の長さ, Patch length) を変えた場合の性能をグラフにして示している.
性能を最高にする適切な大きさというのがあるらしい.

## 参考

[^1]: [論文のpdfファイルへのリンク](https://arxiv.org/pdf/1708.04552.pdf)


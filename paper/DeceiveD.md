% [2111.06849] Deceive D: Adaptive Pseudo Augmentation for GAN Training with Limited Data
% https://arxiv.org/abs/2111.06849
% GAN

## 概要

少量データ (5k 程度) で画像 GAN を上手く訓練したい.

## APA; Adaptive Pseudo Augmentation

生成した偽画像も時々, 確率 $p$ で真の画像だとして判別器に与える.
判別器の予測精度をオンラインに見ながら, 十分学習が習熟したらその確率 $p$ を上げて, さもなくば下げることを繰り返す.

適当な確率モデルの下でこれで最適解にたどり着けることが示されている.

% [1810.12890] DropBlock: A regularization method for convolutional networks
% https://arxiv.org/abs/1810.12890
% 深層学習 画像認識

## 概要

汎化性能を上げるための正則化手法として DropBlock を提案する.
これを使うと Imagenet/ResNet-50 において 1.6% 性能が上昇した (acc=78.13%).

## 関連

- Dropout
- SpatialDropout
- DropPath
- Cutout

## DropBlock

中身も使い方も Dropout によく似ている.
Dropout は入力 (3次元テンソル $X$) のうちランダムにチャンネルベクトル $X_{i,j,\cdot}$ を選んでそれをゼロにしてしまう.

![](https://i.imgur.com/RnuGrBg.png)

DropBlock はチャンネルベクトルの選び方にもう少しだけ規則性を持たせる.
図のように落とすベクトルは矩形上に固まるようにする.
その矩形をランダムに選ぶ.

![](https://i.imgur.com/AJFGyaE.png)

入力が $(X_{ijk})$ のときマスク行列 $(M_{ij})$ を作る.
落とすチャンネルだけを $M_{ij}=0$ になるようにする.
ベルヌーイ分布に従って独立に点を決めて, その点の周りに矩形を取って全部ゼロにする.
入力の画像に $M$ を掛けるのと, それから残った部分は落としたピクセルの数の分だけ掛けてふやしてやる.

> 矩形を切り抜くという考え方は CutOut (とか RandomErasing) と同じだ.
> それを Dropout 同様に中間層にでもずこずこ使ってやろうという話.

### その他

矩形のサイズ (`block_size`) を $1$ にしてやればこれは単なる Dropout.

ベルヌーイ分布のパラメータ $\gamma$ は直接与えずに,
Dropout のように $\mathit{keep_prob}$ (落ちない確率) を決めて決定させた.
$\gamma$ と $\mathit{keep_prob}$ の関係は
$$\gamma = \frac{1-\mathit{keep_prob}}{\mathit{block_size}} \frac{\mathit{feat_size}^2}{(\mathit{feat_size} - \mathit{block_size} + 1)^2}$$
で与えられる.
$\mathit{block_size}$ は矩形の幅.
$\mathit{feat_size}$ は入力画像の大きさ.
自乗してるのはたぶん縦と横.

$\mathit{keep_prob}$ を固定にしたままだと彼らも上手く動かせなかったらしく, スケジューリングをさせたそう.
$1.0$ からスタートして徐々に目的の値まで下げると大抵上手く行ったそう.
下げ方は linear でいいと.

## 実験

まあ良くなった.

![](https://i.imgur.com/T3AKwYU.png)

他の似た正則化手法よりも良くなり方が大きい.

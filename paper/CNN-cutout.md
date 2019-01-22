% [1708.04552] Improved Regularization of Convolutional Neural Networks with Cutout
% https://arxiv.org/abs/1708.04552
% 深層学習 画像認識 データ水増し 正則化

## 概要

CNN において Dropout や Denoising と同様な正則化 (regularization) 或いはデータ水増し (data augmentation) のためのテクニック、Cutout を提案する.
Cutout は Dropout の一種だと見ることもできるが、Figure 1 にあるように、入力からその空間的にある一箇所のデータを完全に落としてしまう.

![](http://i.imgur.com/gcMpxCx.png)
画像は全て [^1] からの引用です.

## 実装

ランダムな箇所の矩形領域をエポック毎に選択し、画素をゼロで埋める (zero-mask) ことをする.
Dropout とは異なり、テスト時のための特別なことはしない.

また 50% の確率で Cutout をそもそも行わない (50%の確率で元のデータそのままを受け取る).

矩形領域の形よりもその領域の大きさのほうが重要であると彼らは主張している.
なので領域の形は矩形でしかも正方形に限った.
Figure 3 ではその大きさ (一辺の長さ, Patch length) を変えた場合の性能をグラフにして示している.
性能を最高にする適切な大きさというのがあるらしい.

## 類似提案 ([1708.04896] Random Erasing Data Augmentation)

Cutout 論文の次の日に、別のグループによる
[[1708.04896] Random Erasing Data Augmentation](https://arxiv.org/abs/1708.04896)
が発表された.
てっきり Cutout を追試したものだと思ったけど、一応別の提案ということになっているが酷似している [^2].

<blockquote class="twitter-tweet" data-lang="en"><p lang="ja" dir="ltr">学習時に入力画像の一部をランダムに消すData Augmentation手法。<br>機能投稿されていたCutout(<a href="https://t.co/ppdc85QFgC">https://t.co/ppdc85QFgC</a>)とほぼ同じと思う。<br>物体認識だけでなく物体検出、人物照合についても評価。<a href="https://t.co/m0hMY0O5ES">https://t.co/m0hMY0O5ES</a></p>&mdash; Sanno (@dsanno) <a href="https://twitter.com/dsanno/status/898014604781010946">August 17, 2017</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>

Random Erasing Data の方では選択矩形領域をランダムにしたり、そこを埋める値をまたランダムにしたりしてる.
とはいえ Cutout の方ではその大きさを固定したり埋める値をゼロに固定してるのはあくまでもシンプルな実装だとしているのであって、そこに意義があるわけではない.
ので Cutout と何が違うのか謎.

## 参考

[^1]: [論文のpdfファイルへのリンク](https://arxiv.org/pdf/1708.04552.pdf)
[^2]: [Qiita: Random Erasing Data Augmentationを試す](http://qiita.com/dsanno/items/d32f3c928cdbcbe5de60)


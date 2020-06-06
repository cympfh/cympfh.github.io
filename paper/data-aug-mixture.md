% Data Augmentation by Pairing Samples for Images Classification
% https://arxiv.org/abs/1801.02929
% 深層学習 画像認識 データ水増し 正則化

## 概要

<blockquote class="twitter-tweet" data-lang="en"><p lang="ja" dir="ltr">arxivにData Augmentationについての論文を公開しました．画像認識タスクで学習時にトレーニングセットの画像を2枚ランダムで選んで重ね合わせてみたら，びっくりするくらいエラー率が減った話です（ImageNetやCIFAR-10で15％くらい，最大で30％近く） <a href="https://t.co/pEumNkVquw">https://t.co/pEumNkVquw</a></p>&mdash; Hiroshi (Taku) Inoue (@inoueh) <a href="https://twitter.com/inoueh/status/950927417501089792?ref_src=twsrc%5Etfw">January 10, 2018</a></blockquote>
<script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>


画像認識のためのデータ水増しのテクニック.
異なる2枚の画像を重ねて (mixture) 、それを学習データに追加する (SamplePairing).
単純にデータ数が自乗に増える.

## 方法

異なる画像を (ラベルを気にせず) 2枚選ぶ.
重ねて出来た画像に元の画像の一方のラベルを与えて学習する.

NOTE:
著者によれば、同じラベルのペアに限定する方法も試したそう (https://twitter.com/inoueh/status/950990313371222016) だが、
全て使ってしまったほうが良いらしい.

## 他

<blockquote class="twitter-tweet" data-lang="en"><p lang="ja" dir="ltr">実験的には3個合成よりは2個のほうが良かったです．直感的には合成しすぎると，何がなんだかわからなくなる気がしますしｗ 濃度を変えて混ぜるとかもやったんですが，結局単純な2個平均がベストだったので・・・．</p>&mdash; Hiroshi (Taku) Inoue (@inoueh) <a href="https://twitter.com/inoueh/status/950986159919788032?ref_src=twsrc%5Etfw">January 10, 2018</a></blockquote>
<script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

## 追記

[mixup](https://arxiv.org/abs/1710.09412) という名前でほぼ同手法が提案されていた.
論文はこちらが通っている.

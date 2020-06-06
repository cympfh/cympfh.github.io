% [1811.09030] Data Augmentation using Random Image Cropping and Patching for Deep CNNs
% https://arxiv.org/abs/1811.09030
% 深層学習 画像認識 データ水増し 正則化

Random Image Cropping And Patching (RICAP) という画像認識のためのデータ水増し手法を提案する.
方法は以下の画像の通り

![](https://i.imgur.com/KK7JDkD.png)

つまり訓練のための画像の領域をランダムに4分割して, それぞれに別な4枚の画像からパッチを持ってきて埋める.
ラベルは面積に比例して混ぜたものを使う.
ある意味では mixup と同じことをやってる.

ただしこの領域の分割の仕方はその割合を Beta 分布に従って行い,
そのパラメータを探索したところ CIFAR-10 や CIFAR-100 で `Beta(0.3, .0.3)` くらい? が良かったぽい.
Beta 分布は mixup でも使ってて, `Beta(alpha, beta)` は `x in [0, 1]` の上の分布であって,
さらに`alpha=beta` のとき $x=0$ や $x=1$ の端っこのときが一番出やすいような分布.
(cf. [wikipedia/ベータ分布](https://ja.wikipedia.org/wiki/%E3%83%99%E3%83%BC%E3%82%BF%E5%88%86%E5%B8%83))

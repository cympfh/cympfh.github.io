% [1811.09030] Data Augmentation using Random Image Cropping and Patching for Deep CNNs
% https://arxiv.org/abs/1811.09030
% データ水増し 画像認識

Random Image Cropping And Patching (RICAP) という画像認識のためのデータ水増し手法を提案する.
方法は以下の画像の通り

![](https://i.imgur.com/KK7JDkD.png)

つまり訓練のための画像の領域をランダムに4分割して, それぞれに別な4枚の画像からパッチを持ってきて埋める.
ラベルは面積に比例して混ぜたものを使う.
ある意味では mixup と同じことをやってる.

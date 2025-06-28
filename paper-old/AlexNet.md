% ImageNet Classification with Deep Convolutional Neural Networks
% https://papers.nips.cc/paper/4824-imagenet-classification-with-deep-convolutional-neural-networks.pdf
% 物体検出 深層学習

Alex らが提案した画像認識のネットワークの論文.

## memo

基本すぎること、あるいは独特すぎること (ネットワークの構造) はメモしてもしょうがないので書かない.  それよりも画像認識全般に通ずる細かなテクニックをメモする.

## The Architecture

- 出力によく tanh とかつかうけど relu にしたら収束がめっちゃ速くなった.
- MultiGPU
- normalization: 単純に精度あがる

## The Dataset

- RGB の値そのままを用いた

### Augmentation

正解ラベルを保存しつつも別な画像を作ることで学習データを増強する. CPU で手軽に計算できる操作に限定することで、保存すべきデータを増やすこともなく、また GPU で学習処理をしている裏でCPUで計算させておくことができる.

ネットワーク的には 224x224 (x3-channel) の画像を入力とするが、それよりも少し大きな 256x256 の画像を用いる.
ここから、ランダムに 224x224 の画像を切り抜く.
四隅、あるいは中央から (5通りの) パッチを展開して学習に用いたとある.
また水平方向の反転は画像の意味を (大抵の場合) 変えない.

RGB の intensity (強度) の変更.
よくわからなかったです. RGBをいい感じにちょいズラす？

### Dropout

ratio=0.5

% Deep Koalarization: Image Colorization using CNNs and Inception-ResNet-v2
% https://www.researchgate.net/publication/321744935_Deep_Koalarization_Image_Colorization_using_CNNs_and_Inception-ResNet-v2
% 深層学習 自動着色

## リンク

- [ソースコード](https://github.com/baldassarreFe/deep-koalarization/)

## 概要

自動着色を行う

## アプローチ

`CIE L*a*b` (CIELAB) 空間で色付を行う.
入力はこの `L` 部分だけのものだとして、着色というのは次のような $\mathbb{R}_{\geq 0}$ 空間間の写像だとみなせる.
$$X_L \in \mathbb{R}^{H \times W \times 1} \to (X_a, X_b) \in \mathbb{R}^{H \times W \times 2}$$
これを以て、$(X_L, X_a, X_b)$ を着色された画像として推論する.

## ネットワーク構造

![](https://i.imgur.com/fMxwe0d.png)

### 事前処理
各ピクセルの値を $[-1,1]$ にする.

### Encoder
$H \times W$ の画像から $H/8 \times W/8 \times 512$ の特徴ベクトルを得る.

### Feature Extractor
こちらはより詳細な画像の特徴を取り出すためのもの ("underwater" "indoor" とか).
長さ $1001$ の1次元ベクトルを得る.

Inception-ResNet-v2 を使いたいために、入力画像を 299x299 に拡大して、また3層に重ねることで、3チャンネルの 299x299x3 という画像を作って入力にする.
また事前学習済みのものを利用する.

### Fusion
Encoder の出力と Feature Extractor の出力とを結合する.
Feature Extractor の出力を $H/8 \times W/8$ 本だけ複製して並べるｋとおで
$H/8 \times W/8 \times 1001$ のベクトルを得る.
これをEncoderの出力とそのまま結合することで
$H/8 \times W/8 \times (512+1001)$ のベクトルを得る.

![](https://i.imgur.com/IAaxkUN.png)

### loss
mse

## 実験

### データセット
ImageNet の中から 60k 枚だけを使う.
### 訓練
Adam で 23 時間.
### 結果
![](https://i.imgur.com/uEHgX8i.png)

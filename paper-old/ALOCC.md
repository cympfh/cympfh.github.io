% [1802.09088] Adversarially Learned One-Class Classifier for Novelty Detection
% https://arxiv.org/abs/1802.09088
% オートエンコーダ GAN 異常検出

## リンク

- [github:khalooei/ALOCC-CVPR2018](https://github.com/khalooei/ALOCC-CVPR2018)
- 野良解説
    - [ディープラーニングによる異常検知手法ALOCCを実装した](https://qiita.com/kzkadc/items/334c3d85c2acab38f105)

## 概要

Autoencoder+GAN で異常検出する.
ある1クラスのデータ (論文では画像) だけを訓練データにして, ハズレクラスかどうかを検出する (One-Class Classifier).

## 手法

- $\mathrm{Encoder} \colon X \to Z$ ($X$ は入力データの空間, $Z = \mathbb R^m$)
- $\mathrm{Decoder} \colon Z \to X$
- $R = \mathrm{Decoder} \circ \mathrm{Encoder}$
- $D \colon X \to [0,1]$

### 訓練

入力データ $x \in X$ にノイズを加えたデータを $\tilde{x}$ とする.
次の2つの和が損失関数.

- autoencoder
    - $\| R(\tilde{x}) - x \|^2$
- GAN
    - $\mathbb E \log D(x) + \mathbb E \log \left[ 1 - DRx \right]$

つまり $R$ はノイズを除去する autoencoder.
$D$ はオリジナルか復元データかを判別する機械.

> 要するに autoencoder 部分が GAN で言う generator なわけだが,
> その作り方にそもそもオリジナル画像 (にノイズを加えたあと頑張って除去したもの) を使ってるので, そもそも正解に近いデータである.

### 検出

$D$ のみでなく,
$$D(R(\tilde{x}))$$
の値で検出する.

$R$ は正常なデータはより $D$ に正しく判別してもらうための補正をする能力があるはずだから.

## 実験

MNIST の "1" で訓練する.
この $R$ に画像を入れると "1" っぽくなる.

![](https://i.imgur.com/QpcZHOD.png)


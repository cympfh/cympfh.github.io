% [1812.01718] Deep Learning for Classical Japanese Literature
% https://arxiv.org/abs/1812.01718
% データセット 画像認識

## リンク

- [github:rois-codh/kmnist](https://github.com/rois-codh/kmnist)

## 概要

もっと大きなベンチマークが必要.
Kuzushiji-MNIST はくずし字 (cursive Japanese) を集めたデータセット.
さらに大きなデータセットとして Kuzushiji-49 と Kuzushiji-Kanji も用意した.

## データセット

Kuzushiji-MNIST は MNIST の置き換え,
Kuzushiji-49 は画像がより大きく, 48の平仮名と繰り返し記号の文字がインバランスに含まれるもの,
Kuzushiji-Kanji は 3832 種の漢字がインバランスに含まれるもの.
後者2つについては文字の頻度は実際のテキストでの頻度のままで調整していない.

### Kuzushiji-MNIST

![](https://i.imgur.com/R29naXa.png)

- 10 classes (変体仮名, variant kana) 
- grayscale 28x28

### Kuzushiji-49

![](https://i.imgur.com/Onj4k4E.png)

- 49 classes (266,407 images)
- grayscale 28x28

### Kuzushiji-Kanji

- 3832 classes (140,426 images)
- grayscale 64x64

## Experiments

### Classification Baselines

Kuzushiji-MNIST と -49 でベースラインを作った.

Kuzushiji-MNIST は98%とかそのくらい.

### Domain Transfer from Kuzushiji to Modern Kanji

くずし字を現代風の普通の漢字に画像として変換するタスクをやった.
結構出来てる.

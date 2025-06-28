% [1806.01911] Adversarial Scene Editing: Automatic Object Removal from Weak Supervision
% https://arxiv.org/abs/1806.01911
% 画像生成

## 概要

画像に写ったある部分を消すような画像生成をしたい.
物体認識モデルを作っておいてそれを完全に騙せるような画像を作れば良い.

## 手法

![](https://i.imgur.com/EMyFdzk.png)

1. Mask Generator
    - 編集する領域を十分狭く特定する
1. In-painter
    - マスクされた残りだけを編集する
1. GAN
    - 編集された画像かどうか (Real/Fake)
    - 物体認識
        - 消したいモノが消えるように

ただしこれだけだと上手く行かなくて, 良いマスクが生成されなかった.
彼らはある程度マスクらしいマスク集合を用意して, それらから選択させるようにして実現させた.

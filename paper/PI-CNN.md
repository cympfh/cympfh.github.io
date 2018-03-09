% Facial Attractiveness Prediction using Psychologically Inspired Convolutional Neural Network (PI-CNN)
% https://pdfs.semanticscholar.org/886f/891eb99170220fb98a523c8e6f5b31ddbb38.pdf
% 深層学習 物体認識

## 備考

彼らはこのために5500枚の顔写真に美醜スコアをラベリングしたデータセット
[SCUT-FBP5500](https://github.com/HCIILAB/SCUT-FBP5500-Database-Release)
を公開している.

## 概要

心理学の知識を用いた新しい手法 PI-CNN を提案する.
見た目の良さに起因するのは、skin color, smoothness, lightning の三要素.
WLS filter をこれらの特徴を抽出するのに用いた.

## 手法

### CNN アーキテクチャ

(Fig 2) 普通に畳み込みをしまくる.

### cascaded fine-tuning

入力画像を段階的に変える.

1. WLS-detail
2. WLS-lighting
3. Color (=original, RGB)

1つめでモデルを作って、2つめでfine-tuning して〜って感じらしい.
最終的にはオリジナルのRGB画像でfine-tuning する.

WLS-* っていうのは、RGB 画像を Labに変換したその L だけを使ったものに WLS filter を掛けて得られる画像らしい.
WLS filter は、光の当て方を修正するためのフィルタであるらしい.
"A New Face Relighting Method Based on Edge-Preserving Filter"
という論文 (LETTER?) の中で提案されている.

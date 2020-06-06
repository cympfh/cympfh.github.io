% Class Imbalance, Redux
% https://pdfs.semanticscholar.org/a8ef/5a810099178b70d1490a4e6fc4426b642cde.pdf
% 分類器

## 概要

二値分類において、学習データの偏りが大きい場合は downsampling`+`bagging するのがよい.

## downsampling

データセット
$D=D^+ + D^-$
について、
$|D^+| = |D^-|$
となるまで、多い方からランダムに事例を除外.

## bagging

初めの偏ったデータから、独立に sampling して作った B 個のデータを作って、
それぞれについてモデルを B 個訓練してアンサンブル.


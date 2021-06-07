% [2105.12353] Private Recommender Systems: How Can Users Build Their Own Fair Recommender Systems without Log Data?
% https://arxiv.org/abs/2105.12353
% 推薦システム

## 概要

ログデータを使わずに自分自身のための推薦システムを構築する

## 動機

あるwebサービスの推薦システムが気に入らないときに,
内部のログデータを閲覧できない立場のユーザー自身が, 自分が気に入るように改良した推薦システムを作りたい.
これを **私用推薦システム (private recommender system)** と呼ぶことにする.

## 問題設定

プラットフォームが用意した推薦システムを
$$P \colon I \to I^K$$
とする.
ここで $I$ はアイテム集合で, 一つのアイテムに対して $K$ 個のアイテムを推薦する.
ただし内部ではユーザーごとのパーソナライズがあるかもしれないが, これはユーザーからは観測できないので上のように形式化した.

私用推薦システム
$$Q \colon I \to I^K$$
を $P$ から構築する.

## 推薦ネットワーク

$P$ を有向エッジと思うことで有向グラフを構築する.
ただしここでエッジには重みをつける.

$P(i)$ の $k$ 番目 $(k=1,2,=ldots,K)$ を $P(i).k$ とするとき,
$$\mathrm{Edge}(i \to P(i).k, \mathrm{weight}=\frac{1}{\log (k + 1)}$$
というエッジを張ることにする.

## Private Rank

このネットワークの上で PageRank (Random Walk with Restart) をする.

特にこの論文では, $P$ が含んでしまっているバイアスを除去することを盛り込んでいる.

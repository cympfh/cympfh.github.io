% k-means++: The Advantages of Careful Seeding
% http://ilpubs.stanford.edu:8090/778/1/2006-13.pdf
% 機械学習 クラスタリング

## 参考

- http://ilpubs.stanford.edu:8090/778/1/2006-13.pdf
- [K-means++法 - Wikipedia](http://ja.wikipedia.org/wiki/K-means%2B%2B%E6%B3%95)

## 概要

k-meansの初期値の決め方を改良したバージョンである.
Wikipediaではめっちゃ簡単に説明がなされている.

- 点の集合 $D$ から一つ、一様ランダムに点 $c$ を選ぶ
- 点 $x_i$ について、確率 $D(x_i, c) / Z$ を与える
    - $Z$ は正規化係数
- その確率に基づいて $k$ 個、点を選ぶ
- あとは k-means する

以上である.

論文ではこれ以上に近似比率 (なんの?) の議論とかむっちゃしてる.

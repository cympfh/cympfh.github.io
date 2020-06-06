% ICWSM - A Great Catchy Name: Semi-Supervised Recognition of Sarcastic Sentences in Online Product Reviews
% http://www.aaai.org/ocs/index.php/ICWSM/ICWSM10/paper/viewFile/1495/1851/
% 自然言語処理 極性分析 半教師アリ学習

66000 Amazon reviewから77%の精度と、83.1%の再現率で、
文に対して皮肉かどうか判定した。

教師ありっぽい。
文に対して1~5の皮肉さが付与されている。

> sarcasm : the activity of saying or writing the opposite of what you mean, or of speaking in a way intended to make someone else feel stupid or show them that you are angry (Macmillan English Dictionary 2007)

reviewのタイトル。

1. Love The Cover (book)
2. Where am I? (GPS device)
3. Trees died for this book? (book)
4. Be sure to save your purchase receipt (smart phone)
5. Are these iPods designed to die after two years? (music player)
6. Great for insomniacs (book)
7. All the features you want. Too bad they don't work!  (smart phone)
8. Great idea, now try again with a real product development team (e-reader)
9. Defective by design (music player)

1は真っ当にカバーを褒めてる。
9は真っ当にけなしてる。
6がいかにも皮肉だ。(不眠症によく効く)

## 手法

### 事前処理

ドメインに特化したくない、一般的でありたいので、
製品の名前は [product] に置き換える。
同様に [company] [title] [author] と。
HTMLタグを除く。当たり前だ。

### Pattern-based features

パターン集合をがんばって作る (Davidov and Rappoport 2006)
数100程度のパターンを得る。

e.g.

- [company] CW does not CW much
- does not CW much abount CW CW or
- not CW much
- about CW CW or CW CW.

選別をする。
一般的すぎても特化すぎてもだめ。

1. 一文にしかマッチしないパターンを除去
1. 皮肉さが1にも5のにもマッチするのは一般的すぎるから除去

マッチの度合い

```
let alpha = 0.1
    gamma = 0.1
```

- 完全にマッチ = 1
- 部分的にマッチ = alpha
- 不完全なマッチ = gamma * n / N
- マッチしない = 0

パターンの方に語をいくつか挿入したらマッチ -> 部分的
パターン中の変数CWをいくつか消したらマッチ -> 不完全なマッチ
パターンの語数をN、マッチできた語数をnとする。

> Garmin apparently does not care much abount product quality of customer support.

- [title] CW does not -> 1
- [title] CW not -> alpha (doesを挿入)
- [title] CW CW does not -> gamma * 4 / 5 (片方のCWを消した)

### Punctuation-based features

1. 語数
1. !の数
1. ?の数
1. クオートの数
1. 大文字から始ってる語の数
1. 全部大文字になってる語の数

## Data

66000 reviews for 120 products をAmazonからあつめた。

productの種類はできるだけ様々に

- book
- music player
- digital camera
- camcoder
- GPS
- e-readers
- game consoles
- mobile phone

### Seed

まず、手でアノテートする。
positive (sarcasm) 80 reviews and negative 80 reviews.
合わせて 505 文。

### 拡張

で、あとは出来るだけ簡単に増やそう。
データを増やすのに
皮肉文の語でYahoo!検索してデータを増やした。
最初の6単語でやふーでぐぐる。
皮肉のレベルは元のと同じ

"This book was really good-until page 2"

から、
"this book was really good until"
で検索。

"Gee, I thought this book was really good until I found out the author didnt get into Bread Loaf"
を見つけた。

このように拡張して、
471 positive
と、
5020 negative
を集めた。

## 分類

kNNっぽいことをする。
連続的な値についてのクラスタリングなので、
もうちっと、
平均を取るようなことをする。

## baseline

star が低くて positive sentiment のやつ。

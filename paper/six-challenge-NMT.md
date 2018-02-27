%  Six Challenges for Neural Machine Translation
% https://arxiv.org/abs/1706.03872
% 自然言語処理 自動翻訳

## 概要

NMTにある6つの課題を調査した.

1. domain mismatch,
    - 自然さのためにはドメインを絞って学習したいが
1. amount of training data,
    - 学習曲線はデータ量に関して急勾配 (steeper) である
1. rare words,
    - sub-word の概念で改善はしているが、低頻度の動詞はまだ弱い
1. long sentences,
    - 60語程度以上で死ぬ
1. word alignment,
1. beam search
    - 探索範囲を広げると結果がむしろ悪化する

## 実験環境

NMT は Nematus (2017) っていうツールが現時点で最強らしい.
(中身は attention 付き encoder-decoder でいいのかな?)
基本、デフォルトの設定で使う.
語彙数が 50,000 になるように subword の数を設定する.

SMT として Moses (2007) を使う.
この論文の著者の Philipp Koehn が作者だった.
もっと他にもいいのがあるよと言ってるが、Statisticalなのはもう全部2007年で終わってる.

データには,
単なる翻訳タスクには WMT ([http://www.statmt.org/wmt17/](http://www.statmt.org/wmt17/)) を、
ドメインでの違いを調べる用には OPUS corpus ([http://opus.lingfil.uu.se/](http://opus.lingfil.uu.se/)) を用いた.

## 実験

### Domain Mismatch

![](https://i.imgur.com/efWsZmr.png)

例えば二行目は Law で学習した結果を各ジャンルに適用した結果.
各項目で左（黄緑）がNMTでの結果で、右（青）がSMT.
NMTの方がドメインの違いに弱いことがよく分かる.
Figure 2 の Medical とかもなかなかすごい.

### Amount of Training Data

![](https://i.imgur.com/ZuHIqRU.png)

上がり方は NMT の方が顕著.
語彙数が少ない時は SMT の方がマシで、 2 billion 単語数 (2e9) 程度でSMTに打ち勝てる.

### Rare Words
知らん

### Long Sentences

![](https://i.imgur.com/hrDUtM4.png)

文長と精度は関係がある.
よく言われているのは、encoder-decoder はあんまり長い文を正しく変換する能力はない.

### Word Alignment

### Beam Search

実際の予測時、高い確率を持つ列をサンプリングするのにビームサーチが普通使われる.
一般にビームサイズを増やせば増やすほど最適解に近づくはずだが、BLEUで測ると上に凸の折れ線グラフを描く.

![](https://i.imgur.com/6CIR05Y.png)

ビームサイズは凡そ4から30程度が最適らしい.
詳しく書いてないけど、文長によって normalize する手法があるらしい.


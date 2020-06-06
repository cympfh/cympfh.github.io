% Cross-Lingual Sentiment Analysis Without (Good) Translation
% https://arxiv.org/abs/1707.01626
% 極性分析 言語横断

## 概要

マイナー言語の極性分析 (sentiment classifier) をしたい.

データセットは英語ばかりが有利なので, これを使いたい.
既存の解決方法としては, 機械翻訳をしてしまうとか,
Bilingual Word Embedding [Zou+,2013; Bengio+Corrado,2015]
などがある.

本論文では vector space 間の翻訳 [Mikolov+,2013] をベースに行う.
極性分析は英語のベクトル空間上だけで学習し, それとは独立に, 未知言語のベクトル空間から英語のベクトル空間へ翻訳する行列を学習する.
翻訳行列自体は翻訳のスコアはとても低いが, 全体の極性分析としてはちゃんと働く.

## 手法

### 言語ベクトル空間

- 英語: Google News dataset
    - 100 billion words
    - 300 dim
- スペイン語: Spanish Billion Word Corpus
    - 1.5 billion words
    - 300 dim
- 中国語: Wikimedia
    - 簡体字から繁体字への変換に OpenCC
    - Jieba でトークナイズ
    - 300 dim

### 単語リスト

翻訳行列を作るのに使う単語を選ぶ.
Google の "Trillion Word Corpus" から最頻出する 10,000 英単語を選び, 単語の対訳を Google 翻訳でスペイン語と中国語で用意する.
ただし, ベクトル空間において見当たらない単語はすべて捨てる.

極性分析のための訓練データとして, Hu+Liu (2004) の作った English opinion words を用いる.
またその対訳も Google 翻訳で得ておく.
そしてやはり, ベクトル空間に出現しない単語はすべて捨てる.

### 翻訳行列

対訳のペア $\{x_i, z_i\}$ があって ($z$ が英語), 次のような $W$ が欲しい:
$$z_i = Wx_i.$$
というわけで自乗誤差最小化を目指す:
$$\min_W \sum_i \| Wx_i - z_i \|^2.$$

### 極性分析

ベクトルからポジネガの判定.
linearSVM をやったらしい.
SGD で学習したそう (SVMなのにか).

## 結果

### 翻訳の精度

翻訳というフェーズを介するので当然翻訳自体の精度が気になる.

![](https://i.imgur.com/2Z0kJMR.png)

こんなもん.

### 極性分析

翻訳してから分類した結果

![](https://i.imgur.com/2Z0kJMR.png)

まあ、はい.

### 中国語での例

![](https://i.imgur.com/2Z0kJMR.png)

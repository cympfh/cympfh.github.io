% No Training Required: Exploring Random Encoders for Sentence Classification
% https://openreview.net/forum?id=BkgPajAcY7
% 自然言語処理

## 概要

単語の分散表現に pre-trained なものだけを使い, RNN 部分は一切訓練せずテキスト分類を解く.

## アプローチ

### Random Sentence Encoders

訓練済みの単語ベクトルによって,
文 (単語列) について分散ベクトルの列
$e_1,\ldots,e_n$
を得る.
列を読む RNN のような $f_\theta$ を以て
$$h = f_\theta(e_1,\ldots,e_n)$$
で分類DNNを構成するが,
ここで, パラメータ $\theta$ を一切更新せずランダムに初期化したままにする.
ということは教師ラベルは要らない!!

この $f_\theta$ の計算に次の3通りを試す.

1. Bag of Random Embedding Projection
1. Random LSTM
1. Echo State Network

### Bag of Random Embedding Projection (BOREP)

Bag of Words 的に扱う.

単語ベクトル $d$ 次元について
各成分を $\left[ -\dfrac{1}{\sqrt{d}}, \dfrac{1}{\sqrt{d}} \right]$ で一様ランダムに作った行列
$W \in \mathbb{R}^{D \times d}$ を用いて,
$e \in \mathbb R^d$ について,
$$h = f_{\text{pool}}(W e_1,\ldots,W e_n)$$
とする.
また $f_{\text{pool}}$ は何かしらのプーリングで,
$\sum(x)$, $\max(x)$, $\sum(x) / |x|$ など.
また適宜 $\max(0,h)$ で活性化もする.

### Random LSTM (RandLSTM)

パラメータを
$\left[ -\dfrac{1}{\sqrt{d}}, \dfrac{1}{\sqrt{d}} \right]$
で一様ランダムに初期化して,
また hidden size を $d$ にした BiLSTM によって列を読む.
これで読んだ値をプーリングする.
$$h = f_{\text{pool}} (\mathrm{BiLSTM}(e_1,\ldots,e_n))$$

### Echo State Network (ESN)

これは [Jaeger, 2001] で提案されたもので,
入力列について各成分のラベルを予測するようなもの.
つまりラベルの列が出力.

- $\hat{h}_i = f_{\text{pool}} (W^i e_i + W^h h_{i-1} + b^i)$
- $h_i = (1 - \alpha) h{_i-1} + \alpha \hat{h}_i$

もちろん $W^i, W^h, b^i$ はランダムに初期化するパラメータ.
$\alpha \in (0,1]$ は適当に決めるパラメータ.

予測ラベルは更にこう:

- $\hat{y}_i = W^o [e_i;h_i] + b^o$

$W^o,b^o$ はランダムで決まるパラメータ.

以上のようにして列を読んで列を返す手続きを ESN とするとき
$$h = \max(\mathrm{ESN}(e_1,\ldots,e_n))$$

> $h$ からラベル予測はさすがに普通に教師あり学習？？

## Results

評価には [SentEval](SentEval.html) を使う.

![](https://i.imgur.com/eZDm4SW.png)

最新手法をさすがに超えはしないがベースラインにはなると言っている.
そして結構迫るくらい精度を出してる.

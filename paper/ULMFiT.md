% [1801.06146] Universal Language Model Fine-tuning for Text Classification
% https://arxiv.org/abs/1801.06146
% テキスト分類 自然言語処理

## 概要

データの一部のみが labeled なときの学習を考える.
**inductive learning**: labeled なデータのみを用いて学習をして、それをデータ全体に適用させる試み.
**transductive learning**: unlabeled なデータもなにかしら学習を用いる試み.

提案手法の Universal Language Model Fine-tuning (ULMFiT) は言語モデルをまず学習させてそれをテキスト分類転移させる.
モデルは 3-layer LSTM (`Input -- Embedding -- LSTM -- LSTM -- LSTM -- Softmax`).
6つのテキスト分類実験を行う.

## 提案手法

a. LM を普通に学習
    - general-domain corpus
b. LM をファインチューニング
    - target task data
    - discriminative fine-tuning
    - slanted triangular learning rates (STLR)
c. これを分類器としてファインチューニング
    - gradual unfreezing
    - discriminative fine-tuning
    - slanted triangular learning rates (STLR)

### Discriminative fine-tuning

層ごとに異なる学習率を使わせる.
$\ell$ 番目の層を学習率 $\eta^\ell$ とする.
人間は last layer (一番出力側) の学習率だけを選んで、それより手前は
$\eta^{\ell-1} = \eta^{\ell} / 2.6$
という風に小さくしてく.

### Slanted triangular learning rates (STLR)

初めの方は学習率を上げていって、途中から徐々に下げる.

![](https://i.imgur.com/wwDOPL5.png)

### Gradual unfreezing

学習率と同様に、ファインチューニングでは最後の層 (出力側) から優先的に学習させたい.
そこで gradual unfreezing では、初め完全に freeze させてしまい、最後の層から徐々に unfreeze させる.
学習が収束して初めて次の層を unfreeze させる.
最後はすべての層が unfreeze してる.

### Concat pooling

LSTMの出力は列
$H=(h_1,\ldots,h_T)$
であって、最後の層はこの最後の成分 $h_T$ を普通使うわけだが、
$T$ が何百もあったとき、最初の方の情報が失われてしまう.
そこで pooling を使う (bi-direction でいいのでは??).
$$h_c = h_T \oplus \mathrm{max} H \oplus \mathrm{mean} H$$
として、これを出力として使う.
ここで $\oplus$ はベクトルの結合.

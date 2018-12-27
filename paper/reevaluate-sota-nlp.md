% [1707.05589] On the State of the Art of Evaluation in Neural Language Models
% https://arxiv.org/abs/1707.05589
% 自然言語処理 深層学習

## 概要

Neural Language Model のSOTAなアーキテクチャを同じ環境で比較実験をする

## Models

1. Long Short-Term Memory (LSTM) (Hochreiter & Schmidhuber, 1997)
1. Recurrent Highway Network (RHN) (Zilly+, 2016)
1. NAS (Zoph & Le, 2016)

![](https://i.imgur.com/81S7LOt.png)

## Dataset

1. Penn Treebank (Marcus+, 1993), preprocessed (Mikolov+, 2010)
1. Wikitext-2 (Merity+, 2016)
1. Enwik8 from the Hutter Prize dataset (Hutter, 2012)
    - こいつだけ char-level model にする

内の最初の90M文字を train に用いて残りの10M文字で validation と test を作った.

## Training

Penn Treebank と Wikitext-2 には以下の通りにする.

- batch size: 64
- Adam (Kingma & Ba, 2014)
    - $\beta_1=0$
        - exponential moving average が切られるのでほぼモーメント無しの RMSProp
    - $\beta_2 = 0.999, \epsilon=10^{-9}$ (default)

Enwik8 は char-level にしたいので以下のように変える

- batch size: 128
- Adam (Kingma & Ba, 2014)
    - $\beta_1=0$
        - exponential moving average が切られるのでほぼモーメント無しの RMSProp
    - $\beta_2 = 0.99, \epsilon=10^{-5}$ (default)

## Evaluation

validation での perlexity が best の時点のモデルで評価する.
評価時には batch size は 1 にする.
Word-level だと, 訓練のときのバッチサイズのままにすると 0.3 PPL くらい悪くなる.
Char-level だと影響は無いのでどうでも良いらしい.

### Hyperparameter tuning

Google Vizier (Golovin+, 2017) を使う.
こいつはブラックボックス最適化をしてくれる.
簡単のために以下に限って最適化をした:

1. learning rate
1. input embedding ratio
1. input dropout
1. state dropout
1. output dropout
1. weight decay

## Results

論文報告との比較.
Perplexity なので小さい方が良い (PPL$=2^H$).

<center>
![](https://i.imgur.com/jJ9G5pK.png)

![](https://i.imgur.com/W9F7hZF.png)

![](https://i.imgur.com/8NDjRov.png)
</center>

パラメータを注意深く選べば報告よりも良くなる.

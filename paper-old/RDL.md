% Representational Distance Learning for Deep Neural Networks
% https://arxiv.org/abs/1511.03979
% 深層学習 類似度学習 距離学習

## 概要

- 類似度 (あるいは距離) を学習する
- より正確には、類似度の表現を学習する
- 次が与えられることを仮定
    - $X = \{x_1, x_2, \ldots, x_n\}$
    - $sim(x_i, x_j) \in \mathbb{R}$
- 多層ネットワーク $f$ と適当な類似度関数 $d$ を用いて
    - $sim(x_i, x_j) \sim d(f(x_i), f(x_j))$
    - で近似できるように $f$ を学習する
- 学習によい勾配の近似式が本論文で与えられる
- MNISTとCIFARで実験した結果が与えられる
    - 実験の評価としては、類似度を用いて分類問題に落としている
    - 結果としては特別良くも悪くも無い
        - まぁ、分類はハナから分類として解くべき

## 私の実装

[cympfh/simeji: find similar images](https://github.com/cympfh/simeji)
の mnist.py です.

## 関連

Siamese-Network ってのがあって、最後の距離関数として、ユークリッド距離自乗を使ってるだけに見える.
歴史的にはこちらが先なハズ.

% Learning Confidence for Out-of-Distribution Detection in Neural Networks
% https://arxiv.org/abs/1802.04865
% 機械学習 深層学習 分類器

## リンク

- [arxiv](https://arxiv.org/abs/1802.04865)
- [github](https://github.com/uoguelph-mlrg/confidence_estimation)

## 概要

予測がどれくらいの確信度のものなのか,
また入力がそのモデルが確かに予測できるデータの分布から外れていないか (out-of-distribution detection)
といった問題を考える.

## Confidence Estimation

ラベルの予測器を拡張して確信度 $c \in [0,1]$ も同時に出力するようにする.
下図は彼らが画像認識をNNで組んだときのネットワーク図.
最後の方で全結合層で分岐させて最後に sigmoid を噛ましたと述べている.

![](https://i.imgur.com/KuM6bKO.png)

画像認識のような多クラス分類だとすると, 本来ラベル予測器は
$$p = f(x; \theta)$$
$$\sum_i p_i = 1, p_i \geq 0$$
の形をしているが, これを
$$(p, c) = f(x; \theta)$$
にする.

さて $c$ の教師データは直接与えられないので次のように hint を与えることで間接的に学習させる.

教師データ $(x, y)$ について,

- $(p, c) = f(x; \theta)$
- $p' = c \cdot p + (1-c) y$
- $\mathcal L(x, y) = -\sum_i y_i \log {p'}_i$

この $\mathcal L$ を損失関数にして学習する.
通常の教師あり学習は $c=1$ の場合に相当する.

> 教師データを完全には信用しない学習なので, 嘘のラベルが混じっていてもよくなるのかも?

ただしこれだけだと, 常に $c=0$ と予測すれば最適解になるので,
$$\mathcal L(x, y) - \log c$$
を改めて損失関数にする.
もちろんこれの最適解は $c=1$ であって, 常に正しい予測をする場合になる.

![](https://i.imgur.com/meGE8S5.png)


% [1809.06858]FRAGE: Frequency-Agnostic Word Representation
% https://arxiv.org/abs/1809.06858
% 単語分散表現

## 概要

単語の分散表現獲得はどれも、希少語に弱い.
よく近傍探索とか類似度が近いものを選ぶみたいな使い方をするときに希少語が邪魔をしてきてしまう.

> 単純に, 更新される頻度が低いからほぼ初期値みたいな値になっている.

![](https://i.imgur.com/BrlJhqc.png)

学習した分散表現のプロット（たぶんPCA？）で赤いのが希少語. 意味に関わらず固まってしまっている.

## 手法

上図のように固まっているのが問題なので, popular/rare を識別する分類器を後ろに付けて GAN する.
語彙は予め popular/rare に分割しておく.

![](https://i.imgur.com/Jx9j6Gc.png)

左の "Task" は分散表現を得てから何かしらの補助タスクで, 例えば RNN で言語モデルなど.

> 例が word2vec なんだから Task としてそのまんま skipgram したらいいのでは？ と思うけど論文中では具体的に何とは書いてない.
> [ソースコード](https://github.com/ChengyueGongR/Frequency-Agnostic/blob/master/lm/model.py#L69) 読むと言語モデルみたいだけど.

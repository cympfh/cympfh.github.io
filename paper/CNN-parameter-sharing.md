% Learning Implicitly Recurrent CNNs Through Parameter Sharing
% https://openreview.net/forum?id=rJgYxn09Fm
% 画像認識 深層学習

## 概要

CNN のパラメータを複数CNN層間で緩やかに共有させる.

![](https://i.imgur.com/eWb2xbe.png)

## Soft Parameter Sharing

$i$ 番目の CNN が持つパラメータ $W^i$ について,
パラメータテンプレートと呼ぶ $T^1,\ldots,T^k$ を用意して
$$W^i = \sum_j \alpha^i_j T^j$$
としてやる.
ここでもはや $W^i$ はパラメータではない.
複数のCNNはテンプレートと通してパラメータを共有する.

また $\alpha^i$ は one-hot ベクトルであるようにして, 従って $W^i$ はちょうどどれかの $T^j$.

![](https://i.imgur.com/cLOCGGz.png)

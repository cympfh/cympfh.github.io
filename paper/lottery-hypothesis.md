% [2002.00585] Proving the Lottery Ticket Hypothesis: Pruning is All You Need
% https://arxiv.org/abs/2002.00585
% 深層学習

## 概要

次の仮説を検証する

### 宝くじ仮説 (Lottery Ticket Hypothesis)

ランダムに初期化され十分に密な NN $M$ があるとする.
このときある部分 NN $N$ $(N \subset M, N \ne M)$ があって,
$M,N$ を独立に学習させると同程度の精度を達成する.

この部分 NN, $N$ のことを当たり券 (winning ticket) と呼んでいる.

## 部分 NN の構成

1.  $M$ をある程度学習させる
1. 重みの絶対値が小さい枝を刈っていく
    - 刈る枝の量は予め割合で決めておく
1. 残ったのが当たり券 $N$
1. (公平性のため) 最後に各重みは初期状態に戻す

また部分 NN の実装は, 各枝にマスク $m \in \{0,1\}$ を掛けることで実現する.

## 実験

Figure 3 を見ると,
確かにこの宝くじ仮説は正しそうに思えて,
21% にまで削減しても, 同程度の性能を出している.
平均で見るとやや悪くなっているくらい.

初期状態に戻すという最後の工程をしないで, ただ枝刈りだけすると, 基本的に性能が上がる.
極端にやりすぎるとさすがに下がるけど,
例えば LeNet を 7.0% にまで減らしたものの方が有意に性能が上.

他にも実験が豊富
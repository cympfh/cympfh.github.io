% [2205.13147] Matryoshka Representation Learning
% https://arxiv.org/abs/2205.13147
% 埋め込み表現 次元圧縮

## 概要

次元数に関して融通の効く埋め込み表現を作りたい.
というのも次元数がでかいとそれ以降の処理全てが重たくなるから.
提案する Matryoshka Representation Learning (MRL) では, 高次元ベクトルがその中に低次元ベクトルを内包（ネスト）している.

## Matryoshka Representation Learning

Figure 1. が提案の全てという感じがするね.

次元数 $d \in \mathbb R$ を決めておく.
あるドメインのデータ $x$ に対してベクトル $z \in \mathbb R^d$ を割り当てるのが最終的なゴール.
表現サイズの集合 $M \subseteq \{1,2,\ldots,d\}$ を決める.
例えば $M = \{ d, d/2, d/4, \ldots \}$ のようにする (こうすると $M$ のサイズは $\log d$ 程度).
$m \in M$ について $z$ の中の頭の $m$ 個成分を並べた $z_{1:m}$ もそれ単体で意味のある埋め込み表現であるように学習を行うことにする.
実験では各 $z_{1:m}$ それぞれでタスクを行いロスを足し合わせたものを最適化することで並列に全ての埋め込み表現を獲得している.

### 画像への適応例

ResNet50 を ImageNet-1K データセットで学習する.
画像データは 224x224 画像で, まずニューラルネット $F$ でこれを $d=2048$ 次元ベクトルに埋め込む.
表現サイズとして $M=\{2048, 1024, \ldots, 16, 8\}$ としている.

タスクは画像分類とするので最後に行列 $W$ を使って,
$\mathrm{softmax}(W \cdot F(x))$
で学習をする.
ロスは softmax 取る前の確率分布と教師データとを比較して
$\mathcal{L} = L(W \cdot F(x), y)$
だということにする.

ただしこれを全ての $m \in M$ について同じことをやって, 適当にロスの和を取る.

$$\mathcal L = \sum_m c_m L(W^{m} \cdot F(x), y)$$

ここで $W^{m}$ は $m \in M$ に対応する行列であって,
しかも左 $m$ 列以外はゼロで埋まってる.
また $c_m$ はロスを取る重み.

以上が MRL.

## 結果

高次元だったらどの手法とも大差ない.
次元数を落とす場合, MRL では 2048 次元の学習と一緒に回すので精度が良い.
他の表現獲得の手法の場合はその低次元を直接学習するが, 精度が悪い.

ただ FF でやる場合はこれは低次元でもそんなに悪くない.
MRL はFFを $\log d$ 個並列で走らせてるようなものなので, 同じことやってるとも言えるけど.
でもちょっとは MRL のが精度良いので, いろんな次元がいっぺんに欲しいなら確実にやったほうがいい.
或いは精度を1ポイントでも上げたいんだというなら MRL やるのもアリかもしれない.
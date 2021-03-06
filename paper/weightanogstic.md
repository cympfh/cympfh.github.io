% Weight Agnostic Neural Networks (WANN)
% https://weightagnostic.github.io/
% 深層学習

## 概要

実際の生物を観察すると, 生まれたてにも関わらずに運動能力や認知能力をすぐに獲得する.
NNs で言えばパラメータがまだランダムな状態でもある程度の能力が獲得できるということになる.

パラメータはランダムはままで頑張る系の研究はままある.
ランダムなままの CNN で画像をどうこうする系とか LSTM で系列をどうこうする系とか.
NNs というのはパラメータに対しては意外と剛健らしい.
しかしながら逆に構造は重要で, やはり画像には CNN だし系列には LSTM 系が強い.

というわけで, パラメータはランダムなままで, ネットワーク構造を進化させる方向で強いものが作れるか実験をする.

## 実験

単純なネットワークから初めて（パラメータは未熟な状態で）動かして評価して強いのを作ってく.

![](https://i.imgur.com/pTc7BFx.png)

一番左の状態からスタートして, 徐々に複雑化してく.

![](https://i.imgur.com/aFbu2bU.png)

パラメータは先程述べたように基本的にランダムだが, 次の四通りを試した.

1. random weights: それぞれ $U(-2, 2)$ (一様ランダム)
1. random shared weight: 共通して一つの重み $U(-2, 2)$ を使う
1. tuned shared weight: 共通して一つを使うが $(-2, 2)$ の中で最高性能を出すものを選ぶ
1. tuned weight: これはちゃんと強化学習してチューニングしたもの

![](https://i.imgur.com/zPW4Oof.png)

チューニングはチューニングなんだからシたほうが結果がよくなるのは当然だけど, shared が実は強い.
大雑把に言えば $1<2<3<4$ という結果.

[weightagnostic.github.io](https://weightagnostic.github.io/) にデモがある.

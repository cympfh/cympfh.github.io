% Scalable Approximate NonSymmetric Autoencoder for Collaborative Filtering (SANSA)
% https://dl.acm.org/doi/pdf/10.1145/3604915.3608827
% 推薦システム

## 資料

- 作者実装
    - [SANSA: how to compute EASE on million item datasets](https://github.com/glami/sansa)
- ポスター
    - [[https://github.com/glami/sansa/blob/main/assets/poster.pdf]]

## 概要

[EASE](./EASE) をスケールするように修正したもの.

EASE にグラム行列 $(X^t X)$ の逆行列を計算する必要がある.
空間計算量がでかすぎる. 近似で効率的に見つけることにする.
またスパースなニューラルネットワークモデルで構築することで推論もめちゃ速い.

## EASE の概要

user-item のインタラクション行列 $X$ を用意したら,
正則化付きのグラム行列

$$A = X^t X + \lambda I$$

を持ってきて,

$$P = A^{-1}$$

を計算する.
これをちょろっと後処理して行列 $B$ を作る.
$B$ は対角成分が $0$ な正方行列で,
item に関する autoencoder になっている.
$X B$ を計算することでレコメンド予測として機能する.

## SANSA

上述の $P=A^{-1}$ を近似的に見つけることをやる.

- LDL 分解 (square-root-free Cholesky decomposition) をする
    - $A \approx LDL^t$
- 近似逆行列
    - $K \approx L^{-1}$

SANSA は得られる $K^t D^{-1} K$ から,
encoder-layer $W^t$ と
decoder-layer $Z$ の２つを作る.

最終的に $B \approx W^t Z$ として, EASE の $B$ を近似する.

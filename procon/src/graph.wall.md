# グラフ - 最短路 - ワーシャル-フロイド法

## 概要

全点対の最小コストを $O(V^3)$ で求める.

## 入出力

$d$ は [超数](algebra.hyper) 上の $n \times n$ 行列で, 各成分は次のような値だとする:

- 自己ループ辺
    - $d_{i,i} = 0$
- 頂点 $i$ から $j$ にコスト（距離）$c$ の辺があるとき $(i \ne j)$
    - $d_{i,j} = c$
- $i$ から $j$ に辺がないとき $(i \ne j)$
    - $d_{i,j} = \infty$

このときに `warshall_floyd` を実行すると, これは $d$ を破壊的に更新して,

- 頂点 $i$ から $j$ へ到達可能なら
    - $d_{i,j}$ はその最小コスト
- 到達不可能なら
    - $d_{i,j} = \infty$

## 実装

@[rust](procon-rs/src/graph/shortest/warshall_floyd.rs)

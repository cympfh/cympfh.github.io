# 有向グラフ - 最大流量

## 概要

Dinic 法を実装する

## 入出力

重み付きの隣接リストを入力とする.
すなわち,
頂点 $u$ から $v$ へ容量 $c$ の辺があるとき,
`neigh[u] = [(v, w)]`
とするようなリスト `neigh`.

## 関連問題

- [ABC091/C - 2D Plane 2N Points](https://beta.atcoder.jp/contests/arc092/tasks/arc092_a)

## 実装

@[rust](procon-rs/src/graph/directed/dinic.rs)

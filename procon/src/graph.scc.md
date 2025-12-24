# 有向グラフ - 強連結成分分解 (SCC)

## 概要
有向グラフの強連結成分分解を行い, DAG を作る.

## 入出力
出力は2つ組 `(cmp, dag)`.
`cmp` は元のグラフから新たに作ったDAGへの頂点の対応付けで,
元のグラフの頂点 `i` を `cmp[i]` に写す.
`dag` はDAGの隣接リスト表現.

@[rust](procon-rs/src/graph/directed/scc.rs)

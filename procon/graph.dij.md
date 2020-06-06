# graph.dij - ダイクストラ法

## [graph.dij.rs](graph.dij.rs)

`type Cost` は `i64` か `f64`.
始点を `s` として, 各頂点までの最短コストの列を返す.

@[rust](graph.dij.rs)

## [graph.dij.cc](graph.dij.cc)

- 入力;
    - `using Cost = long long`
    - 始点 `s: int`
    - コスト付き隣接リスト `vector<vector<pair<int, Cost>>> &neigh`
- 出力
    - 各点までの最短コストの列 `vector<Cost> d`

@[cpp](graph.dij.cc)

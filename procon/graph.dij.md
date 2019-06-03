# graph.dij - ダイクストラ法

## [graph.dij.rs](graph.dij.rs)

- 入力;
    - `type Cost = u64` (マイナス `-` が取れる必要)
    - 始点 `s: usize`
    - コスト付き隣接リスト
        - `neigh: Vec<Vec<(usize, Cost)>>`
            - `(j, c)` $\in$ `neigh[i]` $\iff$ 点 `i` から点 `j` へコスト `c` の枝が存在
- 出力;
    - 各点までの最短コストの列
        - `d: Vec<Cost>`

@[rust](graph.dij.rs)

## [graph.dij.cc](graph.dij.cc)

- 入力;
    - `using Cost = long long`
    - 始点 `s: int`
    - コスト付き隣接リスト `vector<vector<pair<int, Cost>>> &neigh`
- 出力
    - 各点までの最短コストの列 `vector<Cost> d`

@[cpp](graph.dij.cc)

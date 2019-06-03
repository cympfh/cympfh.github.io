# graph.maxflow

## [graph.maxflow.rs](graph.maxflow.rs)

Dinic 法の実装

- 入力;
    - 重み付き隣接リスト `g`
        - 辺 $u \longrightarrow^w v$ を `g[u] = [(v, w)]` とする
    - 始点 `s`
    - 終点 `t`
- 出力;
    - `Dinic::flow(g, s, t)`

@[rust](graph.maxflow.rs)

## [graph.maxflow.cc](graph.maxflow.cc)

Ford-Fulkerson 法の実装

- 入力;
    - 隣接リスト `d`
    - コストテーブル `c`
    - 始点 `s`
    - 終点 `t`
- 出力;
    - `this.flow`

@[cpp](graph.maxflow.cc)

## Example

@[cpp](graph.maxflow.ex.cc)

## 関連問題

- [ABC091/ARC092; C - 2D Plane 2N Points](https://beta.atcoder.jp/contests/arc092/tasks/arc092_a)

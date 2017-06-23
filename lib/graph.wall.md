% graph.wall

## [graph.wall.cc](graph.wall.cc)

- 入力;
    - 距離 (コスト) テーブル `d`
        - `d[i][i] = cost`: 辺 $(i,j)$ が存在するとき
        - `d[i][j] = inf`: 辺 $(i,j)$ が存在しないとき
- 出力 (`d` の上書き);
    - `d[i][j]`: パス $i \rightarrow j$ があるとき、最短距離 (最小コスト)
    - `d[i][j] = inf`: パス $i \rightarrow j$ が存在しないとき

@[cpp](graph.wall.cc)

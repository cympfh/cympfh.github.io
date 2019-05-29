% graph.wall

## Warshall-Floyd

$n$ 頂点有向グラフの各辺に整数コストが与えられた時,
全点対の最小コストを
$O(n^3)$
で求める.

### 前提

$d$ を $n \times n$ のテーブル (二重配列) とする.
次の値がセットされてるとする:

- $d[i][i] = 0$ (自己ループ辺)
- 辺 $(i,j)$ が存在するとき $d[i][j]$ はそのコスト (整数値)
- 辺 $(i,j)$ が存在しないとき $d[i][j] = \infty$

以下のライブラリはどちらも $d$ を与えると破壊的に更新して、

- 点 $i$ から点 $j$ へ到達可能ならば $d[i][j]$ はその最小コスト
- 到達不可能ならば $d[i][j] = \infty$

## [graph.wall.rs](graph.wall.rs)

@[rust](graph.wall.rs)

## [graph.wall.cc](graph.wall.cc)

@[cpp](graph.wall.cc)

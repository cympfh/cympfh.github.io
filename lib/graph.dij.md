% graph.dij

## [graph.dij.cc](graph.dij.cc)

- 入力;
    - 隣接リスト `neigh`
    - コストテーブル `cost`
    - 始点 `s`
- 出力
    - 各点までの最短コストを返す (`vi`)

@[cpp](graph.dij.cc)

## Example

- $n$ 頂点 $m$ 辺からなる無向グラフが与えられる.
- $n$ 頂点を自然数 $1$ から $n$ によってナンバリングする.
- 各辺 $(u, v)$ にはコスト $c_{u,v}$ がある.
- 頂点 $1$ から各頂点までの最小コストを求めよ.

### 入力形式

- $n ~ m$
- $u_1 ~ v_1 ~ c_{uv}$
- $u_2 ~ v_2 ~ c_{uv}$
- $\vdots$
- $u_m ~ v_m ~ c_{uv}$

### 解答

@[cpp](graph.dij.ex.cc)

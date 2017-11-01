% graph.scc

有向グラフの強連結成分分解を行い、DAG を作る.
大まかにすることは、
元のグラフの頂点番号と、生成されたDAGの頂点番号を対応付けるベクトル `cmp` を見つけること.
DAG は元のグラフの隣接関係と `cmp` を見て構成できる.

## [graph.scc.rs](graph.scc.rs)
Rust 実装. グラフを隣接リストとして表現し、有向グラフを与えると `cmp` と DAG の組みを返す.
@[rust](graph.scc.rs)

## [graph.scc.cc](graph.scc.cc)
C++ 実装. class として定義してあり、コンストラクタで `cmp` のみ構成する.
`.dag()` メソッドで DAG を返す.
グラフは全て隣接リスト.
@[cpp](graph.scc.cc)

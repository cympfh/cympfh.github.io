# Bellman-Ford Algorithm

辺のコストに負数を許すグラフ最短路探索アルゴリズム.
計算量は $O(|E||V|)$ で, コストが全て正ならダイクストラ法の方が高速.

以下の実装では $u \rightarrow^c v$ ($c$ はコスト) という辺を `CostedEdge(u, v, Cost::Value(c))` で表現し,
`Vec<CostedEdge>` を渡すと `s` から `t` の最小コストを返す.
その途中に負の閉路がある場合はそれを検出して `Cost::MinusInfinity` を返すようにしている.

@[rust](graph.bellmanford.rs)

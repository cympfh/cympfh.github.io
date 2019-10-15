## 無向グラフの直径

### Warshall-Floyd を使う方法

全点対の最小距離の最大値が直径.
従ってそれを求めれば良い.
Warshall-Floyd を使うと $O(V^3)$.

@[rust](graph.undirected.diameter.warshall_floyd.rs)

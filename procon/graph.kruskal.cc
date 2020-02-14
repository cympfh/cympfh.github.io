/// @set.union_find.cc
int kruskal(int n, vvi&adj, vvi&cost) {
  int total = 0;
  UnionFind uf(n);
  using Edge = tuple<int, int, int>; // cost, from, to
  priority_queue<Edge, vector<Edge>, greater<Edge>> q; // minimize
  rep (u, n) {
    for (int v: adj[u]) {
      q.push(make_tuple(cost[u][v], u, v));
    }
  }
  while (not q.empty()) {
    Edge e = q.top(); q.pop();
    int c = get<0>(e);
    int u = get<1>(e),
        v = get<2>(e);
    if (uf.root(u) == uf.root(v)) continue;
    uf.merge(u, v);
    total += c;
  }
  return total;
}

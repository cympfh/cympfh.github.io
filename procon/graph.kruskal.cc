/// {{{
struct UnionFind {
  vector<int> table;
  UnionFind(int size) : table(size, -1) {}
  int root(int x) {
    if (table[x] < 0) return x;
    table[x] = root(table[x]);
    return table[x];
  }
  bool merge (int x, int y) {
    x = root(x); y = root(y);
    if (x != y) {
      if (table[y] < table[x]) swap(x, y);
      table[x] += table[y]; table[y] = x;
    }
    return x != y;
  }
};
/// }}}

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

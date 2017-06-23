/*
 * 木 (無向非巡回グラフ) について
 * 全ての点 (を根としたときの) からの最大距離 (高さ)
 *
 * O(|E|)
 */

using vi = vector<int>;
using vvi = vector<vi>;

// DFS with memo `t`
// t[i][j] は 点 i を根として 辺 (i, j) をパスのスタートにしたときの最大距離

int visit(const vvi& w, const vvi& neigh, vvi& t, int u, int v) {
  if (t[u][v] >= 0) return t[u][v];
  t[u][v] = w[u][v];
  for (int s: neigh[v]) {
    if (s == u) continue;
    t[u][v] = max(t[u][v], visit(w, neigh, t, v, s) + w[u][v]);
  }
  return t[u][v];
}

vi heights(int n, const vvi& neigh, const vvi& w) {
  vvi t(n, vi(n, -1));
  rep (u, n) {
    for (int v: neigh[u]) {
      if (t[u][v] >= 0) continue;
      t[u][v] = visit(w, neigh, t, u, v);
    }
  }
  vi ht(n);
  rep (i, n) for (int j: neigh[i]) ht[i] = max(ht[i], t[i][j]);
  return ht;
}

int main() {

  int n, m; cin >> n >> m;
  vvi w(n, vi(n, 0));
  vvi neigh(n);
  rep (_, m) {
    int a, b, c; cin >> a >> b >> c;
    --a; --b;
    w[a][b] = w[b][a] = c;
    neigh[a].push_back(b);
    neigh[b].push_back(a);
  }

  cout << heights(n, neigh, w) << endl;

  return 0;
}

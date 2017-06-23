struct MaxFlow {
  int n;
  vvi d, c;
  vector<int> level, iter;
  int flow;

  MaxFlow(vvi& _d, vvi& _c, int s, int t) {
    d = _d; c = _c;
    n = _d.size();
    level.resize(n);
    iter.resize(n);
    int cur_flow = 0;
    loop {
      bfs(s);
      if (level[t] < 0) { flow = cur_flow; return; }
      rep (i, n) iter[i] = 0;
      for (int f = 0;;) {
        f = dfs(s, t, inf);
        if (f <= 0) break;
        cur_flow += f;
      }
    }
  }

  int dfs(int v, int t, int f) {
    if (v == t) return f;
    for (int i = iter[v]; i < d[v].size(); ++i) {
      int u = d[v][i]; // v -> u
      if (c[v][u] > 0 and level[v] < level[u]) {
        int d = dfs(u, t, min(f, c[v][u]));
        if (d > 0) {
          c[v][u] -= d;
          c[u][v] += d;
          return d;
        }
      }
    }
    return 0;
  }

  void bfs(int s) {
    rep (i, n) level[i] = i == s ? 0 : -1;
    queue<int> q; q.push(s);
    while (not q.empty()) {
      int u = q.front(); q.pop();
      for (auto&v: d[u]) { // u -> v
        if (c[u][v] > 0 and level[v] < 0) {
          level[v] = level[u] + 1;
          q.push(v);
        }
      }
    }
  }
};


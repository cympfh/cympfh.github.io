int prim(int n, vvi&adj, vvi&cost) {
  vector<bool> used(n, false);
  queue<int> q;
  int total = 0;

  int u = rand() % n;
  vector<int> vs = { u };
  used[u] = true;
  loop {
    int mc = inf; // minimize
    int mu = -1, mv;
    for (int v: vs) {
      for (int u: adj[v]) {
        if (used[u]) continue;
        if (mc > cost[v][u]) {
          mc = cost[v][u];
          mv = v; mu = u;
        }
      }
    }
    if (mu < 0) {
      break;
    }
    used[mu] = true;
    vs.push_back(mu);
    total += mc;
  }
  return total;
}

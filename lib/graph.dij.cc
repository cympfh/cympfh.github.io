vi dij(vvi&neigh, vvi&cost, int s) {
  const int n = neigh.size();
  vi d(n, inf); d[s] = 0;
  priority_queue<pair<int, int>> q; q.push({0, s});
  while (not q.empty()) {
    int u = q.top().second; q.pop();
    for (int v: neigh[u]) {
      int d2 = d[u] + cost[u][v];
      if (d2 < d[v]) {
        d[v] = d2;
        q.push({ -d2, v });
      }
    }
  }
  return d;
}

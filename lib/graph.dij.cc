#define inf (1e18)
using Cost = long long;

vector<Cost>
dij(int s, vector<vector<pair<int, Cost>>> &neigh) {
  const int n = neigh.size();
  vector<Cost> d(n, inf); d[s] = 0;
  priority_queue<pair<Cost, int>> q; q.push({0, s});
  while (not q.empty()) {
    int u = q.top().second; q.pop();
    for (auto pair: neigh[u]) {
      int v = pair.first;
      Cost c = pair.second;
      if (d[v] > d[u] + c) {
        d[v] = d[u] + c;
        q.push({ -d[v], v });
      }
    }
  }
  return d;
}

int main() {
  int n, m; cin >> n >> m;
  vector<vector<pair<int, Cost>>> neigh(n);
  rep (i, m) {
    int u, v; cin >> u >> v; --u; --v;
    Cost c; cin >> c;
    neigh[u].emplace_back(v, c);
    neigh[v].emplace_back(u, c);
  }

  auto result = dij(0, neigh);
  cout << result << endl;

  return 0;
}

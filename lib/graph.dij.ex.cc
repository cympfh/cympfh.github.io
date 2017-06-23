int main() {
  int n, m; cin >> n >> m;
  vvi neigh(n);
  vvi cost(n, vi(n, 0));
  rep (i, m) {
    int a, b, c; cin >> a >> b >> c;
    --a; --b;
    neigh[a].push_back(b);
    cost[a][b] = cost[b][a] = c;
  }

  auto result = dij(neigh, cost, 0);
  cout << result << endl;

  return 0;
}

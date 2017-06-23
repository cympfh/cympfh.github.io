int main() {
  cin.tie(0);
  ios::sync_with_stdio(0);
  cout.setf(ios::fixed);
  cout.precision(10);

  stringstream input(
"  7"
"  0 6"
"  1 2"
"  1 4"
"  3 2"
"  5 2"
"  5 4"
"  0 1"
"  0 3"
"  0 5"
"  2 6"
"  4 6");
  int answer = 2;

  {
    int n; input >> n;
    int s, t; input >> s >> t;
    vvi d(n, vi(n));
    vvi c(n, vi(n, 0));
    loop {
      int a, b; input >> a >> b;
      if (not input) break;
      d[a].push_back(b);
      c[a][b] = 1;
    }
    MaxFlow mf(d, c, s, t);
    cout << mf.flow << endl;
    assert(mf.flow == answer);
  }

  stringstream input2(
"  6"
"  0 5"
"  0 1 3"
"  0 2 3"
"  1 2 2"
"  1 3 3"
"  2 4 2"
"  3 4 4"
"  3 5 2"
"  4 5 3");
  int answer2 = 5;
  {
    int n; input2 >> n;
    int s, t; input2 >> s >> t;
    vvi neighbor_list(n, vi(n));
    vvi capacity_table(n, vi(n, 0));
    loop {
      int a, b, c; input2 >> a >> b >> c;
      if (not input2) break;
      neighbor_list[a].push_back(b);
      capacity_table[a][b] = c;
    }
    MaxFlow mf(neighbor_list, capacity_table, s, t);
    cout << mf.flow << endl;
    assert(mf.flow == answer2);
  }
      

  return 0;
}

using vi = vector<int>;
using vvi = vector<vi>;
int main() {

  // this graph is an example
  // on the page: http://ja.wikipedia.org/wiki/プリム法
stringstream input(
"  7"
"  0 1 7"
"  0 3 5"
"  1 2 8"
"  1 3 9"
"  1 4 7"
"  2 4 5"
"  3 4 15"
"  3 5 6"
"  4 5 8"
"  4 6 9"
"  5 6 11");
  int answer = 39;
  
  {
    int n; input >> n;
    vvi adjacency_list(n);
    vvi cost_table(n, vi(n, inf));
    loop {
      int a, b, c; input >> a >> b >> c;
      if (not input) break;
      adjacency_list[a].push_back(b);
      adjacency_list[b].push_back(a);
      cost_table[a][b] = cost_table[b][a] = c;
    }

    assert(prim(n, adjacency_list, cost_table) == answer);
  }

  return 0;
}

/*
 * 参考; http://www.prefield.com/algorithm/container/union_find.html
 */

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
 

/*
 * Cramer の小行列式による再帰的計算
 * O(n!)
 */

Number det(Matrix a) {
  const int n = a.size();
  if (n == 1) return a[0][0];

  Matrix b(n-1, Vektor(n-1));
  Number d = 0;
  rep (i, n) {
    rep (bi, n-1) {
      rep (bj, n-1) {
        int ai = bi < i ? bi : (bi + 1);
        b[bi][bj] = a[ai][1 + bj];
      }
    }
    d += (i % 2 == 0 ? 1 : -1) * a[i][0] * det(b);
  }

  return d;
}

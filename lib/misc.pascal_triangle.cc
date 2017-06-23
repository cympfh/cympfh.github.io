/*
 * let cc = PascalTriangle(n);
 * Combination(m; k) = cc[m][k]
 * where 0 <= k <= m < n
 */

vector<vector<int>> PascalTriangle(int n)
{
  vector<vector<int>> cc(n);
  for (int i = 0; i < n; ++i) {
    cc[i].resize(i + 1);
    for (int j = 0; j <= i; ++j) {
      cc[i][j] =
        (!i || !j || i == j) ? 1 : cc[i-1][j] + cc[i-1][j-1];
    }
  }
  return cc;
}


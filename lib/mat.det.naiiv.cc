/*
 * 定義通りの行列式
 * O(n * n!)
 */

Number naiiv_det(Matrix a) {
  const int n = a.size();
  assert(a[0].size() == n);

  vector<int> pi(n);
  rep (i, n) pi[i] = i;

  Number d = 0;
  int sign = 0;
  do {
    sign = (sign + 1) % 4;
    Number prod = 1;
    rep (j, n) prod *= a[j][pi[j]];
    d += (sign < 2 ? 1 : -1) * prod;
  } while (next_permutation(begin(pi), end(pi)));

  return d;
}

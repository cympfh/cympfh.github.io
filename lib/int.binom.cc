tuple<int, int> ex_gcd(int x, int y) {
  int r0 = x, a0 = 1, b0 = 0;
  for (int r = y, a = 0, b = 1; r > 0; ) {
    int r2 = r0 % r;
    int a2 = a0 - r0 / r * a;
    int b2 = b0 - r0 / r * b;
    r0 = r; r = r2;
    a0 = a; a = a2;
    b0 = b; b = b2;
  }
  return make_tuple(a0, b0);
}

int mod_inv(int x, int m) {
  auto r = ex_gcd(x, m);
  int a = get<0>(r);
  while (a < 0) a += m;
  return a;
}

long comb(long n, long k, long m=1000000007) {
  if (k == 0) return 1;
  if (k == 1) return n % m;
  if (n - k < k) return comb(n, n - k, m);
  return (((comb(n - 1, k - 1, m) * n) % m) * mod_inv(k, m)) % m;
}

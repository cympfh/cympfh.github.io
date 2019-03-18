/*
 * a^{-1} (mod m)
 */

// {{{ src/int.exgcd.cc
tuple<int, int, int> ex_gcd(int x, int y) {
  int r0 = x, a0 = 1, b0 = 0;
  for (int r = y, a = 0, b = 1; r > 0; ) {
    int r2 = r0 % r;
    int a2 = a0 - r0 / r * a;
    int b2 = b0 - r0 / r * b;
    r0 = r; r = r2;
    a0 = a; a = a2;
    b0 = b; b = b2;
  }
  return make_tuple(a0, b0, r0);
}
// }}}

int mod_inv(int a, int m) {
  auto r = ex_gcd(a, m);
  if (get<2>(r) != 1) throw;
  int b = get<0>(r);
  while (b < 0) b += m;
  return b;
}

int main() {

  for (int m = 3; m < 100; ++m) {
    for (int a = 2; a < m; ++a) {
      if (__gcd(a, m) != 1) continue;
      int b = mod_inv(a, m);
      if (((a * b) % m) != 1) {
        cout << a << ' ' << b << ' ' << m << endl;
      }
      assert(((a * b) % m) == 1);
      assert(b > 0);
    }
  }

  return 0;
}

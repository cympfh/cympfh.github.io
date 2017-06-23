/*
 * 離散対数問題
 *
 * baby-step giant-step による方法
 *
 * x = dlog(a, b, m):
 * solve
 *   a^x == b (mod m)
 *
 */

// {{{
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

int mod_inv(int a, int m) {
  auto r = ex_gcd(a, m);
  if (get<2>(r) != 1) throw;
  int b = get<0>(r);
  while (b < 0) b += m;
  return b;
}
// }}}

/*
 * solve a^x = b (mod m)
 */
int dlog(int a, int b, int m) {
  map<int, int> pows;

  int ac = 1;
  int s = int(sqrt(m));
  int A = 1; // (pow a s)
  rep (i, s) {
    if (not pows.count(ac)) pows[ac] = i;
    ac  = (ac * a) % m;
    A = ac;
  }
  // cerr << "a^s = " << a << "^" << s << " = " << A << endl;
  A = mod_inv(A, m);
  // cerr << "a^{-s} = " << A << endl;
  ac = b;
  rep (i, s) {
    if (pows.count(ac)) {
      if (0)
      {
        int x = pows[ac], y = i;
        cerr << "a^x = " << a << '^' << x << endl;
        cerr << "b a^{-sy} = " << b << ' ' << a << "^{-" << s << ' ' << y << "} = " << ac << endl;
      }
      return pows[ac] + i*s;
    }
    ac = (ac * A) % m;
  }
  return -1;
}


/*
 * 離散フーリエ変換
 *
 * 長さ n の数列を別な長さ n の数列に変換する
 * O(n*log(n))
 */

using Real = long double;
const Real PI = acos(-1);
using C = complex<Real>;

vector<C>
fft(vector<C> f, int dir=1) {
  const int n = f.size();
  if (n < 2) return f;
  vector<C> f0(n/2), f1(n/2);
  rep (i, n/2) f0[i] = f[i*2], f1[i] = f[i*2 + 1];
  f0 = fft(f0, dir);
  f1 = fft(f1, dir);
  Real theta = 2 * PI / n;
  C z(cos(theta), dir * sin(theta)),
    ac = C(1, 0);
  rep (i, n) {
    f[i] = f0[i%(n/2)] + ac * f1[i%(n/2)];
    ac *= z;
  }
  return f;
}


// {{{
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
// }}}

vector<C>
convolution(vector<C> f, vector<C> g) {
  int n = std::max<unsigned>(f.size(), g.size());
  int m; for (m = 1; m < n; m <<= 1); m <<= 1;
  f.resize(m); g.resize(m);
  f = fft(f);
  g = fft(g);
  rep (i, m) f[i] *= g[i];
  auto fg = fft(f, -1);
  rep (i, m) fg[i] /= static_cast<Real>(m);
  return fg;
}

int main() {
  int n; cin >> n;
  vector<C> f(n+1), g(n+1);

  rep (i, n) {
    int a, b; cin >> a >> b;
    f[i+1] = C(a, 0);
    g[i+1] = C(b, 0);
  }

  vector<C> fg = convolution(f, g);
  const int m = fg.size();

  rep (i, 2 * n) {
    int a = round(fg[i+1].real());
    cout << a << endl;
  }

  return 0;
}

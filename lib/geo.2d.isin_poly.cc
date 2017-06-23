// {{{
enum CCW {
  FRONT,
  BACK,
  RIGHT,
  LEFT,
  ON
};

CCW ccw(const L&l, const P&p) {
  P u = l[0];
  P v = l[1];

  P dif = p - u;
  P dir = v - u;

  if (eq(0, dir.first)) {
    if (eq(0, dif.first)) {
      Real k = dif.second / dir.second;
      if (k > 1.0) return FRONT;
      if (k < 0.0) return BACK;
      return ON;
    } else {
      if (det(dir, dif) > 0.0) {
        return LEFT;
      }
      return RIGHT;
    }
  }

  Real k = dif.first / dir.first;
  if (eq(dir.second * k, dif.second)) {
    if (k > 1.0) return FRONT;
    if (k < 0.0) return BACK;
    return ON;
  } else {
    if (det(dir, dif) > 0.0) {
      return LEFT;
    }
    return RIGHT;
  }
}
// }}}

/*
 * 多角形 `poly` の内側に点 `p` があるかの判定
 * `poly` は整列した点列
 * 辺の上は false としていることに注意
 */
bool isin_poly(const vector<P>&poly, const P&p) {
  vector<L> edges;
  CCW c = ccw(L{poly[poly.size()-1], poly[0]}, p);
  if (c != RIGHT and c != LEFT) return false;
  rep (i, poly.size() - 1) {
    CCW d = ccw(L{poly[i], poly[i+1]}, p);
    if (c != d) return false;
  }
  return true;
}

int main() {
  cin.tie(0);
  ios::sync_with_stdio(0);
  cout.setf(ios::fixed);
  cout.precision(10);
  random_device dev;
  mt19937 rand(dev());

  vector<P> tri = {
    {0, 0}, {1, 0}, {1,1}
  };
  trace(isin_poly(tri, {0.5, 0.2})); // #t
  trace(isin_poly(tri, {0.5, 0.5})); // #f
  trace(isin_poly(tri, {0.5, 0.8})); // #f

  vector<P> rect = {
    {-1, -1}, {1, -1}, {1, 1}, {-1, 1}
  };
  trace(isin_poly(rect, {0, -1})); // #f
  trace(isin_poly(rect, {0, 0})); // #t
  trace(isin_poly(rect, {0, 1})); // #f

  {
    vector<P> rect = {
      {1, 0}, {0, 1}, {-1, 0}, {0, -1}
    };
    rep (_, 1000) {
      double x = (static_cast<int>(rand())%2000 - 1000) / 1000.0;
      double y = (static_cast<int>(rand())%2000 - 1000) / 1000.0;
      bool ans = abs(x) + abs(y) < 1.0;
      assert(isin_poly(rect, {x,y}) == ans);
    }
  }


  return 0;
}


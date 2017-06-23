/*
 * 有限点集合から凸包を求める
 * 返す点列は(x,y)でソートしただけのもの
 * 上包と下包を別々に出して最後にマージしてる
 */

// {{{
using Real = long double;
using P = pair<Real, Real>;
Real det(P a, P b) {
  return a.first * b.second - a.second * b.first;
}
// }}}

vector<P> covex_hull(vector<P> ps) {
  sort(begin(ps), end(ps));
  const int n = ps.size();
  vector<P> top, bot;
  { // top-hull
    rep (i, n) {
      while (true) {
        int m = top.size();
        if (m > 1 and det(ps[i] - top[m-2], top[m-1] - top[m-2]) >= 0) {
          top.pop_back();
        } else break;
      }
      top.push_back(ps[i]);
    }
  }
  { // bottom-hull
    rep (i, n) ps[i].second *= -1;
    sort(begin(ps), end(ps));
    rep (i, n) {
      while (true) {
        int m = bot.size();
        if (m > 1 and det(ps[i] - bot[m-2], bot[m-1] - bot[m-2]) >= 0) {
          bot.pop_back();
        } else break;
      }
      bot.push_back(ps[i]);
    }
    for (P&p: bot) p.second *= -1;
  }
  // trace(top); trace(bot);
  vector<P> ret;
  { // merge
    for (auto&p: top) ret.push_back(p);
    for (auto&p: bot) ret.push_back(p);
    sort(begin(ret), end(ret));
    ret.erase(unique(begin(ret), end(ret)), end(ret));
  }
  return ret;
}

int main() {

  vector<P> ps = {
    {10, 0}, {10, 10},
    {0, 0}, {0, 10}
  };
  rep (i, 100) {
    int x = rand() % 11;
    int y = rand() % 11;
    ps.push_back({x, y});
  }
  trace(ps);
  trace(covex_hull(ps));

  vector<P> qs = { {0, 0}, {0, 10}, {10, 0} };
  rep (i, 100) {
    int x = rand() % 11;
    int y = rand() % 11;
    if (x + y > 10) continue;
    qs.push_back({x, y});
  }
  trace(qs);
  trace(covex_hull(qs));

  return 0;
}

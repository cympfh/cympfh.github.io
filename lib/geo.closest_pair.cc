/*
 * 平面の上の最近点対を求める
 * 分割統治によるやり方
 * O(n * log(n) * log(n))
 *
 * 参考;  http://www.geeksforgeeks.org/closest-pair-of-points/
 */

pair<P, P> closest_point_pair(vector<P>&ps, bool sorted=false) {
  const int n = ps.size();
  if (not sorted) sort(begin(ps), end(ps));
  if (n < 5) {
    Real r = inf;
    P p, q;
    rep (i, n)
      rep (j, i) {
        Real d = Euclidean_distance(ps[i], ps[j]);
        if (r > d) r = d, p = ps[i], q = ps[j];
      }
    return {p, q};
  }
  pair<P, P> left_pair, right_pair;
  { // left sub-area
    vector<P> qs(n/2);
    rep (i, n/2) qs[i] = ps[i];
    left_pair = closest_point_pair(qs, true);
  }
  { // right sub-area
    vector<P> qs(n - n/2);
    rep (i, n-n/2) qs[i] = ps[n/2 + i];
    right_pair = closest_point_pair(qs, true);
  }
  Real left_min_d = Euclidean_distance(left_pair.first, left_pair.second),
       right_min_d = Euclidean_distance(right_pair.first, right_pair.second);
  Real min_d = min<Real>(left_min_d, right_min_d);
  P p, q;
  if (left_min_d < right_min_d) {
    p = left_pair.first; q = left_pair.second;
  } else {
    p = right_pair.first; q = right_pair.second;
  }
  Real lower_x = ps[n/2].first - min_d,
       upper_x = ps[n/2].first + min_d;
  // around the middle line
  vector<P> qs;
  rep (i, n)
    if (lower_x <= ps[i].first and ps[i].first <= upper_x)
      qs.push_back(ps[i]);
  sort(begin(qs), end(qs), [](P&p, P&q) { return p.second < q.second; });
  const int m = qs.size();
  Real r = min_d;
  rep (i, m) {
    for (int j = i+1; j <= i+7 and j < m; ++j) {
      Real d = Euclidean_distance(qs[i], qs[j]);
      if (d < r) r = d, p = qs[i], q = qs[j];
    }
  }
  return {p, q};
}

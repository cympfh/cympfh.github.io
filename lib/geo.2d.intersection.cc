/*
 * 線分 [p1, p2] と、[p3, p4] との交差判定
 *
 * ちょうど乗ってる場合は、`false`にしちゃってるので註意
 */

bool inter(P p1, P p2, P p3, P p4) {

  P p12 = p1 - p2;
  P p31 = p3 - p1;
  P p41 = p4 - p1;
  P p34 = p3 - p4;
  P p23 = p2 - p3;

  Real f1 = p12.first * p31.second - p12.second * p31.first;
  Real f2 = p12.first * p41.second - p12.second * p41.first;

  if (f1 * f2 >= 0) return false;

  Real f3 = - p34.first * p31.second + p34.second * p31.first;
  Real f4 = p34.first * p23.second - p34.second * p23.first;

  if (f3 * f4 >= 0) return false;

  return true;
}

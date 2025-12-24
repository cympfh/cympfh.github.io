/*
 * 三角形 (平面上の三点) から外接円の中心と半径をやる
 * http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=0010
 */

/* 外接円 */
struct Circumcenter {
  P x; // 外心
  Real r; // 半径
  Circumcenter(P p0, P p1, P p2) {
    Real a = Euclidean(p1, p2);
    Real b = Euclidean(p2, p0);
    Real c = Euclidean(p0, p1);
    Real A = a * a;
    Real B = b * b;
    Real C = c * c;

    Real den = 2 * (A * B + B * C + C * A) - (A * A + B * B + C * C);
    Real dec_a = A * (B + C - A);
    Real dec_b = B * (C + A - B);
    Real dec_c = C * (A + B - C);

    x = (dec_a * p0 + dec_b * p1 + dec_c * p2) / den;

    r = Euclidean(x, p0);
  }
};

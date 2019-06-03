enum circle_rel {
  SUB, SUP, // one contains the other
  TAN, // one intersection
  INT, // two intersections
  NOI // no intersection
};

circle_rel
circle_intersect(C a, C b) {
  Real d = Euclidean(a.o, b.o);
  if (d + a.r < b.r) return SUB; // a is in b
  if (a.r > d + b.r) return SUP; // b is in a
  if (d < a.r + b.r) return INT;
  if (d <= a.r + b.r + EPS) return TAN;
  return NOI;
}

Real triangle_area(P a, P b, P c) {
  P u = b - a;
  P v = c - a;
  return abs(det(u, v)) / 2.0;
}


enum CCW {
  FRONT,
  BACK,
  RIGHT,
  LEFT,
  ON
};

CCW ccw(L&l, P&p) {
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

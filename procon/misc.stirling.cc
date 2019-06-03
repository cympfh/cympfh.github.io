/* N.B.
 * const double PI = acos(-1);
 * const double E = exp(1);
 */

double stirling(int n) {
  double m = static_cast<double>(n);
  return sqrt(2 * PI * double(m)) * pow(m / E, n);
}

double lower_stirling(int n) {
  double m = static_cast<double>(n);
  return sqrt(2 * PI * double(m)) * pow(m / E, n) * exp(1.0 / (12 * m + 1));
}

double upper_stirling(int n) {
  if (n == 0) return 1.0; // defeats nan
  double m = static_cast<double>(n);
  return sqrt(2 * PI * double(m)) * pow(m / E, n) * exp(1.0 / 12 / m);
}

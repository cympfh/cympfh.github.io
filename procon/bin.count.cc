template<typename Func>
int bsearch(int left, int right, Func f) {
  while (left + 1 < right) {
    int mid = (left + right) / 2;
    if (f(mid) < 0) {
      left = mid;
    } else {
      right = mid;
    }
  }
  return right;
}

template<typename T>
int bcount(const vector<T>& xs, T x) {
  const int n = xs.size();
  auto f1 = [&](int i) { return xs[i] - x; };
  auto f2 = [&](int i) { return xs[i] - x - 1; };
  int r1 = xs[0] == x ? 0 : bsearch(0, n, f1);
  int r2 = xs[n-1] == x ? n : bsearch(0, n, f2);
  return r2 - r1;
}

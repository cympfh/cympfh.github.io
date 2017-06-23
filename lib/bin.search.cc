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

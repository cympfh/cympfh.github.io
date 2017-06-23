int shift_and(string text, string pattern) {
  using T = unsigned int;
  // using T = unsigned long

  const int n = text.size();
  const int m = pattern.size();
  assert(sizeof(T) * 8 >= m);

  const T M = 1 << (m - 1);
  T d[300] = {0};
  // map<char, T> d;

  rep (i, m) d[pattern[i]] ^= 1 << i;
  T x = 0;
  rep (i, n) {
    x = (1 | (x << 1)) & d[text[i]];
    if (x & M) return i - m + 1;
  }
  return -1;
}

bool* PrimeSieve(int n) {
  bool*s = new bool[n];
  for (int i = 0; i < n; ++i) s[i] = true;
  s[0] = s[1] = false;
  for (int i = 2; i * i <= n; ++i)
    if (s[i]) for (int j = i << 1; j < n; j += i) s[j] = false;
  return s;
}

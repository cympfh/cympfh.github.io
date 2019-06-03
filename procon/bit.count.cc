int
__builtin_popcount
(int);

int bit_count(long long x) {
  x = (x & 0x5555555555555555ll) + (x >> 1 & 0x5555555555555555ll);
  x = (x & 0x3333333333333333ll) + (x >> 2 & 0x3333333333333333ll);
  x = (x & 0x0f0f0f0f0f0f0f0fll) + (x >> 4 & 0x0f0f0f0f0f0f0f0fll);
  x = (x & 0x00ff00ff00ff00ffll) + (x >> 8 & 0x00ff00ff00ff00ffll);
  x = (x & 0x0000ffff0000ffffll) + (x >>16 & 0x0000ffff0000ffffll);
  x = (x & 0x00000000ffffffffll) + (x >>32 & 0x00000000ffffffffll);
  return x;
}

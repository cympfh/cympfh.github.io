template <typename T = int>
struct RMQ {
  vector<vector<T>> seg;
  vector<int> sizes;
  int N, K;
  RMQ(const vector<T>& v) {
    N = v.size();
    K = static_cast<int>(log2(N));
    seg.resize(K + 1);
    sizes.resize(K + 1);
    seg[0] = v;
    sizes[0] = 1;
    unsigned int s = 1;
    for (int k = 1; k <= K; ++k) {
      seg[k].resize(N - s - s + 1);
      for (int x = 0; x + s + s <= N; ++x) {
        seg[k][x] = std::max<T>(seg[k-1][x], seg[k-1][x + s]);
      }
      s <<= 1;
      sizes[k] = s;
    }
  }

  T max(int i, int j) { // [ i .. j ]
    if (i >= j) return seg[0][i];
    const int m = static_cast<int>(log2(j - i + 1));
    return std::max<T>(seg[m][i], seg[m][j - sizes[m] + 1]);
  }
};

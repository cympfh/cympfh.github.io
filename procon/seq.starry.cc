template<typename T=int>
struct SS {
  int N;
  T*ar_inc, *ar;
  SS(int n) {
    N = n;
    ar = new T[N*2];
    ar_inc = new T[N*2];
  }
  ~SS() {
    delete[] ar;
    delete[] ar_inc;
  }

  void add_sub(int l, int r, T x, int idx, int ll, int rr) {
    if (r <= ll or rr <= l) return;
    if (ll < l or r < rr) {
      add_sub(l, r, x, idx*2+1, ll, (ll+rr)/2);
      add_sub(l, r, x, idx*2+2, (ll+rr)/2, rr);
    } else {
      ar_inc[idx] += x;
      while (idx) {
        idx = (idx-1) / 2;
        int c1 = idx * 2 + 1,
            c2 = idx * 2 + 2;
        ar[idx] = std::max<T>(ar[c1]+ar_inc[c1], ar[c2]+ar_inc[c2]);
      }
    }
  }
  void add(int l, int r, T x) {
    add_sub(l, r, x, 0, 0, N);
  }

  T max_sub(int l, int r, int idx, int ll, int rr) {
    if (rr <= l or r <= ll) return -inf;
    if (l <= ll and rr <= r) return ar[idx] + ar_inc[idx];
    T left = max_sub(l, r, idx*2+1, ll, (ll+rr)/2);
    T right = max_sub(l, r, idx*2+2, (ll+rr)/2, rr);
    return std::max<T>(left, right) + ar_inc[idx];
  }
  T max(int l, int r) { return max_sub(l, r, 0, 0, N); }
};

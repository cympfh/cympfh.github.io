struct BIT {
  int N;
  int *ar;
  BIT(int n) {
    N = n;
    ar = new int[n+1];
    for(int i=0;i<n+1;ar[i++]=0);
  }
  ~BIT() {
    delete[] ar;
  }
  void add(int idx, int w) {
    for (int x = idx+1; x <= N; x += x&-x) {
      ar[x] += w;
    }
  }
  int sum_up(int idx) {
    int ret = 0;
    for (int x = idx; x > 0; x -= x&-x) {
      ret += ar[x];
    }
    return ret;
  }
  int sum(int left, int right) {  // [left, right)
      return sum_up(right) - sum_up(left);
  }
};

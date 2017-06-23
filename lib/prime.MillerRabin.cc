namespace Prime {
  template<typename Int>
  Int powmod(Int a, Int k, Int m) {
    if (k == 0) return 1;
    Int t = powmod(a, k/2, m);
    t = (t * t) % m;
    if (k&1) t = (t * a) % m;
    return t;
  }

  // Miller-Rabin test
  template<typename Int=int>
  bool test(Int n) {
    if (n<2) return false;
    if (n<4) return true;
    if (!(n&1)) return false;

    random_device dev;
    mt19937 rand(dev());
    Int d = n-1;
    while (!(d&1)) d/=2;
    rep (_, 100) {
      Int a = rand()%(n-1) + 1;
      Int y = powmod<Int>(a,d,n);
      Int t = d;
      while (t!=n-1 and y!=1 and y!=n-1) {
        y = (y * y) % n;
        t <<= 1;
      }
      if (y!=n-1 and !(t&1)) return false;
    }
    return true;
  }
}

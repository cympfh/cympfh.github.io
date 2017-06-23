
/*
 * 自然数 (非負整数) のビッグエンディアンなベクトル表現
 *
 * subst に注意
 */

struct Number {
  vector<int> ds;
  Number(){}
  Number (int n) {
    if (n == 0) {
      ds.resize(1);
      ds[0] = 0;
    } else {
      ds.resize(0);
        while (n > 0) {
          ds.push_back(n%10);
          n /= 10;
      }
    }
  }
  int& operator[](size_t i) { return ds[i]; }
  int operator[](size_t i) const { return ds[i]; }
  void resize(size_t i) { ds.resize(i); }
  size_t size() const { return ds.size(); }

  Number pred() {
    Number b = *this;
    if (b[0] > 0) {
      b[0]--;
    } else if (b.size() > 1) {
      b[0] = 9;
      b[1]--;
    }
    return b;
  }

  Number div(int n) {
    Number b; b.resize(ds.size());
    int carry = 0;
    for (int i = ds.size() - 1; i >= 0; --i) {
      int d = carry * 10 + ds[i];
      b[i] = d/n;
      carry = d%n;
    }
    return b;
  }

  Number subt(Number b) {
    int n = max<size_t>(ds.size(), b.size());
    Number c;
    ds.resize(n);
    b.resize(n);
    c.resize(n);
    int carry = 0;
    for (int i = 0; i < n; ++i) {
      int d = ds[i] + carry;
      if (d < b[i]) {
        c[i] = 10 + d - b[i];
        carry = -1;
      } else {
        c[i] = d - b[i];
        carry = 0;
      }
    }
    if (carry < 0) {
      return Number(0);
    }
    return c;
  }

};

istream& operator>>(istream&is, Number&a) {
  string s; is >> s;
  const int n = s.size();
  a.resize(n);
  for (int i = 0; i < n; ++i) {
    a[i] = s[n - 1 - i] - '0';
  }
  return is;
}

ostream& operator<<(ostream&os, const Number&a) {
  const int n = a.size();
  bool leading_zero = true;
  for (int i = 0; i < n; ++i) {
    int d = a[n-1-i];
    if (not leading_zero or d>0) {
      os << char('0'+d);
      leading_zero = false;
    }
  }
  if (leading_zero) os << '0';
  return os;
}

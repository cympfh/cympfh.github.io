/*
 * Young Tableaux アルゴリズム [A.Young 1900]
 * O(nlog(n))
 *
 * 数列の数字が全部違うと仮定してる
 * 同じのが含まれているときは*たぶん*狭義単調増加列になると思う
 *
 */

using vi = vector<int>;

vi lsi(vi xs) {
  vvi bins;
  vi bots;
  for (int x: xs) {
    auto it = lower_bound(begin(bots), end(bots), x);
    if (it == end(bots)) {
      bins.push_back({x});
      bots.push_back(x);
    } else {
      bins[it - begin(bots)].push_back(x);
      *it = x;
    }
  }
  int n = bots.size();
  vi ret(n);
  int x = inf;
  for (--n; n>=0; --n) {
    reverse(begin(bins[n]), end(bins[n]));
    x = *(lower_bound(begin(bins[n]), end(bins[n]), x) - 1);
    ret[n] = x;
  }
  return ret;
}

/*
 * 長さだけなら簡単
 */

int lsi_len(vi xs) {
  vi bots;
  for (int x: xs) {
    auto it = lower_bound(begin(bots), end(bots), x);
    if (it == end(bots)) {
      bots.push_back(x);
    } else {
      *it = x;
    }
  }
  return bots.size();
}


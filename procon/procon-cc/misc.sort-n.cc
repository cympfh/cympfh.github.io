/*
 * 文字列を整数と解釈してソート
 */

  {
    vector<string> ar = {
      "123",
      "1234",
      "1234",
      "90",
      "1111",
      "22222222222222222222222222222222222222222"
    };
    sort(begin(ar), end(ar), [](const string& s, const string& t) {
      if (s.size() != t.size()) return (s.size() < t.size());
      rep (i, s.size()) if (s[i] != t[i]) return (s[i] < t[i]);
      return true;
    });
    for (string s: ar) cout << s << endl;
  }

// 90
// 123
// 1111
// 1234
// 1234
// 22222222222222222222222222222222222222222

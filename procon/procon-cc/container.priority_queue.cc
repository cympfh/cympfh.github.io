
  {
    priority_queue<int> q;
    rep (i, 10) q.push(rand() % 10);
    vi v; while (q.size()) v.push_back( q.top() ), q.pop();
    trace(v); // 降順
  }

  {
    priority_queue<int,vector<int>,greater<int>> q;
    rep (i, 10) q.push(rand() % 10);
    vi v; while (q.size()) v.push_back( q.top() ), q.pop();
    trace(v); // 昇順
  }

  {
    // ペアのキュー
    priority_queue<pair<int,int>> q;
    rep (i, 10) q.push({rand() % 10, i});
    vector<pair<int,int>> v; while (q.size()) v.push_back( q.top() ), q.pop();
    trace(v); // 降順
  }

  {
    // ペアのキュー
    using P = pair<int, int>;
    priority_queue<P, vector<P>, greater<P>> q;
    rep (i, 10) q.push({rand() % 10, i});
    vector<pair<int,int>> v; while (q.size()) v.push_back( q.top() ), q.pop();
    trace(v); // 昇順
  }

  return 0;
}

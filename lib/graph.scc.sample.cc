#include <algorithm>
#include <array>
#include <bitset>
#include <ccomplex>
#include <cmath>
#include <complex>
#include <cstring>
#include <ctime>
#include <deque>
#include <exception>
#include <fstream>
#include <functional>
#include <iomanip>
#include <ios>
#include <iosfwd>
#include <iostream>
#include <istream>
#include <iterator>
#include <limits>
#include <list>
#include <locale>
#include <map>
#include <memory>
#include <new>
#include <numeric>
#include <ostream>
#include <queue>
#include <random>
#include <ratio>
#include <regex>
#include <set>
#include <sstream>
#include <stack>
#include <stdexcept>
#include <streambuf>
#include <string>
#include <tuple>
#include <typeinfo>
#include <unordered_map>
#include <unordered_set>
#include <utility>
#include <valarray>
#include <vector>

using namespace std;

#define iota(i,n,b,s) for(int i=int(b);(n)>0&&i!=int((b)+(s)*(n));i+=(s))
#define range(i,n,m) iota(i,(((n)>(m))?((n)-(m)+1):((m)-(n)+1)),(n),((n)>(m)?-1:1))
#define rep(i,n) iota(i,(n),0,1)

#define INF (1e9)
#define EPS (1e-9)
#define cons(a,b) (make_pair(a,b))
#define car(a) (a.first)
#define cdr(a) (a.second)
#define cadr(a) (car(cdr(a)))
#define cddr(a) (cdr(cdr(a)))
#define all(a) a.begin(), a.end()
#define trace(var) cerr<<">>> "<<#var<<" = "<<var<<endl;

typedef long long Integer;
typedef double Real;

template<class S, class T>
ostream& operator<<(ostream& os, pair<S,T> p) {
  os << '(' << car(p) << ", " << cdr(p) << ')';
  return os;
}

template<class T>
ostream& operator<<(ostream& os, vector<T> v) {
  os << v[0];
  for (int i=1, len=v.size(); i<len; ++i) os << ' ' << v[i];
  return os;
}

struct StronglyConnectedComponents {
  int N, K;

  vector<bool> used;
  vector<int> vs; // 帰り掛け順
  vector<vector<int>> arc;
  vector<vector<int>> arc_r;
  vector<int> cmp; // 連結成分

  void dfs(int v) {
    used[v] = true;
    for (int u : arc[v]) {
      if (!used[u]) dfs(u);
    }
    vs.push_back(v);
  }

  void rdfs(int v, int k) {
    cerr << "rdfs " << v << " " << k << endl;
    used[v] = true;
    cmp[v] = k;
    for (int u : arc_r[v]) {
      if (!used[u]) rdfs(u, k);
    }
  }

  StronglyConnectedComponents(vector<vector<int>>&d) {
    N = d.size();

    cmp.resize(N);
    arc.resize(N);
    arc_r.resize(N);
    rep (u, N) {
      for (int v : d[u]) {
        arc[u].push_back(v);
        arc_r[v].push_back(u);
      }
    }

    vs.clear();
    used = vector<bool>(N, false);
    rep (i, N) if (!used[i]) dfs(i);

    int k = 0;
    used = vector<bool>(N, false);
    trace(vs);
    reverse(all(vs));
    for (int u : vs) if (!used[u]) rdfs(u, k++);

    K = k;
  }

};

int main() {

 // graph by http://en.wikipedia.org/wiki/File:Scc.png
  stringstream ss("\
8 14\n\
1 2\n\
2 3\n\
2 5\n\
2 6\n\
3 4\n\
3 7\n\
4 3\n\
4 8\n\
5 1\n\
5 6\n\
6 7\n\
7 6\n\
8 7\n\
8 4");

  int n, m; ss >> n >> m;
  vector<vector<int>> d(n);

  rep (i, m) {
    int a, b; ss >> a >> b;
    --a; --b;
    d[a].push_back(b);
  }

  StronglyConnectedComponents scc(d);
  
  cout << scc.K << endl;
  cout << scc.cmp << endl;

  return 0;
}

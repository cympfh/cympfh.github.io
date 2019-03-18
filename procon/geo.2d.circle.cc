// {{{
#include <bits/stdc++.h>
using namespace std;
using Real = double;
using P = pair<Real, Real>;
// }}}

/*
 * 円を表現する
 */

struct C {
  P o;
  Real r;
  C(P o, Real r) : o(o), r(r) {}
  C(Real x, Real y, Real r) : o({x, y}), r(r) {}
};

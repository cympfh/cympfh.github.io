struct Var {
  int var;
  bool pol;
  Var(int v) : var(v), pol(true) {}
  Var(int v, bool b) : var(v), pol(b) {}
};
using Clause = vector<Var>;
using CNF = vector<Clause>;
using Assign = vector<bool>;

// {{{ debug print

ostream& operator<<(ostream&os, Var v) {
  if (v.pol) return os << 'x' << v.var;
  return os << "(not x" << v.var << ')';
}
 
ostream& operator<<(ostream&os, Clause&c) {
  os << "(or";
  for (auto&x: c) os << ' ' << x;
  return os << ')';
}

ostream& operator<<(ostream&os, CNF&c) {
  os << "(and " << c[0] << endl;;
  for (int i=1;i<c.size()-1;++i)
    os << "     " << c[i] << endl;
  os << "     " << c[c.size()-1] << ')';
  return os;
}
// }}}

bool is_satisfied(CNF&cnf, Assign&v) {
  for (auto&c: cnf) {
    bool bl = false;
    for (auto&x: c) if (v[x.var] == x.pol) { bl = true; break; }
    if (not bl) return false;
  }
  return true;
}

/* N.B.
 * when `cnf` is not satisfi-able,
 * `solve` returns dummy
 * check with `is_satisfied`
 */
Assign solve(CNF&cnf, int n, int R = 200) {
  random_device rd;
  mt19937 rand(rd());
  Assign a(n);
  rep (i, n) a[i] = rand()%2 == 0;

  rep (_, R) {
    rep (__, 3 * n) {
      vector<int> clauses;
      rep (i, cnf.size()) {
        auto&c = cnf[i];
        bool bl = false;
        for (auto&x: c) {
          if (a[x.var] == x.pol) { bl = true; break; }
        }
        if (bl) { continue; }
        else { clauses.push_back(i); }
      }
      int m = clauses.size();
      if (m == 0) return a;
      m = rand() % m;
      auto&c = cnf[clauses[m]];
      m = rand() % c.size();
      m = c[m].var;
      a[m] = not a[m];
    }
  }
  return a; // this not satisfy
}

void test(CNF&c, int n) {
  cout << "*" << endl;
  Assign a = solve(c, n);
  if (is_satisfied(c, a)) {
    cout << c << " is satisfiable and" << endl;
    cout << "proper assignment = " << a << endl;
  } else {
    cout << c << " is NOT satisfiable and" << endl;
  }
  cout << "*" << endl;
}

int main() {

  CNF c1 {
    Clause { Var(0), Var(1) },
    Clause { Var(0), Var(1, false) },
    Clause { Var(0, false), Var(1, false) }
  };
  test(c1, 2);

  CNF c2 {
    Clause { Var(0), Var(1) },
    Clause { Var(0), Var(1, false) },
    Clause { Var(0, false), Var(1) },
    Clause { Var(0, false), Var(1, false) }
  };
  test(c2, 2);

  CNF kyouseibi {
    Clause { Var(0), Var(1), Var(2) },
    Clause { Var(3), Var(1), Var(2, false) },
    Clause { Var(0, false), Var(3), Var(2) },
    Clause { Var(0, false), Var(3, false), Var(1) },
    Clause { Var(3, false), Var(1, false), Var(2) },
    Clause { Var(0, false), Var(1, false), Var(2, false) },
    Clause { Var(0), Var(3, false), Var(2, false) },
    Clause { Var(0), Var(3), Var(1, false) }
  };
  test(kyouseibi, 4);

  CNF kyouseibi_1 {
    Clause { Var(0), Var(1), Var(2) },
    Clause { Var(3), Var(1), Var(2, false) },
    Clause { Var(0, false), Var(3), Var(2) },
    Clause { Var(0, false), Var(3, false), Var(1) },
    Clause { Var(3, false), Var(1, false), Var(2) },
    Clause { Var(0, false), Var(1, false), Var(2, false) },
    Clause { Var(0), Var(3), Var(1, false) }
  };
  test(kyouseibi_1, 4);

  return 0;
}

using Real = long double;
const Real PI = acosl(-1);
using P = pair<Real, Real>; // Point
using L = pair<P, P>; // segment or line

/* inner dot */
Real dot(P&a, P&b) {
    return a.first * b.first + a.second * b.second;
}
Real operator*(P&a, P&b) {
    return a.first * b.first + a.second * b.second;
}

/* scalar multiple */
P operator*(P a, Real c) {
    return {c * a.first, c * a.second};
}
P operator*(Real c, P a) {
    return {c * a.first, c * a.second};
}

P operator/(P a, Real d) {
    return {a.first / d, a.second / d};
}

Real det(P a, P b) {
    return a.first * b.second - a.second * b.first;
}

/* vector operator */
P operator+(P a, P b) {
    return {a.first + b.first, a.second + b.second};
}

P operator-(P a) {
    return {-a.first, -a.second};
}

P operator-(P a, P b) {
    return {a.first - b.first, a.second - b.second};
}

/* distance */
Real Manhattan(P a, P b) {
    return abs(a.first - b.first) + abs(a.second - b.second);
}
Real Euclidean(P a, P b) {
    P p = a - b;
    return sqrt(p.first*p.first + p.second*p.second);
}

/* equality with eps (default: 1e-9) */
bool eq(Real x, Real y) {
    return abs(x - y) < eps;
}
bool operator==(P a, P b) {
    return eq(a.first, b.first) && eq(a.second, b.second);
}

int sign(Real a) {
    if (eq(a, 0)) return 0;
    return a > 0 ? 1 : -1;
}

Real magnitude(P p) {
    return sqrt(p.first*p.first + p.second*p.second);
}

Real arg(P a, P b) {
    Real x = dot(a, b) / magnitude(a) / magnitude(b);
    x = min<Real>(1, max<Real>(-1, x));
    return acos(x);
}

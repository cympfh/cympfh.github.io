/// Algebra - RMQ Act
// @algebra.monoid.rmq.rs
// @algebra.act.rs
#[derive(Debug, Clone, Copy)]
enum AssignInt<X> {
    None,   // Do Nothing
    Val(X), // Assign := x
    Fuck,   // Assign Extremum
}

impl<X: Copy> std::ops::Mul for AssignInt<X> {
    type Output = Self;
    fn mul(self, other: Self) -> Self {
        match (self, other) {
            (x, AssignInt::None) => x,
            _ => other,
        }
    }
}

impl<X: Copy> Monoid for AssignInt<X> {
    fn unit() -> Self {
        return AssignInt::None;
    }
}

impl<X: Copy> Act<MinInt<X>> for AssignInt<X> {
    fn act(&self, x: MinInt<X>) -> MinInt<X> {
        match (x, self) {
            (_, AssignInt::Fuck) => MinInt::Maximal,
            (_, AssignInt::Val(m)) => MinInt::Val(*m),
            _ => x,
        }
    }
}

impl<X: Copy> Act<MaxInt<X>> for AssignInt<X> {
    fn act(&self, x: MaxInt<X>) -> MaxInt<X> {
        match (x, self) {
            (_, AssignInt::Fuck) => MaxInt::Minimal,
            (_, AssignInt::Val(m)) => MaxInt::Val(*m),
            _ => x,
        }
    }
}

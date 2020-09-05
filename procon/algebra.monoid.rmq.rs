// Algebra - RMQ Monoid
// @algebra.monoid.rs
#[derive(Debug, Copy, Clone, PartialEq, Eq, PartialOrd, Ord)]
enum MaxInt<X> {
    Minimal,
    Val(X),
}
impl<X> MaxInt<X> {
    fn unwrap(self) -> X {
        if let Self::Val(x) = self {
            x
        } else {
            panic!();
        }
    }
}
impl<X: Ord> std::ops::Mul for MaxInt<X> {
    type Output = Self;
    fn mul(self, other: Self) -> Self {
        if self > other {
            self
        } else {
            other
        }
    }
}
impl<X: Ord + Copy> Monoid for MaxInt<X> {
    fn unit() -> Self {
        MaxInt::Minimal
    }
}

#[derive(Debug, Copy, Clone, PartialEq, Eq, PartialOrd, Ord)]
enum MinInt<X> {
    Val(X),
    Maximal,
}
impl<X> MinInt<X> {
    fn unwrap(self) -> X {
        if let Self::Val(x) = self {
            x
        } else {
            panic!();
        }
    }
}
impl<X: Ord> std::ops::Mul for MinInt<X> {
    type Output = Self;
    fn mul(self, other: Self) -> Self {
        if self < other {
            self
        } else {
            other
        }
    }
}
impl<X: Ord + Copy> Monoid for MinInt<X> {
    fn unit() -> Self {
        MinInt::Maximal
    }
}

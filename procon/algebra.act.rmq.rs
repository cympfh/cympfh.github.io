/// Algebra - RMQ Act
// @algebra.monoid.rmq.rs
// @algebra.act.rs
#[derive(Debug, Clone, Copy)]
enum Assign<X> {
    None,    // Do Nothing
    Just(X), // Assign := x
}
impl<X: Copy> std::ops::Mul for Assign<X> {
    type Output = Self;
    fn mul(self, other: Self) -> Self {
        match (self, other) {
            (x, Assign::None) => x,
            _ => other,
        }
    }
}
impl<X: Copy> Monoid for Assign<X> {
    fn unit() -> Self {
        return Assign::None;
    }
}
impl<X: Copy> Act<MinInt<X>> for Assign<MinInt<X>> {
    fn act(&self, x: MinInt<X>) -> MinInt<X> {
        if let &Assign::Just(z) = self {
            z
        } else {
            x
        }
    }
}
impl<X: Copy> Act<MaxInt<X>> for Assign<MaxInt<X>> {
    fn act(&self, x: MaxInt<X>) -> MaxInt<X> {
        if let &Assign::Just(z) = self {
            z
        } else {
            x
        }
    }
}

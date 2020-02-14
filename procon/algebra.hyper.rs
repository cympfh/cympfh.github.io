/// @algebra.group.rs
#[derive(PartialEq, Eq, PartialOrd, Ord, Clone, Copy, Debug)]
enum Hyper<X> { NegInf, Real(X), Inf }
use Hyper::{Real, NegInf, Inf};
impl<X: Group> std::ops::Add for Hyper<X> {
    type Output = Self;
    fn add(self, rhs: Hyper<X>) -> Hyper<X> {
        match (self, rhs) {
            (Real(x), Real(y)) => Real(x + y),
            (Inf, _) => Inf,
            (_, Inf) => Inf,
            _ => NegInf,
        }
    }
}
impl<X: Group> std::ops::Sub for Hyper<X> {
    type Output = Self;
    fn sub(self, rhs: Hyper<X>) -> Hyper<X> {
        self + (-rhs)
    }
}
impl<X: Group> std::ops::Neg for Hyper<X> {
    type Output = Self;
    fn neg(self) -> Hyper<X> {
        match self {
            Inf => NegInf,
            NegInf => Inf,
            Real(x) => Real(-x),
        }
    }
}

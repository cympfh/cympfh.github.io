#[derive(PartialEq, Eq, PartialOrd, Ord, Clone, Copy, Debug)]
enum HypInt {
    NegInf, Real(i64), Inf
}
use HypInt::{Real, NegInf, Inf};
use std::ops::{Add, Sub, Neg};
impl Add for HypInt {
    type Output = Self;
    fn add(self, rhs: HypInt) -> HypInt {
        match (self, rhs) {
            (Real(x), Real(y)) => Real(x + y),
            (Inf, _) => Inf,
            (_, Inf) => Inf,
            _ => NegInf,
        }
    }
}
impl Sub for HypInt {
    type Output = Self;
    fn sub(self, rhs: HypInt) -> HypInt {
        match (self, rhs) {
            (Real(x), Real(y)) => Real(x - y),
            (Inf, _) => Inf,
            (_, Inf) => NegInf,
            (NegInf, _) => NegInf,
            (_, NegInf) => Inf,
        }
    }
}
impl Neg for HypInt {
    type Output = Self;
    fn neg(self) -> HypInt {
        match self {
            Inf => NegInf,
            NegInf => Inf,
            Real(x) => Real(-x),
        }
    }
}

use std::ops::{Add, Mul};
use std::f64;
type K = f64;


#[derive(Debug, Clone, PartialEq)]
struct Complex(K, K);

#[allow(dead_code)]
impl Complex {
    fn zero() -> Complex { Complex(0.0, 0.0) }
    fn unit() -> Complex { Complex(1.0, 0.0) }
    fn i() -> Complex { Complex(0.0, 1.0) }
    fn scalar_mul(&self, k: K) -> Complex {
        Complex(self.0 * k, self.1 * k)
    }
}

// use std::ops::{Add, Mul};

impl<'t> Add<&'t Complex> for &'t Complex {
    type Output = Complex;
    fn add(self, right: &'t Complex) -> Complex {
        Complex(self.0 + right.0, self.1 + right.1)
    }
}

impl<'t> Mul<&'t Complex> for &'t Complex {
    type Output = Complex;
    fn mul(self, right: &'t Complex) -> Complex {
        Complex(self.0 * right.0 - self.1 * right.1,
                self.0 * right.1 + self.1 * right.0)
    }
}

impl<'t> Mul<&'t Complex> for K {
    type Output = Complex;
    fn mul(self, m: &'t Complex) -> Complex {
        m.scalar_mul(self)
    }
}

impl<'t> Mul<K> for &'t Complex {
    type Output = Complex;
    fn mul(self, k: K) -> Complex {
        self.scalar_mul(k)
    }
}

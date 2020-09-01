/// Algebra - Complex Number
// @algebra.ring.rs
#[derive(Debug, Clone, PartialEq, Eq)]
struct Complex<X>(X, X);

impl<X: Ring> Complex<X> {
    fn zero() -> Complex<X> {
        Complex(X::zero(), X::zero())
    }
    fn unit() -> Complex<X> {
        Complex(X::one(), X::zero())
    }
    fn i() -> Complex<X> {
        Complex(X::zero(), X::one())
    }
    fn real(&self) -> X {
        self.0
    }
    fn imag(&self) -> X {
        self.1
    }
    fn scalar_mul(&self, x: X) -> Self {
        Complex(self.0 * x, self.1 * x)
    }
    fn scalar_div(&self, x: X) -> Self {
        Complex(self.0 / x, self.1 / x)
    }
}

impl<X: Ring> std::ops::Add<&Complex<X>> for &Complex<X> {
    type Output = Complex<X>;
    fn add(self, right: &Complex<X>) -> Self::Output {
        Complex(self.0 + right.0, self.1 + right.1)
    }
}

impl<X: Ring> std::ops::Mul<&Complex<X>> for &Complex<X> {
    type Output = Complex<X>;
    fn mul(self, right: &Complex<X>) -> Self::Output {
        Complex(
            self.0 * right.0 - self.1 * right.1,
            self.0 * right.1 + self.1 * right.0,
        )
    }
}

impl std::ops::Mul<&Complex<i64>> for i64 {
    type Output = Complex<i64>;
    fn mul(self, m: &Complex<i64>) -> Self::Output {
        m.scalar_mul(self)
    }
}

impl std::ops::Mul<&Complex<f64>> for f64 {
    type Output = Complex<f64>;
    fn mul(self, m: &Complex<f64>) -> Self::Output {
        m.scalar_mul(self)
    }
}

impl<X: Ring> std::ops::Mul<X> for &Complex<X> {
    type Output = Complex<X>;
    fn mul(self, x: X) -> Self::Output {
        self.scalar_mul(x)
    }
}

impl<X: Ring> std::ops::Div<X> for &Complex<X> {
    type Output = Complex<X>;
    fn div(self, x: X) -> Self::Output {
        self.scalar_div(x)
    }
}

/// Algebra - Ratio
#[derive(Debug, Clone, Copy, PartialEq, Eq, Hash)]
struct Ratio(i64, i64); // Normalized (numerator / denominator)
impl Ratio {
    fn new(a: i64, b: i64) -> Self {
        let x = Self::gcd(a.abs(), b.abs());
        let sign = if b > 0 { 1 } else { -1 };
        Ratio(sign * a / x, sign * b / x)
    }
    fn inv(self) -> Self {
        Self::new(self.1, self.0)
    }
    fn gcd(a: i64, b: i64) -> i64 {
        if b == 0 {
            a
        } else {
            Self::gcd(b, a % b)
        }
    }
    fn lcm(a: i64, b: i64) -> i64 {
        a / Self::gcd(a, b) * b
    }
}
impl std::ops::Neg for Ratio {
    type Output = Self;
    fn neg(self) -> Self {
        Ratio(-self.0, self.1)
    }
}
impl std::ops::Add for Ratio {
    type Output = Self;
    fn add(self, other: Self) -> Self {
        let num = Self::lcm(self.1, other.1);
        Ratio(self.0 * num / self.1 + other.0 * num / other.1, num)
    }
}
impl std::ops::Sub for Ratio {
    type Output = Self;
    fn sub(self, other: Self) -> Self {
        self + (-other)
    }
}
impl std::ops::Mul for Ratio {
    type Output = Self;
    fn mul(self, other: Self) -> Self {
        Self::new(self.0 * other.0, self.1 * other.1)
    }
}
impl std::ops::Div for Ratio {
    type Output = Self;
    fn div(self, other: Self) -> Self {
        Self::new(self.0 * other.1, self.1 * other.0)
    }
}
impl PartialOrd for Ratio {
    fn partial_cmp(&self, other: &Self) -> Option<std::cmp::Ordering> {
        let left = self.0 * other.1;
        let right = other.0 * self.1;
        left.partial_cmp(&right)
    }
}
impl Ord for Ratio {
    fn cmp(&self, other: &Self) -> std::cmp::Ordering {
        self.partial_cmp(&other).unwrap()
    }
}

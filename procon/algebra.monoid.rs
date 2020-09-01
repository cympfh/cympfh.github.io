/// Algebra - Monoid
trait Monoid: std::ops::Mul<Output = Self> + Clone + Copy {
    fn unit() -> Self;
}
impl Monoid for i64 {
    fn unit() -> Self {
        0
    }
}
impl Monoid for f64 {
    fn unit() -> Self {
        0.0
    }
}

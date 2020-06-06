/// Algebra - Ring
// @algebra.group.rs
trait Ring: Group + std::ops::Mul<Output = Self> + std::ops::Div<Output = Self> {
    fn one() -> Self;
}
impl Ring for i32 {
    fn one() -> Self {
        1
    }
}
impl Ring for i64 {
    fn one() -> Self {
        1
    }
}
impl Ring for f32 {
    fn one() -> Self {
        1.0
    }
}
impl Ring for f64 {
    fn one() -> Self {
        1.0
    }
}

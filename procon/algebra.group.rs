trait Group: std::ops::Add<Output=Self> + std::ops::Sub<Output=Self> + std::ops::Neg<Output=Self>
    + std::iter::Sum + Clone + Copy {
    fn zero() -> Self;
}
impl Group for i64 { fn zero() -> Self { 0 }}
impl Group for f64 { fn zero() -> Self { 0.0 }}

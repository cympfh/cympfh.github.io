/// Geometry - Polar Coordinates System
#[derive(Debug, Clone, Copy, PartialEq)]
struct Polar {
    theta: f64,
    r: f64,
}
impl Polar {
    const PI: f64 = std::f64::consts::PI;
    const PI2: f64 = std::f64::consts::PI * 2.0;
    fn new(theta: f64, r: f64) -> Self {
        let mut t = theta;
        let r = if r >= 0.0 {
            r
        } else {
            t += Self::PI;
            -r
        };
        t %= Self::PI * 2.0;
        if t < 0.0 {
            t += Self::PI * 2.0;
        }
        Polar { theta: t, r }
    }
    fn distance(&self, other: &Self) -> f64 {
        (self.r.powi(2) + other.r.powi(2)
            - 2.0 * self.r * other.r * (self.theta - other.theta).abs().cos())
        .sqrt()
    }
}

/// Geometry - Definition of Point
#[derive(Debug, Clone, Copy)]
struct Point(f64, f64);

impl Point {
    fn norm(self) -> f64 {
        (self * self).sqrt()
    }
    fn det(self, other: Point) -> f64 {
        self.0 * other.1 - self.1 * other.0
    }
    fn arg(self) -> f64 {
        let x = self.0 / self.norm();
        (if x < -1.0 {
            -1.0
        } else if x > 1.0 {
            1.0
        } else {
            x
        } as f64)
            .acos()
    }
    fn zero() -> Point {
        Point(0.0, 0.0)
    }
}

impl PartialEq for Point {
    fn eq(&self, other: &Point) -> bool {
        let eps = 0.0001;
        (self.0 - other.0).abs() < eps && (self.1 - other.1).abs() < eps
    }
    fn ne(&self, other: &Point) -> bool {
        !(self == other)
    }
}
impl Eq for Point {}

impl std::ops::Add for Point {
    type Output = Point;
    fn add(self, other: Point) -> Point {
        Point(self.0 + other.0, self.1 + other.1)
    }
}

impl std::ops::Neg for Point {
    type Output = Point;
    fn neg(self) -> Point {
        Point(-self.0, -self.1)
    }
}

impl std::ops::Sub for Point {
    type Output = Point;
    fn sub(self, other: Point) -> Point {
        self + (-other)
    }
}

// scalar multiplication
impl std::ops::Mul<Point> for f64 {
    type Output = Point;
    fn mul(self, other: Point) -> Point {
        Point(self * other.0, self * other.1)
    }
}

impl std::ops::Mul<f64> for Point {
    type Output = Point;
    fn mul(self, other: f64) -> Point {
        Point(other * self.0, other * self.1)
    }
}

// inner-product
impl std::ops::Mul<Point> for Point {
    type Output = f64;
    fn mul(self, other: Point) -> f64 {
        self.0 * other.0 + self.1 * other.1
    }
}

impl std::ops::Div<f64> for Point {
    type Output = Point;
    fn div(self, other: f64) -> Point {
        Point(self.0 / other, self.1 / other)
    }
}

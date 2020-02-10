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
        (if x < -1.0 { -1.0 } else if x > 1.0 { 1.0 } else { x } as f64).acos()
    }
    fn zero() -> Point { Point(0.0, 0.0) }
    fn one() -> Point { Point(1.0, 1.0) }
}

use std::cmp::{PartialEq, Eq};
impl PartialEq for Point {
    fn eq(&self, other: &Point) -> bool {
        let eps = 0.0001;
        (self.0 - other.0).abs() < eps && (self.1 - other.1).abs() < eps
    }
    fn ne(&self, other: &Point) -> bool {
        !(self == other)
    }
}
impl Eq for Point { }

use std::ops::{Add, Sub, Neg, Mul, Div};
impl Add for Point {
    type Output = Point;
    fn add(self, other: Point) -> Point {
        Point(self.0 + other.0, self.1 + other.1)
    }
}

impl Neg for Point {
    type Output = Point;
    fn neg(self) -> Point {
        Point(-self.0, -self.1)
    }
}

impl Sub for Point {
    type Output = Point;
    fn sub(self, other: Point) -> Point {
        self + (-other)
    }
}

// scalar multiplication
impl Mul<Point> for f64 {
    type Output = Point;
    fn mul(self, other: Point) -> Point {
        Point(self * other.0, self * other.1)
    }
}

impl Mul<f64> for Point {
    type Output = Point;
    fn mul(self, other: f64) -> Point {
        Point(other * self.0, other * self.1)
    }
}

// inner-product
impl Mul<Point> for Point {
    type Output = f64;
    fn mul(self, other: Point) -> f64 {
        self.0 * other.0 + self.1 * other.1
    }
}

impl Div<f64> for Point {
    type Output = Point;
    fn div(self, other: f64) -> Point {
        Point(self.0 / other, self.1 / other)
    }
}

#[derive(Debug, Clone, Copy)]
struct Line(Point, Point);

impl Line {
    fn len(self) -> f64 {
        (self.0 - self.1).norm()
    }
    fn rev(self) -> Line {
        Line(self.1, self.0)
    }
}

#[derive(Debug, Clone, Copy)]
struct Circle(Point, f64);

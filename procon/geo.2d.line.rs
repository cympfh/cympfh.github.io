/// Geometry - Definition of Line
// @geo.2d.point.rs
#[derive(Debug, Clone, Copy)]
struct Line(Point, Point);

impl Line {
    fn distance_from(&self, p: Point) -> f64 {
        let u = p - self.0;
        let v = self.1 - self.0;
        (u.det(v) / v.norm()).abs()
    }
}

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
struct LineSegment(Point, Point);

impl LineSegment {
    fn to_line(&self) -> Line {
        Line(self.0, self.1)
    }
}

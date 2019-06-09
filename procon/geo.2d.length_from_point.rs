impl Line {
    fn length_from_point(self, p: Point) -> f64 {
        let u = p - self.0;
        let v = self.1 - self.0;
        (u.det(v) / v.norm()).abs()
    }
}

/// Geometry - Polygon
// @geo.2d.point.rs

#[derive(Debug, Clone)]
struct Polygon(Vec<Point>);

impl Polygon {
    fn len(&self) -> usize {
        self.0.len()
    }
}

impl std::ops::Index<usize> for Polygon {
    type Output = Point;
    fn index(&self, idx: usize) -> &Self::Output {
        &self.0[idx]
    }
}

impl Polygon {
    fn area(&self) -> f64 {
        (1..self.len() - 1)
            .map(|i| {
                let u = self[i] - self[0];
                let v = self[i + 1] - self[0];
                u.det(v).abs()
            })
            .sum::<f64>()
            / 2.0
    }
}

macro_rules! poly {
    ($($x:expr),+) => {{
        let v = vec![$($x),+];
        Polygon(v)
    }};
    ($($x:expr),+ ,) => (poly!($($x),+))
}

/// Geometry - CCW (直線と点の関係)
// @geo.2d.line.rs
#[derive(Debug, PartialEq, Eq, Clone, Copy)]
enum CCW {
    FRONT,
    BACK,
    RIGHT,
    LEFT,
    ON,
}
fn ccw(l: Line, p: Point) -> CCW {
    use CCW::*;
    fn equal(x: f64, y: f64) -> bool {
        (x - y).abs() < 0.00001
    }
    let dif = p - l.0;
    let dir = l.1 - l.0;
    if equal(0.0, dir.0) {
        if equal(0.0, dif.0) {
            let k = dif.1 / dir.1;
            if k > 1.0 {
                FRONT
            } else if k < 0.0 {
                BACK
            } else {
                ON
            }
        } else if dir.det(dif) > 0.0 {
            LEFT
        } else {
            RIGHT
        }
    } else {
        let k = dif.0 / dir.0;
        if equal(dir.1 * k, dif.1) {
            if k > 1.0 {
                FRONT
            } else if k < 0.0 {
                BACK
            } else {
                ON
            }
        } else {
            if dir.det(dif) > 0.0 {
                LEFT
            } else {
                RIGHT
            }
        }
    }
}

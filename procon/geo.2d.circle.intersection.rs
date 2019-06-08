#[derive(Debug)]
enum CircleRelation {
    EQUAL,
    SUB, SUP,  // one contains the other
    INTERSECTION(usize)  // intersection with `n` points
}

fn circle_relation(a: Circle, b: Circle) -> CircleRelation {
    use CircleRelation::*;
    let d = (a.0 - b.0).norm();
    let eps = 1e-9;
    if d < eps && (a.1 - b.1).abs() < eps {
        EQUAL
    } else if d + a.1 < b.1 {
        SUB
    } else if a.1 > d + b.1 {
        SUP
    } else if d < a.1 + b.1 {
        INTERSECTION(2)
    } else if d <= a.1 + b.1 + eps {
        INTERSECTION(1)
    } else {
        INTERSECTION(0)
    }
}

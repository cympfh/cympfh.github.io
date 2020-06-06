/// Binary Search
trait Integer {
    fn close(x: Self, y: Self) -> bool;
    fn middle(x: Self, y: Self) -> Self;
}
impl Integer for usize {
    fn close(x: Self, y: Self) -> bool { x + 1 >= y }
    fn middle(x: Self, y: Self) -> Self { (x + y) / 2 }
}
impl Integer for i64 {
    fn close(x: Self, y: Self) -> bool { x + 1 >= y }
    fn middle(x: Self, y: Self) -> Self { (x + y) / 2 }
}
impl Integer for f64 {
    fn close(x: Self, y: Self) -> bool { x + 0.00000001 >= y }
    fn middle(x: Self, y: Self) -> Self { (x + y) / 2.0 }
}

// the most left element in [l, r] such that prop holds
fn binsearch<X: Integer + Copy>(l: X, r: X, prop: &Fn(X) -> bool) -> X {
    if X::close(l, r) {
        r
    } else {
        let mid = X::middle(l, r);
        if prop(mid) {
            binsearch(l, mid, prop)
        } else {
            binsearch(mid, r, prop)
        }
    }
}

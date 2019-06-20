fn bsearch(xs: &Vec<i64>, x: i64) -> usize {
    if xs[0] >= x { return 0 }
    let mut left = 0;  // xs[left] < x
    let mut right = xs.len();  // xs[right] >= x
    while left + 2 <= right {
        let mid = (left + right) / 2;
        if xs[mid] < x {
            left = mid;
        } else {
            right = mid;
        }
    }
    right
}

fn bcount(xs: &Vec<i64>, x: i64) -> usize {
    bsearch(&xs, x + 1) - bsearch(&xs, x)
}

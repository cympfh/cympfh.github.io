fn runlength<A: Copy + PartialEq>(xs: &Vec<A>) -> Vec<(A, usize)> {
    let m = xs.len();
    if m == 0 { return vec![]; }
    let mut count = 1;
    let mut result = vec![];
    for i in 0..m {
        if i > 0 {
            if xs[i - 1] == xs[i] {
                count += 1;
            } else {
                count = 1;
            }
        }
        if i == m - 1 || xs[i] != xs[i + 1] {
            result.push((xs[i], count));
        }
    }
    result
}

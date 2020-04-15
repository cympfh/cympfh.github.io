fn prime_factorize(n: u64) -> Vec<(u64, usize)> {
    let mut m = n;
    let mut r = vec![];
    for x in 2..n + 1 {
        if m == 1 { break }
        if x * x > n { r.push((m, 1)); break }
        if n % x != 0 { continue }
        let mut c = 0;
        while m % x == 0 { m /= x; c += 1; }
        r.push((x, c));
    }
    r
}

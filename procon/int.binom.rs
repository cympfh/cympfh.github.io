/// Integer function - Binomial
fn ex_gcd(x: i64, y: i64) -> (i64, i64) {
    let mut r0 = x;
    let mut a0 = 1;
    let mut b0 = 0;

    let mut r = y;
    let mut a = 0;
    let mut b = 1;

    while r > 0 {
        let r2 = r0 % r;
        let a2 = a0 - r0 / r * a;
        let b2 = b0 - r0 / r * b;
        r0 = r; r = r2;
        a0 = a; a = a2;
        b0 = b; b = b2;
    }
    (a0, b0)
}

fn mod_inv(x: i64, m: i64) -> i64 {
    let mut a = ex_gcd(x, m).0;
    while a < 0 { a += m; }
    a
}

fn comb(n: i64, k: i64, m: i64) -> i64 {
    if k == 0 { return 1; }
    if k == 1 { return n % m; }
    if n - k < k { return comb(n, n - k, m); }
    let mut c = 1;
    for i in 0..k {
        c *= n - i; c %= m;
        c *= mod_inv(k - i, m); c %= m;
    }
    c
}


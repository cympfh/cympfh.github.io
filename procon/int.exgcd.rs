fn ex_gcd(x: i32, y: i32) -> (i32, i32, i32) {
    let mut r0 = x;
    let mut a0 = 1;
    let mut b0 = 0;
    let mut r = y;
    let mut a = 0;
    let mut b = 1;
    while r > 0 {
        let (r2, a2, b2) = (r0 % r, a0 - r0 / r * a, b0 - r0 / r * b);
        r0 = r; r = r2;
        a0 = a; a = a2;
        b0 = b; b = b2;
    }
    (a0, b0, r0)
}

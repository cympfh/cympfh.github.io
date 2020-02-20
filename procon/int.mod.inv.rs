/// Integer function - Inverse with Modulo
fn modinv(a: i64, m: i64) -> Option<i64> {
    fn exgcd(r0: i64, a0: i64, b0: i64, r: i64, a: i64, b: i64) -> (i64, i64, i64) {
        if r > 0 {
            exgcd(r, a, b, r0 % r, a0 - r0 / r * a, b0 - r0 / r * b)
        } else {
            (a0, b0, r0)
        }
    }
    let (a, _, r) = exgcd(a, 1, 0, m, 0, 1);
    if r != 1 {
        None
    } else {
        Some(((a % m) + m) % m)
    }
}

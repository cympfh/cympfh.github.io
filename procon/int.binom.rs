/// Integer function - Binomial (ModInt)
// @algebra.modint.rs
fn binom(n: ModInt, k: ModInt) -> ModInt {
    if k.0 == 0 {
        ModInt(1, n.1)
    } else if n.0 < k.0 * 2 {
        binom(n, n - k)
    } else {
        let mut c = ModInt(1, n.1);
        for i in 0..k.0 {
            c *= n - i;
            c /= k - i;
        }
        c
    }
}

/// Integer function - Binomial
// @algebra.modint.rs
fn binom(n: ModInt, k: ModInt) -> ModInt {
    if k.res == 0 {
        ModInt::new(1, n.md)
    }
    else if n.res < k.res * 2 {
        binom(n, n - k)
    }
    else {
        let mut c = ModInt::new(1, n.md);
        for i in 0..k.res {
            c *= n - i;
            c /= k - i;
        }
        c
    }
}

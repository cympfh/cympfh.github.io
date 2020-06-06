/// Prime numbres - Miller Rabin Test
// @rand.lcg.rs
// @int.mod.pow.rs

// is_prime?
fn mrtest(n: u64) -> bool {
    if n < 2 {
        false
    } else if n < 4 {
        true
    } else if n % 2 == 0 {
        false
    } else {
        let mut rand = Rand(0);
        let mut d = n - 1;
        while d % 2 == 0 { d /= 2 }
        for _ in 0..100 {
            let a = rand.next() % (n - 1) + 1;
            let mut y = powmod(a, d, n);
            let mut t = d;
            while t != n - 1 && y != 1 && y != n - 1 {
                y = (y * y) % n;
                t <<= 1;
            }
            if y != n - 1 && t % 2 == 0 {
                return false;
            }
        }
        true
    }
}

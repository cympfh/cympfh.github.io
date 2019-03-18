struct Rand(u64);
impl Rand {
    fn next(&mut self) -> u64 {
        let a = 1000000007;
        let b = 127;
        let m = 1 << 20;
        self.0 = (self.0 * a + b) % m;
        self.0
    }
}

fn powmod(a: u64, k: u64, m: u64) -> u64 {
    if k == 0 {
        1
    } else {
        let t = powmod(a, k / 2, m);
        let t2 = (t * t) % m;
        (t2 * (if a % 2 == 0 { 1 } else { a })) % m
    }
}

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

fn main() {
    const M: u64 = 127;
    let bl = mrtest(M);
    println!("{}", if bl { "YES" } else { "NO" });
}

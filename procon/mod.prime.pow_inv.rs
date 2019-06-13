fn powmod<K: Copy + std::ops::Mul<Output=K> + std::ops::Div<Output=K> + std::ops::Rem<Output=K>>
        (x: K, n: u64, m: K) -> K {
    if n == 0 {
        x / x
    } else if n == 1 {
        x % m
    } else {
        let y = powmod((x * x) % m, n / 2, m);
        if n % 2 == 0 {
            y
        } else {
            (y * x) % m
        }
    }
}

macro_rules! invmod {
    ($x:expr, $m:expr) => (powmod($x, ($m - 2) as u64, $m))
}


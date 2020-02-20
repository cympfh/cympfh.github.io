/// Integer function - Power with Modulo
fn powmod<K: std::ops::Add<Output=K>
    + std::ops::Div<Output=K>
    + std::ops::Mul<Output=K>
    + std::ops::Rem<Output=K>
    + Copy
    >(a: K, n: u64, m: K) -> K {
    if n == 0 {
        a / a
    } else if n == 1 {
        a % m
    } else {
        let y = powmod((a * a) % m, n / 2, m);
        if n % 2 == 0 {
            y
        } else {
            (y * a) % m
        }
    }
}

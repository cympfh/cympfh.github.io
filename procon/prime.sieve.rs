/// Prime numbres - Sieve of Eratosthenes
fn prime_sieve(n: usize) -> Vec<bool> {
    let mut s = vec![true; n];
    s[0] = false; s[1] = false;
    for i in 2..n {
        if i * i > n { break }
        if s[i] {
            for k in 2..(n+i-1)/i { s[k*i] = false }
        }
    }
    s
}

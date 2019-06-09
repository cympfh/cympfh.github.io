fn moebius(n: usize) -> Vec<i64> {
    let mut moe = vec![1; n];
    let mut prime = vec![true; n];
    moe[0] = 0;
    for i in 2..n {
        if !prime[i] { continue }
        moe[i] = -1;
        for j in 2..(n - 1) / i + 1 {
            moe[i * j] *= -1;
            prime[i * j] = false;
        }
        for j in 1..(n - 1) / i / i + 1 {
            moe[i * i * j] = 0;
        }
    }
    moe
}

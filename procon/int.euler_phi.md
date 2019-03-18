% int.euler_phi

オイラーの $\Phi$ 関数.
$\Phi(n)$ は $1$ 以上 $n$ 以下の $n$ と互いに素な自然数の個数.

```rust
fn euler_phi(n: i32) -> usize {
    let mut divs = vec![];
    {
        let mut m = n;
        for k in 2..n {
            if m % k == 0 { divs.push(k); }
            while m % k == 0 { m /= k; }
        }
    }

    let mut cx: i32 = 0;
    {
        let m = divs.len();
        for b in 1..(1<<m) {
            let d = (0..m).filter(|i| b & 1<<i > 0).fold(1, |ac, i| ac * divs[i]);
            let popcnt = (0..m).filter(|i| b & 1<<i > 0).collect::<Vec<_>>().len();
            cx += n / d * if popcnt % 2 == 1 { 1 } else { -1 };
        }
    }

    (n - cx) as usize
}
```

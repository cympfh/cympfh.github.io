# 素数 - エラトステネスの篩

## 概要

与えられた自然数 $N$ について, $N$ 未満の値について篩を行う.
計算量は $O(N \log N)$ で, 実際はこれより小さいらしい.

## 実装

```rust
let is_primes = prime_sieve(n);
is_primes[i] // i が素数かどうか
```

@[rust](procon-rs/src/num/prime/sieve.rs)

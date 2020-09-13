# 素数 - エラトステネスの篩

## 概要

与えられた自然数 $N$ について, $N$ 以下の値について篩を行う.
計算量は $O(N \log N)$ で, 実際はこれより小さいらしい.

@[rust](procon-rs/src/num/prime/sieve.rs)

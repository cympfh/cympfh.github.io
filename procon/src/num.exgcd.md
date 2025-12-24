# 自然数/整数 - 関数 - 拡張ユークリッド互除法

## 概要

$0$ でない整数の組 $(x, y)$ について、
$$ax + by = c$$
なる整数の組 $(a, b, c)$ を返す.
ここで $c = gcd(x, y)$.

@[rust](procon-rs/src/num/gcd_ex.rs)

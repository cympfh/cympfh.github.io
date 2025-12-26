# 自然数/整数 - 関数 - GCD

## 概要

2つの自然数/整数の最大公約数 (Greatest Common Divisor; GCD) を求める.

$$\gcd(a, b) = \begin{cases}
a & \text{ if } b = 0 \\
\gcd(b, a \bmod b) & \text{ otherwise }\end{cases}$$

## 実装

@[rust](procon-rs/src/num/gcd.rs)

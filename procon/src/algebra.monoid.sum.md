# 代数 - モノイド - Sum モノイド

## 概要
整数は和に関してモノイドになっている.
以下の実装では `i128` を整数と見なして, 和に関するモノイド
$(\mathrm{i128}, +, 0)$
を与える.

## 実装
@[rust](procon-rs/src/algebra/monoid_sum.rs)

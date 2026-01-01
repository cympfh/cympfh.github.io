# 自然数/整数 - その他定理 - 中国人剰余定理

## 概要

$N$ 個の整数ペア $(r_1, m_1), \ldots, (r_N, m_N)$ （ただし $m_i$ は非負）について
$$x = r_i \bmod m_i ~~ \forall i=1,2,\ldots,N$$
を満たすような整数 $x$ は存在するなら一般に
$$x = y \bmod z$$
の形で与えられる.

このライブラリは $(r_i, m_i)$ の列から $(y,z)$ を計算する.

@[rust](procon-rs/src/num/chinese_remainder_theorem.rs)

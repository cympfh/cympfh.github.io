# 素数 -  素因数分解

## 概要

自然数 $N$ を試し割りすることで素因数分解する.
適切にループを打ち切ることで $O(\sqrt{N})$.

## 実装

$n = \prod_{i} p_{i}^{e_{i}}$ と素因数分解できるとき, `factorize(n)` は `Vec<(p_i, e_i)>` を返す.

@[rust](procon-rs/src/num/prime/factorize.rs)

# 自然数/整数 - 関数 - オイラーの $\varphi$ 関数

## 参考

- [[https://ja.wikipedia.org/wiki/%E3%82%AA%E3%82%A4%E3%83%A9%E3%83%BC%E3%81%AE%CF%86%E9%96%A2%E6%95%B0]]

## 定義

$1$ 以上の自然数 $n$ について,
オイラーの関数 $\varphi(n)$ とは $1$ 以上 $n$ 以下の $n$ と互いに素な自然数の個数のこと.

$$\varphi(n) = \sum_{\substack{1 \leq k \leq n \\ \gcd(n,k) = 1}} 1.$$

## 性質

- $\varphi(1) = 1$
- $p$ が素数のとき $\varphi(p) = p - 1$
- $n = m_1 m_2$ であって $\gcd(m_1, m_2) = 1$ のとき,
  $$\varphi(n) = \varphi(m_1) \varphi(m_2).$$

## 実装

@[rust](procon-rs/src/num/euler_phi.rs)

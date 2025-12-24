# 代数 - 環

次を満たす代数系 $(X, 0, 1, \pm, \times)$ を環 (Ring) と呼ぶ.


- $(X, 0, \pm)$ が加法群
- $(X, 1, \times)$ がモノイド（逆元は無くて良い）
- 乗法が加法に関して分配的である: 任意の $a, b, c \in X$ について
  - $a \times (b + c) = (a \times b) + (a \times c)$
  - $(a + b) \times c = (a \times c) + (b \times c)$

`i64`, `f64` はそのまま環になっている.

## 実装
@[rust](procon-rs/src/algebra/ring.rs)

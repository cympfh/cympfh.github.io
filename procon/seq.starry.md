# Starry Sky Tree

## 概要

- 長さ $n$ の数列: $v = \{ v_0, v_1, \ldots, v_{n-1} \} = \{0,0,\ldots,0\}$
- 次の2つの操作が許される
    1.  `add(l, r, x)`: $v_i \leftarrow v_i + x$ for each $l \leq i \leq r$
    1.  `max(l, r)`: $\max \{ x_i : l \leq i \leq r \}$ を返す

## [seq.starry.cc](seq.starry.cc)

@[cpp](seq.starry.cc)

## Example

@[cpp](seq.starry.ex.cc)

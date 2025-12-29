# 近傍

## 概要

空間 $X$ の各点 $x \in X$ に対して,
その近傍 $\mathcal{N}(x) \subseteq X$
を与える.

特に頻出なものとしてグリッドグラフの近傍がある.

$$X = \{(i, j) \mid i \in [0, H), j \in [0, W) \}$$

- 4近傍: $\mathcal{N}_4(i, j) = \{(i-1, j), (i+1, j), (i, j-1), (i, j+1)\}$
    - ただし $X$ より外の点は含まない.
- 8近傍: $\mathcal{N}_8(i, j) = \mathcal{N}_4(i, j) \cup \{ (i-1, j-1), (i-1, j+1), (i+1, j-1), (i+1, j+1) \}$
    - ただし $X$ より外の点は含まない.

## 実装

例えば

```rust
let neigh = neightbor::Grid4(H, W);
for (ni, nj) in neigh.neighbors(i, j) {
    // (ni, nj) は (i, j) の4近傍の点
}
```

と使う.

@[rust](procon-rs/src/misc/neighbor.rs)

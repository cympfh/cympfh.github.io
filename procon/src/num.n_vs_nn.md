# 自然数/整数 - 関数 - N vs N2

## 定理

自然数とそのペアは同型:
$$\mathbb{N} \simeq \mathbb{N}^2.$$
以下の実装はこの同型写像を与える.

## 実装

$\mathbb N \to \mathbb N^2$ は $O(\sqrt{N})$,
$\mathbb N^2 \to \mathbb N$ は $O(1)$.

@[rust](procon-rs/src/num/n_sim_nn.rs)

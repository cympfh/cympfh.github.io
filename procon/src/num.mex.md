# 自然数/整数 - 関数 - 最小自由数 (最小除外数)

## 定義

（$0$ を含む）自然数の部分集合 $T$ について
次の関数を mex (minimum excludant) という.
$$\mathrm{mex}~(T) := \min (\mathbb N \setminus T).$$

例えば

- $\mathrm{mex}(\{\}) = 0$
- $\mathrm{mex}(\{0,1,2\}) = 3$
- $\mathrm{mex}(\{0,2\}) = 1$

## 実装

$T$ が有限集合で
$N = |T|$ とすると $\mathrm{mex}(T) \leq N$ なので,
$N$ 以下の数を列挙することで $O(N)$ で求められる.

@[rust](procon-rs/src/num/mex.rs)

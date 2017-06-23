% Exact Quantum Query Complexity of EXACT and THRESHOLD
% http://arxiv.org/abs/1302.1235
% 量子計算

qbit 列 $\{0, 1\}^n$ を入力とする、
二つの述語

- $EXACT_k^n$: ちょうど $k$ qbit が 1 である
- $THRESHOLD_k^n$: $k$ qbit 以上が 1 である

であって、
計算量 (観測の数?) が

$Q_E(EXACT_k^n) = \max \{ k, n - k \}$

$Q_E(Th_k^n) = \max \{ k, n - k + 1 \}$

のようなものを定めた。

ちなみに、PARITYを同様の計算量で行うものは引用にある。

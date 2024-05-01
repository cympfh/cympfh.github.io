# 数列 - Sparse Table

モノイド $(X, 1)$ が冪等性 $x \ast x = x$ を満たすときこの集合を冪等モノイドという.

冪等モノイド $X$ の数列

$$A = \left( a_1, a_2, \ldots, a_N \right); a_i \in X$$

について Sparse Table は次が出来る.

- 前処理; $O(N \log N)$
- クエリ処理; $O(1)$
    - 区間 $[\ell, r)$ に関する値の積の計算
    - $\Pi_{\ell \leq i \lt r} a_i = a_\ell \ast \cdots \ast a_{r-1}$
- **出来ないこと**
    - 数列の値を変更することはできない

## 実装

次のデータを持っている.

$$\mathrm{data}_\ell^k = \Pi_{[\ell, \ell + 2^k)} a_i.$$

任意の区間 $[\ell,r)$ についてはギリギリの大きさ $2^k$ を見つけたら,
$[\ell,r) = [\ell, \ell+2^k) \cup [r-2^k, r)$
という２つの区間の和で表現できることから

$$\mathrm{data}_\ell^k = \mathrm{data}_\ell^k \ast \mathrm{data}_{r-2^k}^k$$

と出来る.
ここで重なりについては冪等性を利用してることに注意.

@[rust](procon-rs/src/sequence/sparse_table.rs)

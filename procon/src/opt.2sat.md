# 最適化 - 2-SAT

## 概要

$n$ 個の真偽値変数 $x_0, x_1, \ldots, x_{n-1}$ に関する 2-CNF とは次で表される論理式のこと:
$$F = (v_1 \lor v_2) \land (v_3 \lor v_4) \land \cdots \land (v_{m-1} \lor v_m)$$
ただしここで $v_i$ は $x_j$ または $\lnot x_j$ を表すメタ変数.

$x_i$ に真偽値を割り当てたときに $F$ を真にできることを充足可能という.
特に 2-CNF $F$ が適切な変数割当によって充足可能かどうか判定する問題を 2-SAT という.

## 充足判定

- $F$ を NOT ($\lnot$), AND ($\land$) と IMPLY ($\implies$) のみを用いた論理式に変換する
    - $(A \lor B)$ は $(\lnot A \implies B) \land (\lnot B \implies A)$ に等価
- IMPLY グラフを構築する
    - 頂点は $x_i$ 及び $\lnot x_i$ の $2n$ 個
    - $A \implies B$ のときに有向エッジ $A \to B$ を張る
    - $A \lor B$ なら $\lnot A \to B$ と $\lnot B \to A$ のエッジを張る
- IMPLY グラフを今日連結成分分解 (SCC) したとき各連結成分は同値を表す
    - 一つの連結成分に属する頂点には同じ真偽値が割り当てればよい
    - ここで連結成分内に $x_i$ と $\lnot x_i$ が同時に属していたら矛盾
        - この場合のみ充足不可能

## 実装

### 使い方

```rust
let mut sat = TwoSAT::new(n); // 2CNF 上の変数 [0, 1, ..., n-1]
sat += clause2!(0 or 1);      // AND 条件の追加: ... and (0 or 1)
sat += clause2!(not 1 or 2);  // AND 条件の追加: ... and (not 1 or 2)
sat += clause2!(2 => not 1);  // AND 条件の追加: ... and (2 => not 1)
let res = sat.solve();        // 充足可能かどうか

// and! に書けるもの
clause2!([not] x or [not] y)
clause2!([not] x => [not] y)
clause2!([not] x <=> [not] y)
clause2!([not] x)
```

@[rust](./procon-rs/src/opt/two_sat.rs)

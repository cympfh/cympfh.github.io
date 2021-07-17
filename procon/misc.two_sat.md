# 2-SAT

## 概要

$n$ 個の真偽値変数 $x_1, x_2, \ldots, x_n$ に関する 2-CNF とは次で表される論理式のこと:
$$F = (v_1 \lor v_2) \land (v_3 \lor v_4) \land \cdots \land (v_{m-1} \lor v_m)$$
ただしここで $v_i$ は $x_j$ または $\lnot x_j$.

この式 $F$ が適切な変数割当によって充足可能かどうか判定する問題を 2-SAT という.

## 充足判定

- $(A \lor B) \equiv (\lnot A \implies B) \equiv (\lnot B \implies A)$ であることを用いて 2-CNF を $\land$ と $\implies$ の式に変換する.
    - 都合上 $(A \lor B)$ を $(\lnot A \implies B) \land (\lnot B \implies A)$ に置き換える.
- implication graph を構築する
    - $x_i$ 及び $\lnot x_i$ が頂点
    - $A \implies B$ のときに有向エッジ $A \to B$ を張る
- SCC したとき各連結成分は同値を表す
    - その中に $x_i$ と $\lnot x_i$ が同時に属するかどうかが充足可能性
        - 属する $\iff$ 充足不可能

## 実装

@[rust](./procon-rs/src/misc/two_sat.rs)

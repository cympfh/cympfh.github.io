# SeqSearch (by accumulate arrays)

列について範囲を指定して要素の検索を行う.
複数ある場合は最も左にあるものを返す.

- 計算量
    - 検索は要素ごとに前処理 $O(N)$ と二分探索 $O(\log N)$
        - 個数の累積和を作って持っておく
        - 途中で列の変更は出来ない
    - 毎回異なる要素で検索すると毎度 $O(N)$ 掛かるので注意
- 使い方
    - `let mut ss = SeqSearch::new(&v)`
        - where $v = \left[ v_0, v_1, \ldots, v_{n-1} \right]$
    - `ss.search(a, i..j)`
        - $\min \{ k \mid i \leq k < j, v_k = a \}$
            - where $0 \leq i \leq j < n$

## [[seq.search.rs]]

@[rust](seq.search.rs)

## 例題

- [ABC 138 - Strings of Impurity](https://atcoder.jp/contests/abc138/tasks/abc138_e)
    - [submissions/7013148](https://atcoder.jp/contests/abc138/submissions/7013148)

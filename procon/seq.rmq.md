# seq.rmq

セグメント木による Range Maximum/Minimum Query (RMQ) の実装を与える.

## [[seq.rmq.rs]]

- 使い方
    - `let mut rmq = RMQ::new(v)`
        - where $v = \left[ v_0, v_1, \ldots, v_{n-1} \right]$
    - クエリ
        - `rmq.max(i..j)`
            - $\max \{ v_k \mid i \leq k < j \}$
        - `rmq.min(i..j)`
            - $\min \{ v_k \mid i \leq k < j \}$
    - 更新
        - 代入 `rmq.update(k, x)`
            - $v_k \leftarrow x$
        - 加算 `rmq.add(k, x)`
            - $v_k \leftarrow v_k + x$
    - データアクセス
        - インデックス `rmq[k]`
        - リストに戻す `rmq.to_vec()`

@[rust](seq.rmq.rs)

## [[seq.rmq.cc]]

最大値クエリのみ対応

@[cpp](seq.rmq.cc)

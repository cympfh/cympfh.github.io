# seq.rmq

セグメント木による Range Maximum/Minimum Query (RMQ) の実装を与える.

## [seq.rmq.rs](seq.rmq.rs)

- `let mut rmq = RMQ::new(v)`
- 最大値/最小値クエリ
    - `rmq.max(i..j)`, `rmq.min(i..j)`
    - range は普通に半開区間 $[i,j)$ を意味する
- 更新
    - 代入 `rmq.update(idx, x)`
    - 加算 `rmq.add(idx, x)`
- データアクセス
    - インデックス `rmq[idx]`
    - リストに戻す `rmq.to_vec()`

@[rust](seq.rmq.rs)

## [seq.rmq.cc](seq.rmq.cc)

最大値クエリのみ対応.

@[cpp](seq.rmq.cc)

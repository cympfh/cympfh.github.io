# 代数 - Float

Rust の `f64` は安全性のために半順序と半同値までしか与えられない.
`Float` はこの安全性に目をつぶり, 全順序 `Ord` と全同値 `Eq` を与える.
エイリアスとして次の2つを提供する.

この着想は
[[https://qiita.com/hatoo@github/items/fa14ad36a1b568d14f3e]]
から得ました.
作者の `@hatoo` さんに感謝します.

@[rust](procon-rs/src/num/float.rs)

# 代数 - 全順序化

提供する `Total` は半順序 `ParitalOrd` のみ与えられている型に全順序 `Ord` を与える.
同様に半同値 `PartialOrd` のみ与えられているときに, 全同値 `Eq` を与える.

特に Rust の `f64` は安全性のために半順序と半同値までしか与えられない.
エイリアスとして次の2つを提供する.

- `type Float = Total<f64>`
- `fn float(x: f64) -> Float`

このコードは
[qiita.com/hatoo@github/items/fa14ad36a1b568d14f3e](https://qiita.com/hatoo@github/items/fa14ad36a1b568d14f3e)
から拝借しています.
作者の `@hatoo` さんに感謝します.

@[rust](procon-rs/src/algebra/total.rs)

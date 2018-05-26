% 累積和 (Cumulative sum)

## 概要

$$\{ a_0, a_1,\ldots, a_n \} \mapsto \{ a_0, (a_0+a_1), \ldots, \sum_{i=0}^n a_n \}$$

- 配列を静的に渡して後から変更はできない
- 範囲の合計を返すメソッドを提供する

## [seq.cumsum.rs](seq.cumsum.rs)

@[rust](seq.cumsum.rs)

@[rust](seq.cumsum.main.rs)

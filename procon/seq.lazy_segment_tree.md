# 遅延セグメントツリー

モノイド $X$ 上の数列に対する更新操作をモノイド作用 $M$ だとしてこれを遅延評価することで区間に対する更新も $O(\log N)$ で出来るようになったセグメントツリー.

@[rust](seq.lazy_segment_tree.rs)

## 例題

- [ABC177/F](https://atcoder.jp/contests/abc177/submissions/16522911)
- [AtCoder Library Practice Contest/L](https://atcoder.jp/contests/practice2/submissions/16577269)

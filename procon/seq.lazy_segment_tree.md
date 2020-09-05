# 遅延セグメントツリー

モノイド $X$ 上の数列に対する更新操作をモノイド作用 $M$ だとしてこれを遅延評価することで区間に対する更新も $O(\log N)$ で出来るようになったセグメントツリー.

@[rust](seq.lazy_segment_tree.rs)

## 例題

- [atcoder.jp/contests/abc177/submissions/16522911](https://atcoder.jp/contests/abc177/submissions/16522911)

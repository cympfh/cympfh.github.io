# 数列 - 遅延伝播セグメントツリー (遅延セグ木)

## 概要

モノイド $(X, \times)$ とその上のモノイド（右）作用 $M$ があるとする.
$$\ast \colon X \times M \to X$$
ただし次の準同型を要請する.

- $(x_1 \times x_2) \ast m = (x_1 \ast m) \times (x_2 \ast m)$
- $x \ast (m_1 m_2) = (x \ast m_1) \ast m_2$

このとき $X$ 上の数列
$$(x_1, \ldots, x_N \mid x_i \in X)$$
について, 次の操作がそれぞれ $O(\log N)$ で出来る.

- 区間積の計算
    - 添字区間 $I$ について $\prod_{i \in I} x_i$
- 区間更新
    - 添字区間 $I$ と作用 $m \in M$ について
        - 各 $i \in I$ に対して $x_i \leftarrow x_i \ast m$

[セグメントツリー](seq.segment_tree) では一点に対する代入だったものを,
区間すべての要素に対するモノイド作用に一般化されてある.

## 関連リンク

- モノイド作用と実装の詳細: [/aiura/monoidic-act-and-lazy-segment-tree](https://cympfh.cc/aiura/monoidic-act-and-lazy-segment-tree)
- 各問題への適用例: [/taglibro/2020/09/09](https://cympfh.cc/taglibro/2020/09/09)

## 例題

- [ABC177/F](https://atcoder.jp/contests/abc177/submissions/16522911)
- [AtCoder Library Practice Contest/L](https://atcoder.jp/contests/practice2/submissions/16577269)

@[rust](procon-rs/src/sequence/tree/lazy_segment_tree.rs)

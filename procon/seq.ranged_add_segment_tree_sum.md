# 数列 - 区間加算 加法セグメントツリー

## 概要

`i64` の数列について次の2つが高速に操作できる

- 区間の **和** の計算
    - 添字区間 $I$ について, $\sum \{ x_i \mid i \in I\}$
- 区間への **加算**
    - 添字区間 $I$ について, $x_i \leftarrow x_i + x$ for each $i \in I$

## 実装について

以下の実装では直接 `i64` の受け渡しできるAPIを提供している.
中身は加法モノイドと加法作用を [遅延セグメントツリー](seq.lazy_segment_tree) に載せて実装してある.
加法モノイド `CountedSum` はその和だけではなく個数も同時に持っておくことで作用が準同型になっている.
`CountedSum` には強引に単位元をもたせることでモノイドになってはいるが,
あまり自然な定義になっておらず,
そのために単位元で初期化する `::new()` コンストラクタをわざと提供しない.

@[rust](procon-rs/src/sequence/tree/ranged_add_segment_tree_sum.rs)
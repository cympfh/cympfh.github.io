# 数列 - 区間更新 RMQ

## 概要

群 $X$ 上の数列について次の2つが高速に計算可能:

- 区間取得
    - 任意の区間の値の全ての積（和）を計算する
- 区間更新（代入操作）
    - 任意の区間の値をある値で上書きする

@[rust](procon-rs/src/sequence/tree/ranged_rmq.rs)
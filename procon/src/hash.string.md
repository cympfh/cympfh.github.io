# 文字列ハッシュ

## 概要

[Zobrist Hash](hash.zobrist.html) と
[Rolling Hash](hash.rolling.html) との両方を使った文字列ハッシュの実装例.

- 操作
    - 初期値は空文字列
    - 一文字を先頭・末尾に追加・削除が $O(1)$ で可能
    - （ハッシュ済み）文字列同士の連結が $O(1)$ で可能
    - `==`, `!=` 演算子で文字列同士の等価比較が $O(1)$ で可能
- 耐久性
    - アルファベット表 `char -> i128` のマッピングをランダムに生成

## 実装

@[rust](procon-rs/src/hash/string.rs)

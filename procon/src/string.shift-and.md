# 文字列 - 検索 - Shift-And アルゴリズム

## 概要

文字列 `text`, `pattern` について, `text` 中で `pattern` が（連続）部分文字列として初めて出現する位置を返す.
各ビット演算が $O(1)$ だとするとき, これは `text` の長さ $n$ に対して $O(n)$ で計算完了する.

## 入出力

`pattern` の長さは 128 以下 (`u128` を使っている為) であることを制約とする.

@[rust](procon-rs/src/string/shiftand.rs)

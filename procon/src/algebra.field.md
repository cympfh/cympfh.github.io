# 代数 - field

[環](algebra.ring) (`crate::algebra::ring::Ring`) に割り算 (`std::ops::Div`) を加えて要請したものを体 (Field) と呼ぶ.
ただし $0$ (`AGroup::zero()`) の逆元は定義しないものとする.

## 実装
@[rust](procon-rs/src/algebra/field.rs)

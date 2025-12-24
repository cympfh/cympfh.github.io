# 二次元ユークリッド幾何 - 直線, 線分の定義

## 概要

- 直線 `Line` と線分 `LineSegment` の定義
    - 直線は端点を持たず通る二点で定義する
        - `line!(x0, y0; x1, y1)`
    - 線分は2つの端点とその方向から定められる
        - `line!(x0, y0 => x1, y1)`
- 点までの距離 `::distance_from`
- 同値 `==`, `!=`
- 線分についてその向きを変える `-`

## 実装

@[rust](procon-rs/src/geometry2d/line.rs)

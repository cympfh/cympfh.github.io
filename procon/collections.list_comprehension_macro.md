# collections - リスト内包表記マクロ

## 使い方

```rust
list! {
    (expression);
    $(
        (for-range);
        (if-condition);
    );*
}
```

式間の区切りは全てセミコロン (`;`).
一番最後のセミコロンはあっても無くても良い.

## 例

```rust
list! {
    x;
    for x in 0..10
}
```

```rust
list! {
    x;
    for x in 0..10;
    if x % 2 == 0
}
```

`for` と `if` は上から順に実行される.
必要ならば早めに `if` でフィルタできる.

```rust
list! {
    (x, y);
    for x in 0..10;
    if x % 2 == 0;
    for y in x..20;
    if y % 2 == 0
}
```

```rust
list! {
    (x, y, z);
    for x in 1..100;
    for y in x..100;
    for z in y..x + y;
    if x * x + y * y == z * z;
}
```

@[rust](procon-rs/src/collections/list_macro.rs)

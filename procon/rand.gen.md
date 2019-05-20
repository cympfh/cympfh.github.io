# 疑似乱数

## Rust

標準には擬似乱数生成ライブラリが入ってないので.
以下は [Wikipedia:Xorshift](https://ja.wikipedia.org/wiki/Xorshift) の `xor64` の実装.

@[rust](rand.gen.rs)

```rust
fn main() {
    let mut rand = XorShift::new();
    println!("u64: {}", rand.gen::<u64>());
    println!("i64: {}", rand.gen::<i64>());
    println!("u32: {}", rand.gen::<u32>());
    println!("i32: {}", rand.gen::<i32>());
    println!("f64: {}", rand.gen::<f64>());
    println!("f32: {}", rand.gen::<f32>());
}
```


# 疑似乱数

## Rust

標準には擬似乱数生成ライブラリが入ってないので.
以下は [Wikipedia:Xorshift](https://ja.wikipedia.org/wiki/Xorshift) の `xor64` の実装.

```rust
use std::u64;

pub trait FromU64 {
    fn coerce(x: u64) -> Self;
}

// cast
impl FromU64 for u64 { fn coerce(x: u64) -> Self { x } }
impl FromU64 for i64 { fn coerce(x: u64) -> Self { x as i64 } }
impl FromU64 for u32 { fn coerce(x: u64) -> Self { x as u32 } }
impl FromU64 for i32 { fn coerce(x: u64) -> Self { x as i32 } }

// returns [0, 1]
impl FromU64 for f64 {
    fn coerce(x: u64) -> Self {
        (x as f64) / (u64::MAX as f64)
    }
}
impl FromU64 for f32 {
    fn coerce(x: u64) -> Self {
        (x as f32) / (u64::MAX as f32)
    }
}

struct XorShift(u64);

impl XorShift {
    fn new() -> Self {
        XorShift(88172645463325252)
    }
    fn next(&mut self) -> u64 {
        let mut x = self.0;
        x = x ^ (x << 13);
        x = x ^ (x >> 7);
        x = x ^ (x << 17);
        self.0 = x;
        x
    }
    fn gen<T: FromU64>(&mut self) -> T {
        FromU64::coerce(self.next())
    }
}

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


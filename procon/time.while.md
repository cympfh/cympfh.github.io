# 制限時間付きループ

## 概要

```rust
loop {
   ...
}
```

の代わりに,

```rust
let milli_seconds = 1000
loop_timeout_ms!(milli_seconds, {
    ...
}
```

と使う

## 例

```rust
// Example
fn slow_yes() {
    use std::time::Duration;
    use std::thread::sleep;
    println!("yes");
    sleep(Duration::new(0, 100000000));
}

fn main() {
    loop_timeout_ms!(3000; {
        slow_yes();
    });
}
```

@[rust](procon-rs/src/datetime/timed_loop.rs)

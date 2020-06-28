# 制限時間付きループ

## [time.while.rs](time.while.rs)

@[rust](time.while.rs)

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

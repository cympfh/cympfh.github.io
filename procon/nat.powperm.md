% 組み合わせ $n^m$

For each $\{ x_i : 0 \leq i \lt m, 0 \leq x_i \lt n \}$

## Rust

@[rust](nat.powperm.rs)

## Example

```rust
fn main() {
    let mut count = 0;
    for a in PowerPermutation::new(3, 2) {
        count += 1;
        println!("{:?}", a);
    }
    println!("{:?}", count);
}
```

```
[0, 0]
[1, 0]
[2, 0]
[0, 1]
[1, 1]
[2, 1]
[0, 2]
[1, 2]
[2, 2]
9
```


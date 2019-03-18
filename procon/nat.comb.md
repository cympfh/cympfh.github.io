% 組み合わせ ${}_nC{}_m$

For each $\{ x_i : 0 \leq i \lt m, 0 \leq x_i \lt n, x_i \gt x_j \}$

@[rust](nat.comb.rs)

## Example

```rust
fn main() {
    let mut count = 0;
    for a in Combination::new(6, 3) {
        count += 1;
        println!("{:?}", a);
    }
    println!("{:?}", count);
}
```

```
[2, 1, 0]
[3, 1, 0]
[4, 1, 0]
[5, 1, 0]
[3, 2, 0]
[4, 2, 0]
[5, 2, 0]
[4, 3, 0]
[5, 3, 0]
[5, 4, 0]
[3, 2, 1]
[4, 2, 1]
[5, 2, 1]
[4, 3, 1]
[5, 3, 1]
[5, 4, 1]
[4, 3, 2]
[5, 3, 2]
[5, 4, 2]
[5, 4, 3]
20
```


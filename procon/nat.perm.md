# 組み合わせ $n!$

For each $\{ x_i : 0 \leq i \lt n, 0 \leq x_i \lt n, x_i \ne x_j \}$

## Rust

@[rust](nat.perm.rs)

## Example

```rust
fn main() {
    let n = 3;
    let mut count = 0;
    for a in Permutation::new(n) {
        count += 1;
        println!("{:?}", a);
    }
    println!("{:?}", count);
}
```

```
[0, 1, 2]
[0, 2, 1]
[1, 0, 2]
[1, 2, 0]
[2, 0, 1]
[2, 1, 0]
6
```

## C++ (STL)

```cpp
vector<int> v(3);
rep (i, v.size()) v[i] = i;

do {
  cout << v << endl;
} while (next_permutation(begin(v), end(v)));
```

```
0 1 2
0 2 1
1 0 2
1 2 0
2 0 1
2 1 0
```



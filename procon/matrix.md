# 行列

## Rust

$m \times n$ 行列を

```rust
type Matrix = Vec<Vec<f64>>;
let a: Matrix = vec![vec![0.0; n]; m];
```

とする.

## C++

$m \times n$ 行列を

```cpp
using Number = float;
using Vektor = vector<Number>;
using Matrix = vector<Vektor>;

template<typename Number>
vector<vector<Number>>(m, vector<Number>(n))
```

とする.

```cpp
void print_matrix(Matrix a) {
  for (auto&l : a) {
    cout << "| " << l << '|' << endl;
  }
}
```

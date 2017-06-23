# 行列

m×n行列 ($1 \leq m, n$) を、

```cpp
template<typename Number>
vector<vector<Number>>(m, vector<Number>(n))
```

によって表現する。

```cpp
using Number = int;
using Vektor = vector<Number>;
using Matrix = vector<Vektor>;

void print_matrix(Matrix a) {
  for (auto&l : a) {
    cout << "| " << l << '|' << endl;
  }
}
```

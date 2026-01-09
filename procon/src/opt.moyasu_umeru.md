# 最適化 - 燃やす埋める問題

$\def\I{\mathbb I}$
[Project selection problem](https://en.wikipedia.org/wiki/Max-flow_min-cut_theorem#Project_selection_problem) とも.

## 問題

$n$ 個の Bool 変数 $x_0, x_1, \ldots, x_{n-1}$ があるとする.
特に実装上ではこの添字 $0,1,\ldots,n-1$ で変数を指す.
これに対して次の目標関数を考える.
$$\mathcal{L}(x ; b_t, b_f, c) = \sum_i b_t^i \I(x_i) + \sum_i b_f^i (1 - \I(x_i)) + \sum_i \sum_j c_{ij} \I(x_i) (1 - \I(x_j))$$

ここで

- $b_t, b_f$ はそれぞれ長さ $n$ の整数列
- $c$ は $n \times n$ の整数行列
- $\I(x)$ は Bool 値 $x$ に対するインディケータ関数で
    - $\I(x) = \begin{cases} 1 & \text{ if } x = \mathrm{true} \\ 0 & \text{ if } x = \mathrm{false} \end{cases}$

のこと.
次のように解釈する.

- $b_t^i$ は $x_i$ が真のときのコスト
- $b_f^i$ は $x_i$ が偽のときのコスト
- $c_{ij}$ は $x_i$ が真で $x_j$ が偽のときのコスト

与えられた $b_t, b_f, c$ に対して $\mathcal{L}$ を最小化する $x$ の割当を求める問題を燃やす埋める問題という.

$$\min_{x \in \{\mathrm{true}, \mathrm{false}\}^n} \mathcal{L}(x ; b_t, b_f, c)$$

## 解法

最小カット問題に帰着する.

## ライブラリの使い方

`cost!` または `gain!` マクロで制約を付け足していく.

```rust
/// サンプル
let n = 4;  // 使う変数の個数
let mut solver = MoyasuUmeruSolver::new(n);

solver += cost!(1; if 0); // 変数 0 が true のときのコストが1
solver += cost!(2; if not 0); // false のときのコストが2

solver += cost!(inf; if 1); // 無限大のコスト

solver += gain!(1; if not 1); // 逆に獲得できる利益. 内部ではマイナスにしてコストとして扱う

solver += cost!(100; if 0 and not 1);  // 0 が true, 1 が false のときのコスト
solver += cost!(inf; if not 0 and 1);  // 0 が false, 1 が true のときは無限のコスト

solver.min_cost();  // 最小化されたコスト

solver.max_gain();  // 逆に最大化した獲得量. 最小コストのマイナスを返す
```

## 実装

@[rust](procon-rs/src/opt/umeru_moyasu.rs)

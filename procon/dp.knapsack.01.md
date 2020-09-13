# 01-ナップザック問題

## ナップザック問題

$N$ 個の商品が与えられる.
商品には値段 (cost) と 価値 (val) のペアがそれぞれ整数値で付与されている.
$$P = \{ (c_1, v_1), \cdots, (c_N, v_N) \}$$

ある条件を満たすように商品を選んで価値の合計を最大化する問題.

## 01-ナップザック問題

値段の上限 $C$ が与えられる.
商品は最大 $m$ 個選んでよく, ただし各商品は高々 $1$ 個までしか選んではいけない.
価値の和を最大化せよ.

$$\max_{i \in I} v_i$$
such that

- $\sum_{i \in I} c_i \leq C$
- $|I| \leq m$

## 解法 - 値段についてのDPによる

次のようなテーブル (配列) をまず動的計画法によって作成する:

- `table[k]` は $k$ 円の組み合わせ (和) で作ることの出来る最大価値

```cpp
int table[C+1];

// init
rep (i, C+1) table[i] = - 1e9;
table[0] = 0;

// read and update
for (int i = 0; i < N; ++i) {
  // (c[i], v[i])
  for (int k = C; k >= 0; --k) { // 上から更新する (重複を避けるため)
    if (c[i]+k > C) continue; // out of range
    table[c[i]+k] = max(table[c[i]+k], table[k] + v[i]);
  }
}

ans = table[0];
for (int k = 0; k <= C; ++k) {
  ans = max(ans, table[k]);
}
```

解は、インデックスが `k <= C` で `table[k]` の最大値.

## 例題

- [泥棒 | Aizu Online Judge](http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=0042)
    - [私の解答](http://judge.u-aizu.ac.jp/onlinejudge/review.jsp?rid=1582319#1)

## 双対: 価値についてのDP

価値の和を $V$ としてもっておけば、
テーブルの添字が0以上$V$以下の整数からなる、価値についてのDPができる.

```cpp
int table[V+1];

// init
rep(i, V) table[i] = 2e9;
table[0] = 0;

// read and update
for (int i = 0; i < N; ++i) {
  // (c[i], v[i])
  for (int k = V; k >= 0; --k) { // 上から更新する (重複を避けるため)
    if (v[i]+k > V) continue; // out of range
    table[v[i]+k] = min(table[v[i]+k], table[k] + c[i]);
  }
}

int ans = 0;
rep (k, V+1){
  if (table[k] <= C) ans = max(ans, k);
}
```

## 例題

- [ABC032/D - ナップサック問題](http://abc032.contest.atcoder.jp/tasks/abc032_d)


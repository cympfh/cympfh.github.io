# N vs N2

## 定理

$$\mathbb{N} \simeq \mathbb{N}^2.$$

### $\mathbb{N} \rightarrow \mathbb{N}^2$

@[cpp](nat.n_to_nn.cc)

### $\mathbb{N}^2 \rightarrow \mathbb{N}$

@[cpp](nat.nn_to_n.cc)

### テスト

#### $\mathbb{N} \rightarrow \mathbb{N}^2$

```cpp
rep (i, 10) cout << i << " => " << n2nn(i) << endl;
```

```
0 => (0, 0)
1 => (0, 1)
2 => (1, 0)
3 => (0, 2)
4 => (1, 1)
5 => (2, 0)
6 => (0, 3)
7 => (1, 2)
8 => (2, 1)
9 => (3, 0)
```

#### $\mathbb{N}^2 \rightarrow \mathbb{N}$

```cpp
rep (i, 10) {
  rep (j, 10) {
    printf("%3d ", nn2n(i, j));
  }
  puts("");
}
```

```
  0   1   3   6  10  15  21  28  36  45
  2   4   7  11  16  22  29  37  46  56
  5   8  12  17  23  30  38  47  57  68
  9  13  18  24  31  39  48  58  69  81
 14  19  25  32  40  49  59  70  82  95
 20  26  33  41  50  60  71  83  96 110
 27  34  42  51  61  72  84  97 111 126
 35  43  52  62  73  85  98 112 127 143
 44  53  63  74  86  99 113 128 144 161
 54  64  75  87 100 114 129 145 162 180
```
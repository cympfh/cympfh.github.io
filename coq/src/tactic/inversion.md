# inversion - 単射の逆

inversion はコンストラクタに関する仮定を逆に戻す.

## コンストラクタに関する等式

コンストラクタ `S` による等式
`S x = S y`
が仮定 `H` にあったとき, `inversion H` は新たに
`x = y`
を仮定に追加する.

```
1 subgoal
  
  m, n : nat
  H : m.+1 = n.+1
  ============================
  m = n

ex <   inversion H.
1 subgoal
  
  m, n : nat
  H : m.+1 = n.+1
  H1 : m = n
  ============================
  n = n
```

## 命題を返すコンストラクタ

`_ -> Prop` であるような帰納的コンストラクタがあるとする.
例えば,

```haskell
Inductive even : nat -> Prop :=
  | even_O : even 0
  | even_SS n (H : even n) : even n.+2.
```

があると, `even m.+2` という仮定を `even m` に戻すことが出来る.


```haskell
1 subgoal
  
  n : nat
  H : even n.+4
  ============================
  even n

ex <   inversion H.
1 subgoal
  
  n : nat
  H : even n.+4
  n0 : nat
  H1 : even n.+2
  H0 : n0 = n.+2
  ============================
  even n
```

このときやはり inversion は仮定を置き換えるのではなく, 新たに追加することしかしない.

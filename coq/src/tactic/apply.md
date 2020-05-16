# apply - 適用

\\(H \colon P \to Q\\) が仮定または定理にあり,
\\(Q\\) が goal のとき,
`apply H` は goal を \\(P\\) にすり替える.

```haskell
1 subgoal

  P : Type
  Q : Type
  H : P -> Q
  ============================
  Q

pq <   apply H.
1 subgoal
  
  P : Type
  Q : Type
  H : P -> Q
  ============================
  P
```

## apply ... with

適用する仮定（定理）の forall な部分は上手いこと置き換えて適用するよう試みてくれるが, 上手く置き換えを見つけてくれないことがある.
その場合には with でヒントを与えることが出来る.

```haskell
1 subgoal
  
  H : forall (X : Type) (x y z : X), x = y -> y = z -> x = z
  a, b, c, d : nat
  ============================
  [a; b] = [b; c] -> [b; c] = [c; d] -> [a; b] = [c; d]

pq <   apply H with (x := [a;b]) (y := [b;c]).
No more subgoals.
```

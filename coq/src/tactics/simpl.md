# simpl - 簡略化

自明な計算で簡略化できる部分をする.

```haskell
Coq < Theorem test: 1 + 1 = 2.
1 subgoal

  ============================
  1 + 1 = 2

test < simpl.
1 subgoal

  ============================
  2 = 2
```

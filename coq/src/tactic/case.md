# case - 条件分岐

構造に関する条件分岐を行う.

`nat` であれば `0` か `n.+1` (ssreflect の場合) かに分岐される.

```
1 subgoal

  m, n : nat
  H : m + n = 1
  ============================
  m = 0 \/ n = 0

solution <   case m.
2 subgoals

  m, n : nat
  H : m + n = 1
  ============================
  0 = 0 \/ n = 0

subgoal 2 is:
 forall n0 : nat, n0.+1 = 0 \/ n = 0
```

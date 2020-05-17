# = と == の言い換え

```haskell
eqP
     : reflect (?x = ?y) (?x == ?y)
```

を使う.

```haskell
1 subgoal
  
  n, m : nat
  ============================
  n = m -> n == m

ex <   move/eqP.
1 subgoal
  
  n, m : nat
  ============================
  n == m -> n == m
```

```haskell
1 subgoal
  
  n, m : nat
  ============================
  n == m -> n = m

ex <   move/eqP.
1 subgoal
  
  n, m : nat
  ============================
  n = m -> n = m
```

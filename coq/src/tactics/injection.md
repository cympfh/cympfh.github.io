# injection - 単射性

`nat` に対する `S` なんかは帰納的構築子であるので,
単射であることは定義より従う.
\\[ n + 1 = m + 1 \implies n = m. \\]
実際にこのことを証明で使うのに `injection` を使う.

```haskell
1 subgoal

  n, m : nat
  H : n.+1 = m.+1
  ============================
  n = m

ex <   injection H.
1 subgoal

  n, m : nat
  H : n.+1 = m.+1
  ============================
  n = m -> n = m

ex <   done.
No more subgoals.
```

# injection - 単射性

全てのコンストラクタ（構築子）は単射である.
例えば `nat` に対する `S` や, リスト `[]` は単射なので,
\\[ n + 1 = m + 1 \implies n = m, \\]
\\[ [n] = [m] \implies n = m, \\]
が言える.
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

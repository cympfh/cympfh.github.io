# 補題の導入

証明中に一時的に補題を導入することで証明自体が構造的になって楽になる.

## assert

補題を主張すると, その補題の証明に移り, 証明完了すると主張した補題が仮定に入る.

```haskell
assert (LemmaName : LemmaProp). {
  Proof for Lemma.
}
```

`{}` はインデントの意味しかないので無くていい.

```haskell
1 subgoal
  
  n, m : nat
  ============================
  n = m

ex <   assert (Base : 0 = 0).
(* 補題の主張, その証明が goal に追加される *)
2 subgoals
  
  n, m : nat
  ============================
  0 = 0

subgoal 2 is:
 n = m

ex <   by done.
(* 証明完了. 仮定に追加された *)
1 subgoal
  
  n, m : nat
  Base : 0 = 0
  ============================
  n = m
```

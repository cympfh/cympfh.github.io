# 補題の導入

証明中に一時的に補題を導入することで証明自体が構造的になって楽になる.

## assert

名前を付けて補題を主張する.

```haskell
assert (LemmaName : LemmaProp).
```

新しい Goal としてこれを追加し, 今までの証明には `LemmaName` の名前で仮定として追加される.

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

## have

assert と同様に,

```haskell
have: LemmaProp.
```

の形式で補題を主張する.
新たに Goal としてこれが追加され,
他の証明には前件として追加される.

```haskell
1 subgoal

  ============================
  1 = 1

ex < have: 0 = 0.
2 subgoals

  ============================
  0 = 0

subgoal 2 is:
 0 = 0 -> 1 = 1
```

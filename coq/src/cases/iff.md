# 同値 iff の分解

## split

Goal の帰結 \\(P \iff Q\\) を \\(P \implies Q\\) と \\(Q \implies P\\) とに分解する.

```haskell
1 subgoal
  
  P, Q : Prop
  ============================
  P <-> Q

ex <   split.
2 subgoals
  
  P, Q : Prop
  ============================
  P -> Q

subgoal 2 is:
 Q -> P
```

注意としてこれは帰結にのみ適用され, 前件は勝手に全て仮定に動かされる.

## intros

[intros](./intros.md) で紹介してない機能があり,
上述の split をしながら仮定に持っていくという機能がある.

Goal が \\( ( P \iff Q ) \implies \dots \\) のときに,
`intros [PQ QP]` とすると,
前件 \\( P \iff Q \\) を split してからそれぞれを `PQ` `QP` という名前で仮定に移動する.

```haskell
1 subgoal
  
  P, Q : Prop
  ============================
  P <-> Q -> Q <-> P

ex <   intros PQ.
(* ただの intros だと <-> のまま持ってくだけ *)
1 subgoal
  
  P, Q : Prop
  PQ : P <-> Q
  ============================
  Q <-> P

ex < Undo.
1 subgoal
  
  P, Q : Prop
  ============================
  P <-> Q -> Q <-> P

ex <   intros [PQ QP].
(* 同時に split もされる!! *)
1 subgoal
  
  P, Q : Prop
  PQ : P -> Q
  QP : Q -> P
  ============================
  Q <-> P
```


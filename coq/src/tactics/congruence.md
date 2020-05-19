# congruence - 合同

等式 `(_ = _)` に関するゴールをいい感じに示してくれる証明戦略.

\\[ a=b \land b=c \implies a=c \\]

```haskell
1 subgoal

  ============================
  forall (X : Type) (a b c : X), a = b -> b = c -> a = c

three_steps <   intros.
(* congruence がこれもやってくれるので実は不要 *)
1 subgoal

  X : Type
  a, b, c : X
  H : a = b
  H0 : b = c
  ============================
  a = c

three_steps <   congruence.
No more subgoals.
```

不等号 `<>` も `(_ = _) -> False` に過ぎず congruence で対処できることがある.

\\[ n+1 \ne m+1 \implies n \ne m \\]

```haskell
1 subgoal
  
  ============================
  forall n m : nat, n.+1 <> m.+1 -> n <> m

ex < Proof.
1 subgoal
  
  ============================
  forall n m : nat, n.+1 <> m.+1 -> n <> m

ex <   congruence.
No more subgoals.

ex < Qed.
```

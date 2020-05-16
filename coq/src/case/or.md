# 選言の分解

## left, right

帰結が \\(P \lor Q\\) のとき, この一方だけを選んで残す戦略.

これは \\(P \lor Q\\) を示すには \\(P\\) だけ（あるいは \\(Q\\) だけ）が示されれば良いことから.

```haskell
Coq < Example left_is_true : 0 = 0 \/ 0 = 1.
1 subgoal

  ============================
  0 = 0 \/ 0 = 1

left_is_true < left.
1 subgoal

  ============================
  0 = 0

left_is_true < auto.
No more subgoals.
```

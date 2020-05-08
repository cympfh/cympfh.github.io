# 選言の分解

goal が `P \/ Q` の形の場合に使えるテク.

## left, right

Goal の帰結について, その左だけ, または右だけを残す.
これは \\(P \lor Q\\) を示すには \\(P\\) だけ（あるいは \\(Q\\) だけ）が示されれば良いことから.

```c
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

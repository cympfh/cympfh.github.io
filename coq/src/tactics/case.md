# case - 条件分岐

## 構造に関する条件分岐

変数名を引数に呼ぶと, 構造に関する条件分岐を行う.

例えばそれが `nat` であれば `0` か `n.+1` (ssreflect の場合) かに分岐される.

```haskell
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

## 自由な条件分岐

自由に条件式 `(_ == _)` を引数に与えると,
それが `true` の場合と `false` の場合に分岐する.

```haskell
Definition fizz (n : nat) : bool :=
  if n == 3 then false
  else false.

Example ex : forall n, fizz n = false.
Proof.
  move => n.
  unfold fizz.
  - case (n == 3).
    (* n == 3 が true の場合 *)
    done.
  - (* otherwise *)
    done.
```

```haskell
1 subgoal
  
  n : nat_eqType
  ============================
  (if n == 3 then false else false) == false

ex <     case (n == 3).
2 subgoals
  
  n : nat_eqType
  ============================
  false == false

subgoal 2 is:
 false == false
```

導入した条件式は即座に apply される.
仮定として残しておきたい場合は第2引数に `eqn:(name)` で名前を与える.

```
ex <     case (n == 3) eqn:Is3.
2 subgoals
  
  n : nat_eqType
  Is3 : (n == 3) = true
  ============================
  false == false

subgoal 2 is:
 false == false
```

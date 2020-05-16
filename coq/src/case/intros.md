# 仮定と前件の移動

\\( \Gamma, P \vdash Q \\)
という証明と
\\( \Gamma \vdash P \implies Q \\)
という証明は等しい.
Coq では仮定の中の任意の命題は Goal の一番左に前件として移動できるし,
Goal の一番左の前件を仮定に移動することが自由に出来る.

## intros

引数なく呼んだ時,
前件を持ってこれるだけ全部仮定に持っていく.
このとき仮定の名前は適当に付けられるので注意.

```haskell
Coq < Example ex : forall P Q R, P -> (P -> Q) -> R.
1 subgoal
  
  ============================
  forall P Q R : Type, P -> (P -> Q) -> R

ex <   intros.
1 subgoal
  
  P : Type
  Q : Type
  R : Type
  X : P
  X0 : P -> Q
  ============================
  R
```

## intros P...

1つ以上の引数を指定した時, その個数だけ順に前件を仮定に移動し,
そのとき名前を引数で与える.

```haskell
1 subgoal
  
  ============================
  forall P Q R : Type, P -> (P -> Q) -> R

ex <   intros P Q.
1 subgoal
  
  P : Type
  Q : Type
  ============================
  forall R : Type, P -> (P -> Q) -> R
```

## intro

ちょうど一つだけを移動する intros.
引数を与えない場合名前は適当に付けられる.
ちょうど一つの引数を与える場合はそれが名前に使われる.

## move =>

1つ以上の引数を必要とする intros に同じ.
ssreflect のコマンド.

## revert

仮定を一つ選んで, 前件に追加する.

```haskell
1 subgoal
  
  P : Type
  Q : Type
  R : Type
  HP : P
  ============================
  (P -> Q) -> R

ex <   revert R.
1 subgoal
  
  P : Type
  Q : Type
  HP : P
  ============================
  forall R : Type, (P -> Q) -> R
```

## `move:`

revert に同じ.
ssreflect のコマンド.


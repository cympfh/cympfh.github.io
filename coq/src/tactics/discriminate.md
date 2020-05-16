# discriminate - 構築子の区別

[injection](./injection.md) は構築子が単射であることを利用して, 同じ構築の仕方を行って得た値は等しいという証明を行った.
同様に構築の仕方が異なるものは等しくないということも明らかなはずである.
`discriminate` はこれを行う.

```haskell
1 subgoal
  
  ============================
  true <> false

ex <   discriminate.
No more subgoals.
```

```haskell
1 subgoal
  
  ============================
  2 <> 5

ex <   discriminate.
No more subgoals.
```

ちなみに十分明らかなので `by done.` でも同様に証明できる.

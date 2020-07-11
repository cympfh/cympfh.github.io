% 関数従属性の公理系
% 2020-07-11 (Sat.)
% RDB

$\def\mvdarrow{\rightarrow\!\rightarrow}\def\fdarrow{\rightarrow}$
[Relational Database](rdb.html) の続き.

## アームストロングの公理系

関係 $R(A)$ について,

1. $Y \prec X ~ (\prec A)$ ならば $X \fdarrow Y$,
2. $X \fdarrow Y$ のとき任意の $Z$ について $X \lor Z \implies Y \lor Z$,
3. $X \fdarrow Y$ かつ $Y \fdarrow Z$ ならば $X \fdarrow Z$ （推移律）.

これに, 適当な関数従属性の集合

0. $F = \{f_1, \ldots, f_N\}$; $f_i: X_i \fdarrow Y_i$

を宣言して, $F$ を 1-3 のルールで膨らましたものを $F^+$ という.
$F^+$ に入ってるルールが確かに $R(A)$ で関数従属性になっていることを健全性 (soundness) といい,
逆に $R(A)$ であり得る関数従属性が $F^+$ に入ってることを完全性 (completeness) という.

名前列 $X$ について,
$X$ の（$F$ に関する）閉包 $X^+$ を次で定める:
$$X^+ := \{Y \mid (X \fdarrow Y) \in F^+\}$$

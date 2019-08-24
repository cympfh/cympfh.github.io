# F-代数

{{#include macro.tex}}

## 定義

圏 $\C$ とその自己関手 $F \colon \C \to \C$ について,
$F$-代数とは,
対象 $X \in \C$ と射 $f \colon FX \to X$ の組
$$(X, f)$$
のこと.
$X$ をこの代数の台という.

## $F$-始代数

$(\C, F)$ について
$F$-代数の圏を考えることが出来る.
これの始対象を始代数という.

しばしば重要な概念がこれで表される.

### 例

Set 圏において
$F(X) = 1 + X (=\{\*\} \cup X)$
の始代数は $(\mathbb N, \nu)$.
ここで $\nu \colon 1+\mathbb N \to \mathbb N$ は

- $\nu(\*) = 0$
- $\nu(m) = m + 1$

という写像.

---

### 出典

[aiura/F-algebra](/aiura/F-algebra.html)

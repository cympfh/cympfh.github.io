# F-代数

{{#include macro.tex}}

## 定義

圏 $\C$ とその自己関手 $F \colon \C \to \C$ について, $F$-代数とは,
対象 $X \in \C$ と射 $f \colon FX \to X$ の組
$$(X, f)$$
のこと.
$$\begin{CD}
X @<f<< FX
\end{CD}$$
$X$ をこの代数の台という.

## $F$-始代数

圏 $\C$ と自己関手 $F$ について, $F$-代数の圏を考えることが出来る.
すなわち対象は上のような $(X, f)$ であり, 射は次のように定義されるもの.

$\C$ の射 $g \colon X_1 \to X_2$ が
$$\begin{CD}
X_1 @<f_1<< FX_1 \\
@VgVV @VFgVV \\
X_2 @<f_2<< FX_2
\end{CD}$$

これを可換にするとき, $g$ を $F$-代数の圏の射
$$g \colon (X_1, f_1) \to (X_2, f_2)$$
とする.

このようにして作った圏のの始対象を始代数という.
しばしば重要な概念がこれで表される.

### 例

Set 圏において
$FX = 1 + X (=\{\*\} \cup X)$
の始代数は $(\mathbb N, \nu)$.
ここで $\nu \colon 1+\mathbb N \to \mathbb N$ は

- $\nu(\*) = 0$
- $\nu(m) = m + 1$

という写像.

---

### 出典

[aiura/F-algebra](/aiura/F-algebra.html)

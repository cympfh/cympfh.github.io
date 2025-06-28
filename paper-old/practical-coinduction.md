% Practical Coinduction
% http://citeseerx.ist.psu.edu/viewdoc/summary?doi=10.1.1.252.3961
% 余帰納法

## Introduction

### 帰納法 (induction) の例、リスト

有限集合 $A$ 上のリストというものは次のように、
帰納的に定義される.

- $nil$ はリスト
- $a \in A$ と $A$ 上のリスト $\ell$ があるとき $a :: \ell$ は $A$ 上のリスト

次のようにも書ける:
$$List = nil + A \times List$$

この構成は、ただひとつの定数 $nil$ と、
ただひとつの構成子 $::$ によって、
ただひと通りに定まる.
リストの $length$ 、 $concat$ といった関数は、
この構成に沿って定義できる.

- $length(nil) = 0$
- $length(a :: \ell) = 1 + length(\ell)$

みたいに.
これの上のいくつかの命題も、構成に沿って証明される.

1. $length(concat(nil, \ell)) = length(\ell)$
1. $length(concat(a::m, n)) = length(a::concat(m,n))$

これらは、
帰納法と言われる.
さて、
双対として、余帰納法がある.
帰納法は大変馴染み深いのに対して、余帰納法は馴染みがないし、綺麗な形式化もない.
帰納法においては、基底があってそこからスタートするのに対して、
余帰納法では基底がなく、無限しかない.

余帰納法が登場する例として、

1. (古典的な) 双模倣の証明
1. 等価以外の命題
    - 2つの無限列の辞書的な大小比較
1. 余帰納的な Datatypes の関係証明
    - 半順序の上の関数が単調であることの証明

## Coinductive Datatypes

$A$ の上の無限ストリーム (有限を許さない) $X$
とは、次のような
自己関手 $F : A^\omega \rightarrow A^\omega$ の
終余代数 (final coalgebra) である.
$$F(X) = A \times X$$

一方で、
有限はまたは無限の列 $X$ は、
$$F(X) = 1 + A \times X$$
という
自己関手 $F: A^\infty \rightarrow A^\infty$
の終余代数である.

### ストリームの上の辞書順 (lexicographic order on streams)

$A^\omega$ 上の半順序 $\preceq$ を定める.
ストリームとは $A^\omega$ の要素、

- $::$ とは $A \times A^\omega \rightarrow A^\omega$
- $hd$ とは $A^\omega \rightarrow A$
- $tl$ とは $A^\omega \rightarrow A^\omega$

$A^\omega$ 上の
二項関係 $\preceq_{lex}$ を、
次を満たす関係$R$ の内で最大のものだとする.

- $s R t$ のとき、
    - $hd(s) \leq hd(t)$ かつ、
    - $hd(s) = hd(t)$ ならば、 $tl(s) R tl(t)$

これが半順序であるのはいいとして、
次のように定義することもできる.

$$T : (A^\omega , A^\omega) \rightarrow (A^\omega , A^\omega)$$
$$T(R) = \{ (s,t) : hd(s) \leq hd(t) \land hd(s) = hd(t) \Rightarrow tl(s) ~R~ tl(t) \}$$

これを用いて、 $T$ の最大不動点が $\leq_{lex}$ である.

### Theorem 3.2: $\preceq_{lex}$ の推移律

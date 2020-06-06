% A Greedy Heuristic for Set-Covering Problem
% http://www.jstor.org/stable/3689577?seq=1#page_scan_tab_contents
% 最適化 集合被覆

[better-than-greedy](./better-than-greedy.html) のついでに.
3ページだけなので.

k-set cover problem を所謂貪欲法で解いた場合の近似度の解析を行う.

# 問題

有限集合のコレクション $P_1, P_2 .. P_N$ がある.
正のコストとして、$P_i$ には $c_i$ が与えられる.

$$I = \bigcup_{i=1..N} P_i = \bigcup_{i \in J} P_i$$

が満たされるようなインデックスの集合 $J$ であって
$$\min \sum_{i \in J} c_i$$
となるようなものを探す.

$$k = \max |P_j|$$
だとしておく (k-set cover problem).

# 直感的な貪欲法

$|P_j| / c_j$ という比が大きいものほど良い.

0. $J = \{\}$
1. while $\exists j .~ P_j \ne \{\}$
    1. ある $k$ で $\frac{|P_k|}{c_k}$ を最大となるとする
    1. $J \leftarrow J \cup k$
    1. $P_j \leftarrow P_j \setminus P_k$
2. $J$ が答え

## Illustration

コレクション $P_1 .. P_{m+1}$ が与えられるとする.

- for $1 \leq j \leq m$
    - $P_j = \{ j \}$
    - $c_j = 1 / j$
- for $j = m+1$
    - $P_j = \{ 1 .. j \}$
    - $c_j > 1$

先の貪欲法では、
順に $j = m, m-1, .. 1$ を選択して、
$J = \{ 1 .. m\}$ を返す.  
(何故ならば、$r_j = j \geq 1 (1 \leq j \leq m), r_{m+1} = m/c_{m+1} < 1$ なので)

そしてこれのコストは
$$H_m = \sum_{j=1}^m \frac{1}{j} > 1.$$

もちろん $J=\{m+1\}$ もまた別な解であって、
このコストは $c_{m+1} > 1$ である.
こちらが最適解であることはあり得る.

この場合の近似度は
$H_m / c_{m+1} (< H_m)$
となる.

で、実は、
$H_k$ で上限として抑えられるのである.

## 定理

貪欲法が返す被覆のコストは、最適解の高々 $H(k)$ 倍である.

もっと強い事実を証明することで、証明を行う.

被覆関係を行列で表現する:
$$A_{i, j} = \chi(i \in P_j)$$
where $\chi(true) = 1, \chi(false) = 0$

$i=1..m, j=1..n$ で $A$ を $m \times n$ 行列とする.

被覆とは、どの $P_j$ を01で表現したベクトル $x \in \{0,1\}^m$ である.
被覆できているとは
$$A \cdot x \geq 1$$

被覆 $x$ が示すコストは $c \cdot x$ と表現できる
($c = [ c_1 .. c_n ]$).

### 主張

貪欲法が返す被覆 $J$ について:
$$\sum_{j=1}^m H(\sum_{i=1}^m A_{i,j}) c_j x_j \geq \sum_{J} c_j$$
が成立する.

左辺はさらに左から
$H(k) \sum_j c_j x_j$
で抑えられ、
また、右辺の下限として最適解があって、
それは最初の定理となる.
従って、
この主張は定理よりも一つ強いものとなっている.

この主張を証明することで定理の証明とする.

非負数 $y_1 .. y_m$ でもって次の２つが成り立つようなものが存在する.

- $\forall j .~ \sum_i A_{i,j} y_i \leq H(\sum_i A_{i,j}) c_j$
- $\sum_i y_i = \sum_J c_j$

存在を疑わなければ次のように主張が導かれる.

$$\sum_j H(\sum_i A_{i,j}) c_j x_j \geq \sum_j (\sum_i A_{i,j} y_i) x_j = \sum_i (\sum_j A_{i,j} x_j) y_i$$
$$\geq \sum_i y_i = \sum_J c_i$$

そろそろ飽きたので.

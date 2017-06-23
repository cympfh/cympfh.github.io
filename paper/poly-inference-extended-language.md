% Polynomial time inference of extended regular pattern languages
% http://link.springer.com/chapter/10.1007/3-540-11980-9_19
% ALT 形式言語 パターン

## 要旨

消去可能正規パターン言語の学習
(the class of extended regular pattern languages)

パターン言語とは、
パターンの変数に空でない文字列を代入して得られる文字列全ての集合のこと。
正例から消去不能正規パターン言語の族を、
多項式時間で構築することを考える。

`MINL` とは、文字列の有限集合が与えられた時に、
最小の言語 (minimal language) を計算するアルゴリズムのことで、
これを用いる。

MINL が行う計算は明らかに、最長共通部分列と関連がある。
これについても議論する。

# 準備

## Lemma 1

1. 2つのパターン$p, q$ が$p \equiv q$ ならば、$L(p) = L(q)$

2. $p \preceq q$ ならば、$L(p) \subseteq L(q)$

逆は一般には成り立たない.

3. $|p| = |q|$ のとき、 $p \preceq q \iff L(p) \subseteq L(q)$

# 正例からの推論 (Inference from Positive Data)

## Theorem 1

言語族 $\mathcal{L} = L_1, L_2, ...$ が、次を満たすとき、これを正例から推論することが可能である。

### Condition

空でない文字列集合 $S$ について、
$\{ L : S \subset L, L = L_i \}$ が有限集合。

## Lemma 2

消去不能正規パターン言語は、先の Condition を満たす。

# 消去可能正規パターン言語

## Proposition 1

1. $p \preceq q \Rightarrow L(p) \subseteq L(q)$
2. $p \equiv q \Rightarrow L(p) = L(q)$

## 標準形 (canonical form)

パターン$p$に就いて、次の命題から、それと等しいパターンが在る。

消去可能において、連続した変数は意味がないので一つに簡約して、
また、変数名も意味がないので、左から順に $x_1, x_2, ... x_k$ と命名したものを、標準形とよぶ。

一般に、
$$w_0 v_1 w_1 ... w_{n-1} v_n w_n$$
と表せる。
ここで、

- $w_0, w_n \in \Sigma^*$
- $w_1 .. w_{n-1} \in \Sigma^+$
- $v_i \in X$

である。

また、任意のパターンは唯一つの標準形を持つ。

### Lemma 4

パターンの $\Sigma$ (constant) 部分だけ取り出す写像を $c$ とする
(パターンを文字列に変換する)。

$$p = w_0 v_1 w_1 ... w_{n-1} v_n w_n$$
に対して、
$$c(p) = w_0 w_1 ... w_{n-1} w_n$$
である。

明らかに、
$|p| \leq 2 |c(p)| + 1$
が成立する。

## Theorem 6

消去可能正規パターン言語は、
Theorem 1 の Condition を成立させて、
正例からの推論が可能。

何故ならば、Lemma 4 より、文字列 $w$ を生成させるパターン(の標準形)の長さは、
たかだか、$2 |w| + 1$ の長さを持ち、
そのようなパターンは有限であるから。

## Theorem 7

パターン $p$, 文字列 $w$ に対して、
$w \in L(p)$
の判定は、
$O(|p|+|w|)$
の時間で計算可能。
[Aho+, 1974 (The Design and Analysis of Computer Algorithms, Addison-Weley, Reading, Mass)]()

# MINL Caluculation for Regular Pattern Languages

## 部分列 (subsequence)

1. 文字列 $w = a_1 ... a_k (a_i \in \Sigma)$ と、
文字列 $s \in \Sigma^*$ について、
$$s = a_{i_1} ... a_{i_m} (1 \leq i_1 \le ... \le i_m \leq k)$$
とある時、
$s$を$w$の部分列と言って
(或いは、$w$は$s$の上位列と言って)、
$$s \leq w ~~ (\iff w \geq s)$$ と表す。

2. 文字列集合$S$の共通部分列集合 (the set of common subsequences) $CS(S)$とは、
$$CS(S) = \{ s \in \Sigma^* : s \leq w, \forall w \in S \}$$

3. 極大共通部分列集合 (the set of maximal common subsequences) $MCS(S)$とは、
$$MCS(S) = \{ s \in CS(S) : s = s' \lor \lnot (s \leq s') , \forall s' \in CS(S) \}$$

> 文字列の $\leq$ は全順序ではないことに註意。

4. 最長共通部分列集合 (the set of the longest common subsequences)
$$LCS(S) = \{ s \in CS(S) : |s| \geq |s'|, \forall s' \in CS(S) \}$$

## Proposition 2

1. $w \in L(p) \Rightarrow w \geq c(p)$
2. $L(p) \subseteq L(q) \Rightarrow c(p) \geq c(q)$
3. $L(p) = L(q) \Rightarrow c(p) = c(q)$
4. $S \subseteq L(p) \Rightarrow c(p) \in CS(S)$

## Theorem 8

アルファベット濃度が3以上の時、
$$L(p) \subseteq L(q) \Rightarrow p \leq q$$

証明は略。
アルファベットが2以下の時の反例は、以下通り。

### Lemma 5
- $\Sigma = \{ 0, 1 \}$
- $p = x_1 0 1 x_2 0 x_3$
- $q = x_1 0 x_2 1 0 x_3$

これらに就いて、$L(p) = L(q)$ であるが、$\lnot (p \leq q) \land \lnot (p \geq q)$ である。

アルファベットがそんなに少ない場合は珍しいので、
3以上の場合だけを考える。

# MINLの実装

- [Scheme (Gauche)](https://gist.github.com/cympfh/dd3b151d9ff1585e68e7)
- [C++11 (g++)](https://gist.github.com/d0dbc98052c0d51b2863)

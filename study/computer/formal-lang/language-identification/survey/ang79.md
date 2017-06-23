% Finding Patterns Common to a Set of Strings

<section>
<div class="author">Angluin</div>
<div class="title">Finding Patterns Common to a Set of Strings</div>
<div class="public"><a href="http://dl.acm.org/citation.cfm?id=804406">ACM 1979 pp.130-141</a></div>
<div class="note">[ang79.md](ang79.html)</div></section>

いわゆるパターン言語であって、
与えられた文字列集合を言語に含められるようなパターンを
"pattern common"
と呼ぶ.

## Angluin's problem (aka. MINL)

- Given finite nonempty set of nonnull strings $S$,
- find a pattern $p$ (if exists) such that $S \subseteq L(p)$ and
- if other $q$ such that $S \subseteq L(q)$ then $L(q) \not\in L(p)$ ($p$ の極小性)

### Example

$S=\{$ 1011, 110111 $\}$

- $p=$ x0x1
- $q=$ x01x

# 定義

## About Pattern

1. A pattern is any finite string over $(\Sigma \cup X)$.
1. $P$
1. substitution
1. $\equiv, \preceq$
1. 個別に数えた変数が $k$ 個あるパターンを k-variable パターンといって、それ全体を $P_k$ とする
1. $L(p)$
1. canonical form $\hat{p}$

## About Inductive Identification

1. positive presentation
1. 添字付き言語族について、そのなかの全ての言語について、任意の正提示から、ある一つの推論マシーンで極限同定できるとき、その言語族を同定する、という

# 3.1 Equivalence

## Thm 3.1.5

$$p \equiv q \iff L(p) = L(q)$$

証明には Thm 3.3.5 が必要.

# 3.2 Membership

## Thm 3.2.1

Given $p,q$, $p \preceq q$ の判定はNP.

$q$ が k-variable だとすると、$q$ から部分列を $k$ 個、非決定的に引っ張ってきて、
マッチすることをチェックすればよい.
従って、 $|p|^{O(k)}$ の計算量で、決定的に計算できる.
$|p|$ は $p$ の長さ.

## Thm 3.2.2

Given $s, p$, $s \in L(p)$ の判定はNP完全.

[3-SAT からパターンマッチへの帰着による証明](pattern_match_is_np_complete.html)

# 3.3 Containment

## 3.3.3
$\preceq$ が半順序

## 3.3.2
$$p \preceq q \Rightarrow L(p) \subseteq L(q)$$

## 3.3.4

`3.3.2` の逆は偽.

### 反例

$\Sigma=\{0,1\}, p=0x10xx1, q=xxy$

$p \npreceq q$

$s \in L(p) \iff s=0t10tt1$.
$t=0u, 1u$ の二通りの場合を考える.
前者の場合 $s = 00(u100u0u1) \preceq q$.
後者の場合 $s = (01u1)(01u1)u1 \preceq q$.
したがつて $s \in L(q)$.

## Thm 3.3.5

If $|p|=|q|$ then
$p \preceq q \iff L(p) \subseteq L(q)$.

## Thm 3.3.6

$q$ が one-variable pattern なら、
$p \preceq q \iff L(p) \subseteq L(q)$.

## 3.3.7

Given $p,q$, $L(p) \subseteq L(q)$ の判定は NP困難.

## 4.1 帰納推定のための条件

添字付き言語族 $\mathcal{C} = L_1, L_2 ...$
であって、効率的に $s \in L_i$ が判定できるとする (帰納言語).

### 条件 C1

$$\forall i, \exists \text{finite} T \subseteq L_i, \nexists j, T \subseteq L_j \subsetneq L_i$$

この $T$ はいわゆる、$L_i$ の 有限証拠 (tell-tail) と呼ばれる.

### 条件 EC1 (C1のenum版)

$L_i$ の有限証拠を $T_i$ とする.
$L_1, L_2 ...$ という indexing に対して
$T_1, T_2 ...$ という列挙を効率良く行う手続きが存在すること.

## 4.1.1

EC1 を満たす iff 極限同定可能

### EC1 $\Rightarrow$ 極限同定

1. $S \leftarrow \{\}$
1. $g_0 = \bot$
1. For each time $t=1,2..$
    1. $S \leftarrow S \cup \{ s_t \}$
    1. 

### 条件 C2
### 条件 C3



% Finding Minimal Generalizations for Unions of Pattern Languages and its Application to Inductive Inference from Positive Data
% http://www-ikn.ist.hokudai.ac.jp/~arim/papers/arimura_stacs94.pdf
% 形式言語 パターン

## 概要

（消去不能正規）パターン言語を和言語に拡張して極小言語戦略する

## パターン和言語

パターンの和 (OR) を取って高い表現力を得る.

パターンの集合 $P = \{ p_1, p_2, \ldots, p_k \}$ に対してその言語を
$$L(P) = \cup_i P(p_i)$$
ある自然数 $k$ で $|P| \leq k$ に限るとき, その $P$ を $k$-multiple description という.
パターン (description) 全体 $D$ に対して $k$-multiple description 全体を $D^k$ と書く.

### 汎化システム

パターンには半順序 $\leq$ が入っていて
$p \leq q \implies L(p) \subseteq L(q)$
という関係がある.
これに相当する関係を $k$-multiple description にも入れる.
$$P \preceq Q \iff \forall p \in P, \exists q \in Q, L(P) \subseteq L(Q)$$

> 元のパターンの汎化システムが完全であっても, multiple description のシステムは不完全であることに注意.

## パターン和言語の極小言語

文字列 (object) の有限集合 $S$ についてこれを被覆するもので $\preceq$ に関して極小なものを与える $P \in D^k$ を推論したい.
kおのような $P$ のことを $k$-minimal multiple generalization (k-mmg) という.

> 上限 $k$ が決まってない場合は $S=P$ というのが自明な解である.
> これを防ぐために $k$ を設けるのである.

### 例

- $S = \{$
    - "00 **01** 11",
    - "01 **01** 11",
    - "10 **01** 11",
    - "00 **01** 00",
- $\}$

これの 2-mmg として $\{ 0001xy, xy0111 \}$ などがある.
$\{ xy01zw \}$ は 1-mmg であるが 2-mmg ではない.

### $k$-mmg の性質

手掛かりとなる性質を延べていく

1. reduced
1. tightest
1. $k$-division

### reduced

$S$ とこれを被覆する $k$-multiple $P$ $(S \subset L(P)$ について,
$$\forall Q \subset P, Q \ne P \implies S \not\subset L(Q)$$
このとき $P$ は reduced であるという.
余計なパターンを一つも含まないことを言う.

#### 補題

$P$ が $k$-mmg であるならば reduced である.

なぜなら reduced でないなら $S$ を被覆する $Q \subset P$ があって
$Q \prec P$ であるから minimal に反する.

### tightest

$P$ が $S$ について tightest であるとは,
各 $p \in P$ が $S \setminus L(P \setminus p)$ の minimal common generalization であることを言う.
つまり,
$$\forall p \in P, \not\exists q (q \prec p \land S \setminus L(P \setminus p) \subset L(q))$$
各 $p \in P$ が十分 refine されてることを言う.

#### 補題

$P$ が tightest であるなら reduced である.

reduced でないならある $p \in P$ があって
$S \setminus L(P \setminus p)$ なのでそう.

### Theorem 1

$S$ に対して $P$ が reduced でかつ $|P| = k$ のとき,
$P$ が tightest であることと $k$-mmg であることとは同値.

### $k$-division

$S$ を被覆する description $p \in D$ の $k$-division とは次のような
multiple description $P$ のこと

1. $P \preceq \{ p \}$
1. $1 < |P| \leq k$
1. $S \subseteq L(P)$

イメージとしては被覆を保ちながら $k$ 個のパターンに分割する手続きのこと.

$k$-division は必ずしも存在しない.
存在する時, その $p$ は $k$-divisible であるという.

#### 例

- $S = \{ "01", "12", "20" \}$
- $p = xy$
    - 3-division $\{ "01", "12", "20" \}$
    - 2-division は存在しない

### Theorem 2

$S$ を被覆する $k$-mutliple $P \in D^k$ が reduced であるとき,
$P$ が $k$-mmg であることは次の2つが成立することと同値

1. $P$ is tightest
1. $\forall p \in P, p$ is **not** $d$-divisible
    - ここで $d = k - |P| + 1$

### 戦略

1. 初期化
    - $P = \{ \top \}$
        - これは任意の $S$ に対して被覆であり tightest である
1. While $|P| < k$
    - $d$-division に従って $P$ から $P'$ を作る
        - $P \leftarrow P'$
        - divisible でなくなったら break
1. ここで得られた $P$ は k-mmg

もう少し具体的には次のように

```python
def kmmg(k: int, S: List[str]):
    P = tightestCovering([top])
    while len(P) < k:
        d = k - len(P)
        for p in P:
            T = S - L(P - p)
            if divisible(d, p, T):
                dP = division(d, p, T)
                P = P - p + tightestCovering(dP, T)

def divisible(k: int, p: RegularPattern, S: List[str]) -> bool:
    """p is k-divisible???"""

def division(k: int, p: RegularPattern, S: List[str]) -> Set[RegularPattern]:
    """k-division"""

def tightestCovering(P: Set[RegularPattern], S: List[str]) -> Set[RegularPattern]:
    """
    S とその被覆で tightest と限らない P を受け取って,
    P を tightest な被覆にしたものを返す

    assert len(tightestCovering(P, S)) == len(P)
    """
```

division の方法と tightestCovering の方法は大体貪欲に refine していけばいい.

### refine operator （パターンの近傍）

1. $[a/x]$ ($a \in \Sigma$)
1. $[xy/x]$

この2つの操作の合成で実は全ての代入は表現できる.
コレに従って探索してけばいい.


<section>
<div class="author">Angluin</div>
<div class="title">Positive Inference of Formal Languages from Positive Data</div>
<div class="public">Information and Control 45 (1980)</div>
<div class="note">[ang80.md](ang80.html)</div></section>

## INTRODUCTION

Solomonoff (1964) and Gold (1967)
は、
子供が自然言語の聞き取り、発話を学ぶ過程から、
AIが文法を学ぶモデルを記述できるかについて議論を行った.
特に Gold は学習可能について定義と言語学習の枠組みを与えた.
正提示から学習可能が言語クラスとして、
Angluin (1979) はパターン言語を導入した.

本稿の主な貢献は、
正提示から学習可能な言語クラスの特徴付けである
(十分条件を与えた?).

## DEFINITIONS

言語クラスは添字付き帰納言語:
$$\mathcal{C} = L_1, L_2, \ldots$$

言語の特徴関数 $f$:
$$f(i, w) = (w \in L)$$

## CHARACTERIZING CONDITION FOR POSITIVE INFERENCE

### Condition 1 (有限証拠; telltale)

言語 $L$ について
有限証拠 $T$ があること.
有限証拠とは:

1. $T$ は有限集合
1. $T \subseteq L$
1. $T \subseteq L'$ ならば $L' \not\subset L$

### Theorem 1

全ての言語が各tell-tale を持つような言語クラス
$$\mathcal{C} = \{ L_1,L_2,\ldots \}$$
は次の推論機械によって正提示から極限同定される.

#### 推論機械 (p.121)

- $g \leftarrow 0$
- For time $t=1,2,\ldots$
    - Let received set $S$ from presentation
    - find minimal $g'$ s.t.
        - $g \leq g'$
        - $S \subseteq L_g$
        - $T_g \subseteq S$
    - $g \leftarrow g'$ is guess

## OTHER CONDITIONS

Theorem 1 の系をいくつか述べる.

### Condition 2

### Corollary 1

### Condition 3 (有限の厚み; finite thickness)

言語クラス $\mathcal{C}$ が有限の厚みを持つとは、
任意の文字列の有限集合 $S$ について
$C(S) = \{ L : S \subseteq L, L \in \mathcal{C} \}$
の濃度が有限であること.

### Corollary 2

### Corollary 4

## EXAMPLES

## VARIATIONS OF CONDITION 1

### Theorem 2

Condition 2 を満たすが学習不可能な言語クラスが存在する.

### Condition 1'

### Theorem 3

Condition 1' を満たさないが学習可能な言語クラスが存在する.

## AVOIDING OVERGENERAL INFERENCES

### Condition 5 (極小言語)

部分帰納関数 $f$ を定義する.
文字列集合 $S$ について
$f(S)$
は
次を満たす添字 $i$ (descriptive という) を返す.

1. $S \subset L_i$
1. $\forall j, S \subseteq L_j \implies L_j \not\subset L_i$

> 我々はこの $L_i$ を、$S$を被覆する極小言語、と表現していた.

### Theorem 5

Condition 3,5 の両方を満たす言語クラスは、
consistent (無矛盾) で、
responsive で、
conservative (保守的) な推論機械によって
推論可能.

言語クラスを
$\mathcal{C} = \{L_1,L_2,\ldots\}$
とし、
Condition 5 で述べた関数を $f$ とする.

推論機械は次のようになる:

- $g \leftarrow \bot$
- For time $t=1,2,\ldots$
    - Let received set $S_t$ from presentation
    - If $S \not\subseteq L_g$
        - $g \leftarrow f(S_t)$
    - output $g$

証明を与える:

正提示が $L'$ から発生したとする.

$C_n = \{L:S_t \subseteq L\}$ とすると
$L' \in C_n$ であるので、
$C_n$ は空ではなく、
Condition 3 (有限の厚み) を仮定すると、
この $C_n$ は有限集合である.
非空有限集合なので、
言語の包含関係について極小なものを、
少なくともひとつ含む.
関数 $f$ は、まさにこの $C_n$ から一つ極小なものを選択する.
推論は $g_t=f(S_t) \in C_n$ であり、$C_n$ の構成の仕方から、まさに無矛盾である.

特に $\forall L \in C_1$ について

(ちょっと論文とは違う証明を試みる)

$L$ と $C_1$ とは、少なくとも $s_1$ という積を持っているから、次の3通りのいずれかである

1. $L' = L$
1. $L' \subset L$
1. $L' \setminus L \ne \emptyset$

2つめのような $L$ は、推測に使われることはない.
なぜならば、$f$ は極小言語を出すので、$L$ でなくよりも $L'$ のほうが小さいのだから.

従って、1,3 つめのような$L$だけが推測の候補である.
1つめが出てきたら、先の推測アルゴリズムは保守的なので、永遠に$L'$ を推論して収束する (そして正しく学習した).

推論が3つめのとき、
$L'$ に含まれて、$L$ に含まれない事例 $s$ がいつか提示される.
そのとき初めて推論を $L$ から別なものに変えるわけである.
それより以降、$L$ を再び推論に用いることはない.
なぜなら、 $L$ には $s$ が含まれず、矛盾するから.

というわけで、推論が3つめならば、いつかは必ず提示に矛盾することによって推論を変え続けるが、
推論がループすることはない.
推論としてあり得るものは有限通りなので、いつかは1つめの推論になる.
そのとき学習は成功する.

## REMARKS


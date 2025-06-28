% A Better-Than-Greedy Approximation Algorithm for the Minimum Set Cover Problem
% http://epubs.siam.org/doi/abs/10.1137/S0097539704444750
% 最適化 集合被覆

## 重み付き最小集合被覆問題

$E = \{ e_1, e_2 .. e_N \}$
に対して、$E$ の部分集合のコレクション
$F$
が与えられている
($S \in F \iff S \subseteq E$).

ただし $\bigcup_{S \in F} S = E$ が保証されている.

また、$S \in F$ にはコスト $c_S$ が予め与えられる.

集合被覆問題とは、$F$ の部分コレクション $SOL$ であって
$$\bigcup_{S \in SOL} S = E$$
を満たすものを求める問題である.

重み付き最小-問題とは、
そのような $SOL$ ので
$$\min \sum_{S \in SOL} c_S$$
を最小化するものを求める問題のこと.

また、
$\forall S \in F .~ |S| \leq k$ のとき、
k-set cover problem
と呼ぶ.

## 貪欲法

1. 状態として、すでに被覆した部分$C$ を持っておく.
1. 初め $C = \{\}$ とする.
1. 答えを入れる $SOL = \{\}$ を用意する.
1. 次を、$C = E$ になるまで繰り返す.
    - $r_S = c_S / |S \setminus C|$ が最小な $S$ を $F$ から探して選択する.
    - $S$ を答え $SOL$ に追加する
    - $F$ から $S$ を取り除く
    - $C$ に $S$ をユニオンする
1. $SOL$ を得る

V.Chvatal: "A Greedy heuristic for the set-covering problem"
はこの貪欲法の近似度を見積もっており、
k-set cover problem のとき、
$H_k = 1 + 1/2 + .. + 1/k$
の近似度であるらしい.

## 提案手法: The greedy algorithm with withdrawals (GAWW)

貪欲の改良を行う.
毎ステップで、
*Greedy step*
と
*Withdrawal step*
とを行う
(withdrawal       引っ込めること,引っ込むこと,退くこと / 引き上げ,回収 / 取り消し,撤回).

1. Given
    1. val $E$
    1. var $F = \{ S_1, S_2 .. S_N \}$
1. Init
    1. val $\alpha = 1 - 1/k^3$
    1. var $SOL = \{\}$
    1. 被覆してない集合 $U = E$
    1. every $S \in F$ について every $S' \subseteq S$ を $F$ に追加する.
    コストを $c_{S'} = c_S$ として、$S'$ の選択を $S$ の選択とあとから見做せば、問題に影響はない.
    ただし、$S' \subseteq S_1 \land S' \subseteq S_2$ があるときは $c_{S'}$ は $c_{S_1}$ と $c_{S_2}$ の小さい方を使う
    1. $F = \{ S_1 .. S_N .. S_M \}$ を得る
1. Iteration while $U \ne \{\}$
    1. $r_j = \frac{c_j}{|S_j \cap U|}$
    1. for every $S_j \in SOL$ and every subcollection $C \subseteq F$ of at most $k$ subsets such that $S_j \subseteq \bigcup_{S \in C} S$, let $w(C) := | \bigcup_{S \in C} S \cap U|$ be the number of still uncoverd items that belong to the subsets in $C$. If $w(C) \ne 0$, let $r(S_j, C) := (\sum_{i : S_i \in C} (c_i - c_j)) / w(C)$.
    1. $r_j$ が最小である $j'$ を選択する. $r(S_j, C)$ を最小とする $j'', C''$ を選択する.
    1. If $\alpha r_j' \leq r(S_j'', C'')$ のとき
        - Greedy step: $S_j'$ を選択する
            - $U \leftarrow U \setminus S_j'$
            - $SOL \leftarrow SOL \cup S_j'$
    1. Else
        - Withdrawal step: $SOL$ から $S_j''$ を引き払って $C''$ を代わりに追加する
            - $U \leftarrow U \setminus \bigcup_{S \in C''} S$
            - $SOL \leftarrow (SOL \setminus S_j'') \cup C''$
1. $SOL$ を得る

このあと長々と解析が始まる.

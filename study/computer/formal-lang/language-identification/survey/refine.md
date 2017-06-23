% 正データからの極限同定における極小言語戦略への精密化の適用

<section>
<div class="author">京都大学 大内、山本</div>
<div class="title">正データからの極限同定における極小言語戦略への精密化の適用</div>
<div class="public">[IPSJ 2008](http://ci.nii.ac.jp/naid/110006782676)</div>
<div class="note">[refine.md](refine.html)</div></section>

いわゆる正データからの極限同定を行う.

# 木パターン言語

- アルファベット集合 $\Sigma$
- 変数集合 $V$
- アリティ $arity: \Sigma \rightarrow \mathbb{N}$
    - $arity(f)$ を $f$ のアリティと呼ぶ
    - アリティが $0$ のアルファベットを定数と呼ぶ
    - 定数が存在することを要請する

これを用いて作られる一階述語論理の項を木パターンという.
代入とかが定義される.

- 同じ変数が高々一度しか出現しない: *正則木パターン*
- 定数が出現しない木: *定数なし木パターン*
- *定数なし正則木パターン*

# 精密化

精密化オペレータ $\rho$ とは
概念空間 (言語クラス) $\mathcal{C}$、仮説空間 (パターンクラス) $\mathcal{H}$ の上で定義される.
$$\rho : \mathcal{H} \rightarrow 2^\mathcal{H}$$

次の3つが成立すること.

1. $\forall h \in \mathcal{H}$、$\rho(h)$ が枚挙可能
1. $g \in \rho(h) \Rightarrow C(g) \subseteq C(h)$
1. $\rho$ でループしないこと: 仮説の列 $h_1 .. h_{n-1},h_n$ であって $h_{i+1} \in \rho(h_i), h_1 = h_n$ となるようなものが存在しない

$\rho$ で DAG ができる

$\rho^0(h) = \{h\}, \rho^1(h) = \rho(h)$,  
$\rho^{k+1}(h) = \{ g : h' \in \rho^k(h), g \in \rho(h') \}$
と再帰的に $\rho^k$ を定義する.  
$\rho^* = \bigcup_k \rho^k$ と定義する.

## 局所的有限性

次が成り立つとき、$\rho$ はこの性質を持つという.

$\forall h .~ \rho(h)$ が有限集合.

## 意味的完全性

次が成り立つとき、$\rho$ はこの性質を持つという.

任意の $h$ と $C' \subseteq C(h)$ について
$$h_0 = h, h_{i+1} \in \rho(h_i), h_n = C'$$
という
列 $h_1 .. h_n$ が存在すること.

# 極小言語戦略への精密化の適用

## 定理 3.1

推論マシン $M$ が保守的であるとは
$$\forall n .~ C(M(\sigma[n])) \supseteq content(\sigma[n+1]) \Rightarrow M(\sigma[n]) = M(\sigma[n+1])$$
とあること.
更新の必要がなければ、推論結果を変えないことである.

次の４つが成立するとき、概念空間 $\mathcal{C}$ は保守的に同定可能である.

1. $\rho$ が局所的有限
1. $\rho$ が意味的完全
1. ある有限集合 $T \subseteq \mathcal{H}$ があって: $\bigcup_T \rho^*(h) = \mathcal{H}$
1. 次を満たすような無限列 $h_1, h_2, .., h_n, ..$ は存在しないこと
    - $\forall i \geq 1 .~ h_{i+1} \in \rho(h_i) \land C(h_{i+1}) = C(h_i)$

証明は略.

### 学習手続き

いわゆる、有限の弾力性 (finite elasticity) があって、MINLが計算可能ならば可能な、
無矛盾かつ保守的な推論機械である.

1. Input
    - 無限列 $\sigma = e_1, e_2, ...$
1. $S \leftarrow \{\}$
1. For $i = 1,2, ...$
    - $S \leftarrow S \cup e_i$
    - If $e_i \in C(h_{i-1})$; ただし $h_0 = \bot, C(h_0) = \{\}$
        - $h_i = h_{i-1}$; 保守派
    - Else If $MINL(T,S,i) = None$
        - $h_i = h_{i-1}$
    - Else
        - $h_i = MINL(T,S,i) get$
    - Output $h_i$

### $MINL(T,S,n)$

探索の深さに制限を与えたMINLである.

1. Input
    - 仮説集合 $T$
    - 正例集合 $S$
    - 精密化探索の深さ $n$
1. $H_0 = T$
1. For $j = 0, 1, .. , n$
    - If $\exists h \in H_j .~ S \subseteq C(h) \land (\forall g \in \rho(h) .~ S \not\subseteq C(g))$
        - 上を満たす $h$ を一つ選択
        - return $Some(h)$
    - Else
        - $H_{j+1} = \{ g \in \mathcal{H} : g \in \rho(H_j) \land S \subseteq C(g) \}$
1. return $None$


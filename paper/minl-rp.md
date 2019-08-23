% 消去可能正規パターン言語は推論可能: "Polynomial Time Inference of Extended Regular Pattern Languages"
% https://link.springer.com/chapter/10.1007/3-540-11980-9_19
% 形式言語

## 概要

消去可能正規パターン言語クラスは,
[極小言語戦略](/dosoku/book/formallang/minl.html) によって
[正提示で極限同定可能](/dosoku/book/formallang/limit_identification.html)（単に推論可能という）.

この言語クラスは極小言語戦略を用いることで推論可能である.
ただしアルファベットサイズは 3 以上で, その汎化システムは完全であるものとする
$(L(p) \subseteq L(q) \iff p \preceq q)$.

## 消去可能正規パターン言語

### 正規パターンの定義

この論文では消去可能であるバリエーションを素の正規パターン言語に対して Extended と言っている.
この言語の定義は
[/dosoku/book/formallang/generalization_system.html](/dosoku/book/formallang/generalization_system.html)
にも書いたが簡単にここにも紹介する.

正規パターンとは次の要素から構成される:

- 有限かつサイズ 3 以上のアルファベット集合 $\Sigma = \{0,1,2,\ldots\}$
- 無限にある変数の集合 $X = \{x,y,z,\ldots, x_1, x_2, x_3, \ldots\}$

$(\Sigma \cup X)$ の長さ 1 以上の列（文字列）であって,
一つの変数は高々一度までしか出現しないとする（ここが正規）.
正規パターン全体を $RP$ と書く.

正規パターンに対しては代入という操作を定義する.
代入とは, 正規パターンから正規パターンへの準同型であってただしアルファベットは自分自身に写すもの全てを言う.
準同型とは文字列結合に関してであって, 次のような $\theta$ が代入である.
ただし $\cdot$ は文字列の結合を言う.

$$\begin{align*}
\theta & \colon RP \to RP \\
\theta & ( p_1 \cdot p_2 ) = \theta p_1 \cdot \theta p_2 \\
\theta & a = a ~~ (a \in \Sigma) \\
\end{align*}$$

技巧的に定義したように見えるが, もっと非形式的に述べれば「変数一つをパターンで置き換える」という操作と言うのと同じ.
例えば次のようなものが代入の例:

- $0x1y \mapsto 021y$ ($x$ を $2$ で置き換えた)
- $0x1y \mapsto 0x12z3$ ($y$ を $2z3$ で置き換えた)

さらにこれに加えて, 変数一つを消す操作も代入として特別に認める.
これが「消去可能」の意味.

- $0x \mapsto 0$

ただし $x \mapsto \epsilon$ という操作は, 代入の結果できたものが空文字列でそれはパターンではないので, そういうのは許さないことにする.
(空文字列をパターンと認めて話を進めてもいい気もするけど.)

### 正規パターン言語

正規パターン $p$ に何回かの代入操作を行うと $q$ になることを
$$p \preceq p$$
と書くことにする.

正規パターン $p$ についてこれが成す言語を $L(p)$ と書いて次で定義する.
$$L(p) = \{ q \preceq p \mid q \in \Sigma^+ \}$$
これを正規パターン言語という.
$$\mathcal L = \{ L(p) \mid p \in RP \}$$
を正規パターン言語のクラスという.

例えば
$L(x1y)$
とは $1$ を含む文字列全て $(1, 10, 01, 11, 010, 011, \ldots)$ からなる集合.

## 正規パターン言語クラスは有限の厚みを持つ

### 定理

パターン $p$ について, 出現するアルファベットの数を $|p|_a$ と書くことにする.

$p \preceq q$ のとき
$$|p|_a \geq |q|_a$$
が成り立つ.

代入の操作がアルファベットは必ずアルファベットに写すことから明らか.

さて, この定理は次の2つの事実を与える.

1. $s \preceq p$ を満たす $p$ は（同値なものを除いて）高々有限通りしかない
1. 極小言語を与える $p$ は長さが最小なもの

1つ目について.
$p$ が持つアルファベットは $|s|$ 個以下.
アルファベットを $n$ 個持つ消去可能正規パターンの長さは $2n+1$ 個と考えてよい.
なぜなら変数だけが連続で並ぶ部分は一つだけのものと同値 $(xy=x)$ なので, $n$ 個のアルファベットの前後に挟む場合しかない.
つまり高々変数は $n+1$ 個だけあり, また変数同士の区別は必要ない.
従って $s \preceq p$ なる $p$ というのは, せいぜい
$$|\Sigma|^{|s|} \times 2^{|s|+1}$$
個程度以下であることが分かる.

有限の厚みを持つとは任意の（空でない）文字列集合 $S$ に対して
$S \subset L(p)$
なる $p$ が有限通りしかないことを言うが, 今言った定理よりこれも成り立つ.

ここでは略すが有限の厚みを持つ言語クラスは極小言語戦略によって推論可能であることが知られている.

## 正規パターン言語の極小言語戦略

テキストの集合 $S$ が与えられた時, これを被覆する正規パターン全体は
$$E = \{ p \mid S \subset L(p) \} = \{ p \mid \forall s \in S, s \preceq p \}.$$
この中で極小なものを与える $q \in E$ を探す.
極小言語を与えるパターンのことを minimal common generalization という.

言い直すと, 見つけたいのは $S$ に対して次のような $q$.

- $\forall s \in S, s \preceq q$ であって
- $p$ が同様に $\forall s \in S, s \preceq p$ を満たすなら
- $p \not\prec q$ であること

### 存在の証明

前の定理より $E$ の中でそのアルファベットの数が最小なもの $q$ を選べば,
とりあえず $p \in E \implies p \not\prec q$ が保証できる.
代入の前後でパターンの長さがどう変わるかを考えるとよい (先の定理).

有限の厚みを持つことから候補は有限通りで, その中でアルファベットの数が最小のものを探しさえすればいいから, とりあえず minl を有限時間で探索する方法があることはわかった.

しかし, その候補は先に延べたように指数通りあるので, その全てを調べ上げることは実用的ではない. ここでは多項式時間で計算が終了するアルゴリズムのことを効率的であるとして, 効率的な方法を考える.

### 考察

- $S = \{$
    - 00*01*11
    - 11*01*11
    - 10*01*1
    - 00*01*01
- $\}$

直感的に $p = x01y$ が見えてくる.
なぜなら全て共通して $01$ が真ん中に出現するから.
最長共通部分列を見つければいいのでは?
あ、でもただし
[一般個数の列の最長共通部分列問題は NP-困難である](https://ja.wikipedia.org/wiki/%E6%9C%80%E9%95%B7%E5%85%B1%E9%80%9A%E9%83%A8%E5%88%86%E5%88%97%E5%95%8F%E9%A1%8C).
そこで longest ではなく maximal common subsequence を考える.
文字列の集合 $S$ に対して共通部分列全体を $CS(S)$ と書く.
maximal common subsequence とは $CS(S)$ の中で部分列関係に関する極大元のことである.
これを $MCS(S)$ と書くことにする.
$$s \in MCS(S) \iff s \in CS(S), (t \in CS(S) \implies s \not\sqsubset t)$$
ただし $s \sqsubset t$ とは $s$ が $t$ の部分列であること.

> longest と違って maximal なものはただ貪欲に作っていけばいいので比較的容易に構成できる.

### 補題

今 $s = (s_1, s_2, \ldots, s_k) \in MCS(S)$ だとする $(s_i \in \Sigma)$.
このとき, $s$ の各文字の間に適切に変数を挟んで出来るパターン $p$ が $S$ の minl を与える.

適切な変数の挟み方は次のような $k+1$ ステップで与えられる.

- とりあえず全部に変数を挟む
    - $q_0 = x_1 s_1 x_2 s_2 \cdots s_k x_{k+1}$
- 各変数について消せるだけ消す
    - $q_i = q_{i-1}[/x_i]$ if $S \subseteq L(q_i)$ ($[/x_i]$ は変数 $x_i$ の消去を表す)
    - $q_i = q_{i-1}$ otherwise
        - $i=1,2,\ldots,k$

これで得られる $q_{k+1}$ が minl を与える.

#### 証明

minl でないとすると, ある $q'$ ($q' \ne q_{k+1}$) があって
$$S \subseteq L(q') \subset L(q_{k+1})$$
である.
従って $q' \prec q_{k+1}$.
それぞれのパターンのアルファベット部分だけ取り出した文字列を
$c(q')$ などと書くと,
汎化関係より $c(q_{k+1})$ は $c(q')$ の部分列になっている.
一方で $c(q_{k+1})$ は $s$ であるし, また $s$ が $S$ の maximal common subsequence であることから, $c(q') = c(q_{k+1}) = s$.
つまり $q'$ に登場するアルファベットは $q_{k+1}$ と同様で $s_1, s_2, \ldots, s_k$ であることがわかった. $q'$ はこれにやはり変数を挟んだ形である.

さて $q' \prec q_{k+1}$ であったので, $q_{k+1}$ の変数に代入をすることで $q'$ は作れる.
変数にアルファベットを代入すると $c(q) \ne s$ になってしまうので駄目で, 変数に 0 個以上の変数を代入するしかない. 消去可能パターンでは 1 個以上の代入は同値なので
$q' \ne q_{k+1}$ のためにはどれかの変数を消去（空文字列の代入）するしかない.
変数消去の仕方を考えると次のパターンに分けられる.

1. そもそも変数が無い
    - $q_{k+1}$ は object なので instance を持たず矛盾
1. 全ての変数を消去する
    - $q'$ が object なので $S$ は単集合
    - そのような場合は作り方から $q_{k+1}$ も object (作る過程で全て変数を消去してる)
1. 消す変数と消さない変数がある
    - 初めて消す変数を $x_j$ とする ($x_j$ が $q_{k+1}$ にあるとして)
    - $q_{k+1}$ を作る途中の $q_{j-1}$ を考える
        - $q' \preceq q_{j-1}[/x_j]$
        - 従って $q_j$ を作るときに $x_j$ は消すハズ
        - 作り方に矛盾

各変数ごとに $S \subseteq L(q)$ を調べる必要があるが,
Aho らの ["The Design and Analysis of Computer Algorithms"](https://doc.lagout.org/science/0_Computer%20Science/2_Algorithms/The%20Design%20and%20Analysis%20of%20Computer%20Algorithms%20%5BAho%2C%20Hopcroft%20%26%20Ullman%201974-01-11%5D.pdf)
によれば, ちょうど $L(q)$ を受理する（つまり $q$ にマッチする）有限決定オートマトンを $O(|q|)$ で作ることができて, 全体として
$O(|q| + \sum_{s \in S} |s|)$
で検査出来る.

あとは MCS さえ効率的に求まればよいがこれは以下のように出来る.

```python
def subseq(t: str, s: str) -> bool:
    """t が s の部分列であるか?
    """
    i = 0
    j = 0
    while i < len(t) and j < len(s):
        if t[i] == s[j]:
            i += 1
            j += 1
        else:
            j += 1
    return i == len(t)


assert subseq("abc", "abc")
assert subseq("abc", "abcXX")
assert subseq("abc", "XXabc")
assert subseq("abc", "XXabcXX")
assert subseq("abc", "XXaXbcXX")
assert not subseq("abx", "abc")


def MCS(S: List[str]) -> str:
    """文字列集合 S の maximal common subsequence を返す
    """
    s = min(S, key=lambda t: len(t))  # 最短文字列を一つ用いてこれを切り貼りして作る
    sigma = ""  # mcs をこれに格納する
    n = len(s)
    while n > 0:
        for i in range(len(s) - n + 1):
            updated = True
            while updated:
                updated = False
                for j in range(len(sigma) + 1):
                    t = sigma[0:j] + s[i:i+n] + sigma[j:len(sigma)]
                    if all(subseq(t, s) for s in S):
                        sigma = t
                        updated = True
                        break
        n = min(len(s) - len(sigma), n - 1)
    return sigma
```

ただしここで, リストや文字列 `s` に対して `s[i:j]` とは, 0 から数えて `i` 文字目以上 `j` 文字目 **未満** を切り出した部分列である.
特に `i >= j` の場合は `s[i:j]` は空であることに注意.

つまり $s$ から $n$ 文字ずつ切り出して全パターンを試して上手く行ったらそれを使う, というのを $n$ を減らしながらやってく.
欲しい $\sigma \in MCS(S)$ のその長さは $|s|$ 以下であることは初めから分かってるので, 切り出す長さは $|s| - |\sigma|$ であることも用いている.

この `MCS` を用いて改めて minl を実装すると次のようなものになる.

```python
def minl(S: List[str]) -> RegularPattern:
    s = MCS(S)
    p = [Var if i % 2 == 0 else s[i / 2]
         for i in range(2 * len(s) + 1)]  # [Var, s[0], Var, s[1], ... Var]
    for i in range(0, len(p), 2):  # pos of Var
        q = p[0: i] + p[i + 1: len(p)]  # elimination i-th Var
        if covering(S, q):
            p = q

def covering(S: List[str], q: RegularPattern) -> bool:
    """L(q) が S を包含するかチェックする"""
    omitted
```

以上の手続きは全て多項式時間で実現できる.
また先に述べたように, 有限の厚みを持つことからこの minl によって正規パターン言語は推論可能である.

### 注意

今, 計算効率の都合上から maximal なものを考えたが, minl を与えるものは maximal であるとは限らない.



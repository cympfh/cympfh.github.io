# 正規パターン言語は推論可能

## 概要

[正規パターン言語](generalization_system.html) のクラスは
[極小言語戦略](minl.html) によって
[正提示で極限同定可能](limit_identification.html)（単に推論可能という）.

この言語クラスは極小言語戦略を用いることで推論可能である.
正規パターン言語はここでは **消去可能** な場合を考える.
（消去不能でも推論可能だったっけ？）
ただしアルファベットサイズは 3 以上あり, その汎化システムは完全であるものとする
$(L(p) \subseteq L(q) \iff p \preceq q)$.

## 参考文献

1.  T.Shinohara: "Polynomial Time Inference of Extended Regular Pattern Languages", 1991
    - Regular Pattern の minimal common genelization (mcg) を多項式時間で求める
1. Arimura+: "Finding Minimal Generalizations for Unions of Pattern Languages and its Application to Inductive Inference from Positive Data"
    - [www-ikn.ist.hokudai.ac.jp/~arim/papers/arimura_stacs94.pdf](http://www-ikn.ist.hokudai.ac.jp/~arim/papers/arimura_stacs94.pdf)
    - k-mmg を多項式時間で求める

## 正規パターン言語の極小言語戦略

そもそもこの正規パターン言語クラスについて極小言語を見つける方法があることを言う.

テキストの集合 $S$ が与えられた時, これを被覆する description 全体は
$$E = \{ p \mid S \subset L(p) \} = \{ p \mid \forall s \in S, s \preceq p \}.$$
この中で極小なものを与える $q \in E$ を探す.
（この $q$ のことを minimal common generalization という.）

言い直すと, 見つけたいのは $S$ に対して次のような $q$.

- $\forall s \in S, s \preceq q$ であって
- $p$ が同様に $\forall s \in S, s \preceq p$ を満たすなら
- $p \not\prec q$ であること

代入の前後でパターンの長さがどう変わるかを考えるとよい.

## 定理

パターン $p$ についてその文字数（長さ）を $|p|$ と書く.
また $p$ の中に出現するアルファベットの数を $|p|_a$ と書くことにする.

$p \preceq q$ のとき

- 消去不能: $|p| \geq |q|$
- 消去可能: $|p|_a \geq |q|_a$

が成り立つ.

この定理は次の2つの事実を与える.

1. $s \preceq p$ を満たす $p$ は（同値なものを除いて）高々有限通りしかない
1. 極小言語を与える $p$ は長さが最小なもの

1つ目について.
消去不能なら話は簡単で, $s \preceq p \implies |s| \geq |p|$ である.
長さが $|s|$ のパターンは有限通りしかない
（アルファベットは定義より有限であり, また同値なものだけを考えれば変数も高々 $|s|$ 種類しかないとおもっていいので）.
従って $s \preceq p$ なる $p$ は $(|\Sigma| + |s|)^{|s|}$ 通り以下だと言える.
次に消去可能な場合だが, こちらはアルファベットの数は $|s|$ 以下であって, 変数はその前後に挟むだけなので全体で $2|s|+1$ の長さが最長（変数が連続で並ぶパターンは一つだけのものと同値）. 従って全体の長さについて同様に上限があり, そのようなパターンは有限通り.

ところでこのことから
[「正規パターン言語は有限の厚みを持つ」](minl.html#%E5%AE%9A%E7%90%86-%E6%9C%89%E9%99%90%E3%81%AE%E5%8E%9A%E3%81%BF%E3%82%92%E6%8C%81%E3%81%A4%E8%A8%80%E8%AA%9E%E3%82%AF%E3%83%A9%E3%82%B9%E3%81%AF%E6%A5%B5%E5%B0%8F%E8%A8%80%E8%AA%9E%E6%88%A6%E7%95%A5%E3%81%AB%E3%82%88%E3%81%A3%E3%81%A6%E6%8E%A8%E8%AB%96%E5%8F%AF%E8%83%BD)
ということが言える.
従って定理より, 極小言語戦略によって極限同定がされることも言えた.

2つめについて.
極小を与えるには $p \not\prec q$ が必要で, これは $|p| \not\lt |q|$ を導く（消去不能の場合）.
従って $E$ の中でその長さが最小のものが候補になる.
長さ最小が複数あった場合だが, 長さが同じで同値でないパターン同士は汎化関係になく順序がつかないのでどうでもいい（これは非自明な気がするが証明略）.

以上の中で候補となるパターンは有限通りでしかもその候補の集合も与えられている.
すなわち
$n=|s|$ とすれば
$$(\Sigma \cup \{x_1, x_2, \ldots, x_n \} )^n$$
である（消去不能の場合）.
この中で確かに $s \preceq q$ であって長さ最小のものを出力すればよい.

（このように任意の $S$ に対してそれを被覆する言語の候補が高々有限であるとき, その言語クラスは「有限の厚みを持つ」と表現する.
そして実は有限の厚みを持つ言語クラスはいつも正提示から推論可能である [Shinohara91].）

## 効率的な探索

今述べた方法では指数通りの候補を調べ上げる必要があり非効率的である.
もっと効率的な探索を考える.
ここでアルゴリズムが効率的とは多項式時間で計算できることを言う.

## 考察

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

## 補題

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

### 証明

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



% 誤情報を含む正則パターン言語の多項式時間推論

<section>
<div class="author">大阪府立大学 竹内正幸、佐藤優子</div>
<div class="title">誤情報を含む正則パターン言語の多項式時間推論 (アルゴリズムと計算の理論)</div>
<div class="public">[数理解析研究所講究録 1998](http://repository.kulib.kyoto-u.ac.jp/dspace/handle/2433/62059)</div>
<div class="note">[false.md](false.html)</div></section>

タイトルの通り、
消去不能正則パターン言語の極限同定を行う.
示すのは
*無矛盾*
で
*保守的*
なものである.

無矛盾とは
普通に
$$\forall n .~ C(M(\sigma[n])) \supseteq content(\sigma[n])$$
のこと.

保守的とは
$$\forall n .~ C(M(\sigma[n])) \supseteq content(\sigma[n+1]) \Rightarrow M(\sigma[n]) = M(\sigma[n+1])$$
であった.

## 言語の近傍系

言語クラス $\mathcal{L}$.
言語 $L \in \mathcal{L}$ の近傍系 $\mathcal{N}_L \subseteq \mathcal{L}$
というものを定義する.

$L$ 自身が近傍系に含まれてることが要請される.
例えば、
$\mathcal{N}_L = \{L\}$、
$\mathcal{N}_L = \{L \cup S : S ~ \text{ is finite language } \}$
が近傍系である.

誤情報を含む言語$L$の正提示とは、
$L' \in \mathcal{N}_L$ の正提示のことである.
部分だけを上手くとり出せば、$L$ の正提示である.

## notation

無限列から集合への変換 (content) を $\hat{\cdot}$ で書く ($\hat{\sigma}$).

言語 $L$ と、
誤情報を含む正提示の断片
$S = \hat{\sigma[n]}$
と、
近傍系 $\mathcal{N}_L$ が無矛盾であるとは、
$$\exists L', L' \in \mathcal{N}_L \land S \subseteq L'$$
という $L'$ が存在すること.

- パターン $p$ に対して
    - $i$ 番目の文字を $p[i]$ と書く
    - 最短の語だけからなる言語 $S_1(p)$
    - $S_1(P) = \bigcup_{p \in P} S_1(p)$

## 正則パターン和言語で構成する近傍系

パターンの何文字目がアルファベット (定数) であるかを数える関数
$$I_c : \mathcal{P} \rightarrow 2^\mathbb{N}$$
$$I_c(p) = \{ i : i \in \{1 \ldots |p|\}, p[i] \in \Sigma \}$$

パターンの上の距離を表現する部分関数 $d$ を次のように定義する.

For $p, q$ s.t.  $|p| = |q|$ and $I_c(p) = I_c(q)$:
$$d(p, q) = |\{ i : i \in I_c(p), p[i] \ne q[i] \}|$$

この距離を用いて近傍系を定義していくことにする.

まず、
$$B(p,k) = \{ q : d(p,q) \leq k \}$$
なるものを定める.
$p$ の定数部分を高々 $k$ 個、変更してできるパターンの集合である.
$|B(p,k)| \leq |\Sigma|^{|p|}$ であることが分かる.

$P : P \subseteq B(p,k), p \in P$
を $p$ の k-近傍という.
逆に、 $p$ を $P$ の核パターンと呼ぶことにする.

k-近傍全体をk-近傍族 k-$\mathcal{NRP}_p$ と書く.
k-近傍族がなす、言語族を k-$\mathcal{NRPL}_p$ と書くことにする.

- k-$\mathcal{NRP}_p = \{ P : P \subseteq B(p,k), p \in P \}$
- k-$\mathcal{NRPL}_p = \{ L(P) : P \subseteq B(p,k), p \in P \}$

特に 1-近傍 のことを単に近傍 ($\mathcal{NRP}$) と呼ぶことにする.

### Example

$p=axbc, q=bybc$ ($x,y \in X$)
$P = \{ axbc, bxbc \}$
とすると、$P$ は $p$ の近傍でもあるし $q$ の近傍でもある.
$$L(P) \in \mathcal{NRPL}_p \cap \mathcal{NRPL}_q$$
従って、この近傍系は「無矛盾ではない」.

$L(P)$ が正提示されるとき、
確かにこれは $L(p)$ の誤情報付き正提示でもあるし、
確かにこれは $L(q)$ の誤情報付き正提示でもある.
従って、原理的に同定不可能である.

無矛盾に同定するためには、
２つの異なる近傍系は、集合の積を持ってはいけない.

そういうわけで、もっと条件を加えて、近傍系を定義する.

### 定義 4.2

正則パターン $p$ と、その ($k=1$) 近傍パターン集合 $P$
について、次の三種類の条件を考える.

1. 条件 $A_1$: $\forall i \in I_c(p)$ に対して $\{ a : p' \in P, a = p'[i] \in \Sigma \}$ が $\Sigma$ の*真*部分集合であること
2. 条件 $A_2$: $|P| \geq 2$ ならば、$\forall i \in I_c(p)$ に対して、$P \not\subseteq \{ p[i/a] : a \in \Sigma \}$ であること ($p[i/a]$ は $p$ の $i$ 番目をアルファベット $a$ で置換したもの)
3. 条件 $A$: 上の2つが同時に満たされること

条件1,2をそれぞれ満たす近傍パターン集合を、それぞれ
$A_1, A_2$ 近傍パターン集合 $\mathcal{NRP}_p^{A_i}$ と呼ぶ.
条件3を満たす近傍パターン集合を特別に
$A$近傍パターン集合 $\mathcal{NRP}_p^A$ と呼ぶ.

同様にその言語族を
それぞれ
$\mathcal{NRPL}_p^{A_i}$、
$\mathcal{NRPL}_p^A$
と書くよ.

### 定理 4.3

正則パターン $p, q$ の
$A_1$ 近傍パターン集合 $P, Q$ について、次の三つは同値である.

1. $L(P) = L(Q)$
1. $S_1(P) = S_1(Q)$
1. $P = Q$

$|\Sigma|=2$ のとき、$p$ の $A_1$ 近傍パターン集合とは $\{p\}$ しかないので、自明.

この定理があってもなお、
近傍パターン集合 $P$ から核パターン $p$ は一意に定まらない.
先ほどの例を思い出せばよい.
$\Sigma=\{a,b,c\}$、
$P=\{axbc, bxbc\}$は
$p=\{axbc\}, q=\{bxbc\}$
のどちらともの
$A_1$ 近傍パターン集合として正しい.

近傍パターン集合 $P$ が*極小多重汎化* であるとは、
無矛盾で極小であること.
$$S \subseteq L(P) \land \lnot \left( \exists Q, S \subseteq L(Q) \subseteq L(P) \right) .$$

### 定理 4.4

任意の $P \in \mathcal{NRP}^{A_1}$ は $S_1(P)$ の極小多重汎化である.

### $\mathcal{NRP}^{A_1}$ の極小多重汎化とその核パターンの推論

- Input: 文字列の有限集合 $S$
- Output: 正則パターン $p$ と、その近傍パターン集合 $P$
1. $S$ の 最長の極小汎化を計算して $p$ とする
1. $P \leftarrow \{\}$
1. $K \leftarrow \Sigma$
1. $m \leftarrow |p|$
1. $t \leftarrow 0$
1. 力尽きた
1. むりむり

> まーなんか要するにさ、
近傍パターン集合を直接学習して、
その核パターンを答えとする感じ？



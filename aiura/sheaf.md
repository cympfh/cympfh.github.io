% 層
% 2017-11-12 (Sun.)
% 層

## index

<div id=toc></div>
$$\def\O{\mathcal{O}}$$

## 前層 (preshaef)

二通りの定義を与える.

### 定義1

<div class=thm>
位相空間 $X$ の **前層** とは、
集合 $A$,
関数 $E: A \rightarrow \O(X)$,
関数 $\rceil: A \times \O(X) \rightarrow A$
($(a, U) \mapsto a \rceil U$)
からなる三組 $(A, E, \rceil)$ であって次のようなもの.

0. 任意の $a, b \in A$ に対して $a \rceil \emptyset = b \rceil \emptyset$
1. $a \rceil Ea = a$ $~~~$(註意: $\rceil$ の結合則は $E$ の適用より弱い)
2. $E (a \rceil U) = E a \cap U$
3. $(a \rceil U) \rceil V = a \rceil U \cap V$ $~~$ (註意: $\cap$ の結合則のが $\rceil$ より強い)
</div>

#### 例

関数の集合 $A$,
関数の定義域を与える手続き $E$,
普通の意味で関数の(定義域の)制限 $\rceil$.

註意すべき点として、層としての制限 $\rceil$ の右項には $Ef$ よりも広い集合を与えても構わないということ.
関数の制限 (これを区別する意味で $\lceil$ と書く) の右項には普通、ドメインより小さい領域を与えるだろう.
そこで次のように $\rceil$ を定め直せばよい:
$$f \rceil U := f \lceil (Ef \cap U)$$

また、ドメインが空集合な関数は空集合ただ1つである.
$$f \rceil \emptyset = \emptyset = g \rceil \emptyset$$

ドメイン (定義域) が空集合であるような関数は **存在しない** しないのではなく,
**唯1つ** 存在することに註意 (参考; [空関数](https://ja.wikipedia.org/wiki/%E7%A9%BA%E9%96%A2%E6%95%B0)).

> 明らかに前層とはこれを抽象化したものである

### 定義2

<div class=thm>
位相空間 $X$ の **前層** とは、
$X$ の開集合を適当な集合の集合 $\mathcal{A}$ に写すような
$$F : \O(X) \to \mathcal{A}$$
及び
$U,V \in \O(X)$ について
$U \subseteq V$ ならば
$$r_{UV} : F(V) \to F(U)$$
が定まっているようなもの.
これらの
$\left(F, r = \{ r_{UV} : U, V \in \O(X) \}\right)$
を前層だという.
ただし次を要請する.

0. $F(\emptyset)$ は単集合
1. $r_{UU}$ は恒等写像
2. $U \subseteq V \subseteq W$ のとき $r_{UW} = r_{UV} \circ r_{VW}$
</div>

こちらは圏論的に **関手** として前層を定義している (参考; [前層はモノイド(右)作用の一般化](http://cympfh.cc/taglibro/2018/07/17.html)).

これら2つの定義が等価であることを確認する.

### 定義1 → 定義2

<div class=thm>
前層が $(A,E,\rceil)$ で与えられた時、次で定義2を構成できる.

1. $F(U) = \{ f \in A : Ef = U \}$
1. $r_{UV}(f) = f \rceil U$
</div>

要請を満たすことを確認する.

0. $F(\emptyset) = \{ f : Ef = \emptyset \}$ は単集合か?
    - $f = f \rceil (Ef)$ より $f \in F(\emptyset) \Rightarrow f = f \rceil \emptyset$
    - $F(\emptyset)$ が 2つ以上の要素をもって $f,g$ がそうであるとき、
        - $f = f\rceil \emptyset = g\rceil \emptyset = g$
        - 従って、$F(\emptyset)$ は要素を高々1つしか持たない
    - また $F(\emptyset)$ は空集合でもない
        - 任意の $a$ について
            - $E(a \rceil \emptyset) = Ea \cap \emptyset = \emptyset$
        - であるので、$(a \rceil \emptyset) \in F(\emptyset)$
1. $r_{UU}$ は恒等写像か?
    - 明らか
2. $r_{UW} = r_{UV} \circ r_{VW}$
    - $r_{VW} : F(W) \to F(V)$
    - $r_{UV} : F(V) \to F(U)$
    - $f \in F(W) = \{ f : Ef = W \}$ について
        - $r_{VW}(f) = f \rceil V$
        - $(r_{UV} \circ r_{VW}(f) = (f \rceil V) \rceil U = f \rceil (V \cap U) = f \rceil U = r_{UV}(f)$

というわけでok.

### 定義2 → 定義1

<div class=thm>
逆に前層が $(F, r)$ で与えられたとき、
先ほどの全く逆によって構成できる.

1. $A = \bigcup_{U \in \O(X)} F(U)$
1. $f \in F(U) \iff Ef = U$
1. $f \rceil U = r_{VW}(f)$
    - where $V = U \cap W, W=Ef$
</div>

要請を満たすことを確認する.

0. $a,b \in A$ について
    - $a \rceil \emptyset = r_{VW}(a)$
        - ここで $V = \emptyset, W = Ef = U_a$ で
            - $r_{VW} : F(W) \to F(V)$
            - $F(V)$ は単集合であるので、 $r_{VW}$ は一点に写す関数
        - 従って $r_{VW}(a) = r_{VW'}(b)$
    - よって $a \rceil \emptyset = b \rceil \emptyset$
1. $f \rceil (Ef) = r_{VW} f$
    - ただし $V = Ef \cap W, W = Ef$
    - なので $V=W$ なんで $r_{VW}$ は恒等写像
    - というわけで、 $f \rceil (Ef) = f$
2. $f \rceil U = r_{VW}(f) \in F(V)$
    - ここで $V = U \cap Ef$
    - $E(f \rceil U) = V = U \cap Ef$
3. $(f \rceil U) \rceil V = f \rceil (U \cap V)$
    - 大体同様に

ところでしかし、この定義1と2とが本当に対応してるかを見るには、
定義1の前層を定義2に(上の方法で)した後、再び(上の方法で)定義1に戻して得た前層が、元の前層と同じ (あるいは同型) であることを確かめないといけない.

## 両立 (compatible)

前層 $A$ の2つの元 $f, g \in A$ が **両立** するとは、
<div class=thm>
$$f \rceil Eg = g \rceil Ef$$
</div>
とあること.

関数集合の例でいうと、
定義域の交わる部分で関数の値が一致することを表す.

## 層 (sheaf)

やはり二通りの定義を与える.

### 定義1

$X$ の上の前層 $A$ が次を満たすとき、$A$ を $X$ の上の **層** と呼ぶ.

<div class=thm>

- $\forall f,g \in F$ が両立するような $F \subset A$ に対して、次の2つを成立させる $g$ が唯一つ存在すること
    1. $\forall f \in F, g \rceil Ef = f$
    1. $Eg = \bigcup_{f \in F} Ef$
        - このような $g$ を $F$ に対して $\cup F$ と書く

</div>

#### 例

前に述べた関数の例は層である

### 定義2

定義1と同値な定義を与える.

<div class=thm>

位相空間 $X$ に対して
位相空間 $S$ と局所同相写像 $p: S \to X$ があるとき、
$(S, p)$ を $X$ の上の **層** という.

</div>

ここで $p: S \to X$ が局所同相写像とは、任意の点 $s \in S$ に対して、
定義域を $s$ を含むように適切に小さく制限して得た写像
$p \lceil U$
が同相写像であること.

### 定義1 → 定義2

層 $A$ が与えられた時、
$$\tilde{S} = \{ (x, f) ~:~ f \in A, x \in Ef \}$$
$\tilde{S}$ の上の同値関係
$$(x_1,f_1) \equiv (x_2, f_2) \iff
x_1=x_2
\land
\exists U (x \in U), U \subseteq Ef_1\cap Ef_2 \land
f_1 \rceil U = f_2 \rceil U$$
で割って
$$S = \tilde{S}\!\!\equiv$$
とする.
同値関係で明らかに $x$ については1つに定まるので
$$p : S \to X$$
$$p (x, f) = x$$
という関数が定まる.

$S$ に位相を入れる.
$x \in X$ の近傍を $V_x$ とするとき
$(x,f)$ の近傍を
$$\{ (y, f) /\! \equiv ~:~ y \in V_x\}$$
と定める.
これによって位相を入れる ([近傍によって位相を入れる](neigh-to-topo.html) 参照).

以上の $(S,p)$ が層 $A$ に対応する定義2の形の層である.

### 定義2 → 定義1

$X$ 上の層 $(S,p)$ から $(A,E,\rceil)$ の形の層を次のようにして構成できる.

$U \in \O(X)$
について
$$\Gamma(U) = \{ f : f:U \to S, p \circ f = i \}$$
として

1. $A = \bigcup \Gamma(U)$
1. $Ef=U \iff f \in \Gamma(U)$
1. $f \rceil V = f \lceil (V \cap Ef)$
    - 右辺は単なる関数の制限

定義2 であっても前層でかつ定義1の層と一致することがわかる.

ここで $\Gamma$ の定義で出てくる $i$ は $U \to X$ の埋め込みである.
$\Gamma(U)$ の要素は $p$ に対する $U$ 上の切断のこと.
以下のような可換図式が成り立つ.

```dot
digraph {
    rankdir=LR
    graph [bgcolor=transparent]
    node [shape=plaintext]
    U -> S [label=f];
    S -> X [label=p];
    U -> X [label=i];
}
```

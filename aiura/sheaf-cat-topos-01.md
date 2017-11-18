% 層・圏・トポス - 層
% 2017-11-12 (Sun.)
% 数学

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
からなる三組 $(A, E, \rceil)$ であって次のようなもの.

0. 任意の $a, b \in A$ に対して、$a \rceil \emptyset = b \rceil \emptyset$
1. $a \rceil Ea = a$ ($\rceil$ の結合則は $E$ の適用より弱い)
2. $E (a \rceil U) = E a \cap U$
3. $(a \rceil U) \rceil V = a \rceil (U \cap V)$
</div>

#### 例

関数の集合 $A$,
関数の定義域を与える手続き $E$,
(広い意味での) 関数の定義域の制限 $\rceil$.

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

これら2つの定義が等価であることを確認する.

### 定義1 $\Rightarrow$ 定義2

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

### 定義2 $\Rightarrow$ 定義1

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

## 両立 (compatible)

前層 $A$ の2つの元 $f, g \in A$ が **両立** するとは、
$$f \rceil Eg = g \rceil Ef$$
とあること.

関数集合の例でいうと、
定義域の交わる部分で関数の値が一致することを表す.

## 層 (sheaf)

やはり二通りの定義を与える.

### 定義1

$X$ の上の前層 $A$ が次を満たすとき、$A$ を $X$ の上の **層** と呼ぶ.

- $\forall f,g \in F$ が両立するような $F \subset A$ に対して、次の2つを成立させる $g$ が唯一つ存在すること
    1. $\forall f \in F, g \rceil Ef = f$
    1. $Eg = \bigcup_{f \in F} Ef$
        - このような $g$ を $F$ に対して $\cup F$ と書く

#### 例

前に述べた関数の例は層である

### 定義2

定義1と同値な定義を与える.

位相空間 $X$ に対して
位相空間 $S$ と局所同相写像 $p: S \to X$ があるとき、
$(S, p)$ を $X$ の上の **層** という.

#### 定義2 → 定義1

$X$ 上の層 $(S,p)$ から $(A,E,\rceil)$ の形の層を次のようにして構成できる.

$U \in \O(X)$
について
$$\Gamma(U) = \{ f : f:U \to S, p \circ f = id \}$$
として

1. $A = \bigcup \Gamma(U)$
1. $Ef=U \iff f \in \Gamma(U)$
1. $f \rceil V = f \lceil (V \cap Ef)$
    - 右辺は単なる関数の制限

定義2 であっても前層でかつ定義1の層と一致することがわかる.

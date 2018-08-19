% 層の射、直積、べき層、evaluation
% 2018-08-19 (Sun.)
% 層

## 層の定義

ここでは第一の定義の形で表されるものを対象にする.
即ち, 位相空間 $(X, \mathcal O_X)$ の上の層 $A$ とは集合 $A$ に

- 関数 $E : A \to \mathcal O_X$
- 二項演算 $\rceil : A \times \mathcal O_X \to A; a \rceil U \in A$

を与えたもの.
ただし次の4つが要請される.

0. 任意の $a, b \in A$ に対して、$a \rceil \emptyset = b \rceil \emptyset$
1. $a \rceil Ea = a$ ($\rceil$ の結合則は $E$ の適用より弱い)
2. $E (a \rceil U) = E a \cap U$
3. $(a \rceil U) \rceil V = a \rceil (U \cap V)$

## 層の射

層 $A, B$ の間の射 $A \to B$ とは, (2つを集合と見た時の) 関数 $f : A \to B$ であって,

1. $E(fa) = Ea$
1. $f(a \rceil U) = f(a) \rceil U$

とあること.
$f$ が層 $A$ から $B$ への射であることを, 関数の時と全く同様に
$$f : A \to B$$
と書いて表す.

下は $f$ が射になるための関数レベルの可換図式

```dot
digraph {
    graph [bgcolor=transparent];
    node [shape=plaintext];
    edge [arrowhead=vee];
    rankdir=LR;
    A -> B [label=f];
    A -> O_X [label=E];
    B -> O_X [label=E];
    { rank=same; A B }
}
```
```dot
digraph {
    graph [bgcolor=transparent];
    node [shape=plaintext];
    edge [arrowhead=vee];
    rankdir=LR;
    A -> A2 [label="⌉U"];
    A2 -> B2 [label=f];
    A -> B [label=f];
    B -> B2 [label="⌉U"];
    A2 [label=A];
    B2 [label=B];
    { rank=same; A A2 }
    { rank=same; B B2 }
}
```

### 恒等射

層 $A$ から $A$ 自身への射として自明なものとして恒等写像があり, これを $1$ と書くことにする.
$$1 : A \to A$$
$$1(a) = a$$

## 層の直積

2つの層 $A, B$ があるとき, 新しい層 $A \times B$ を構成してこれを $A$ と $B$ との直積と呼ぶ.
集合の (カルテシアン) 直積とは異なる (寧ろその部分集合) ので注意.

- $A \times B = \{ (a, b) | a \in A, b \in B, Ea = Eb \}$
    - $(a, b) \rceil U = (a \rceil U, b \rceil U)$
    - $E(a, b) = Ea ~(= Eb)$

> 明らかに $A \times A \simeq A$ である

### 射影

層の直積 $A \times B$ に対して次の2つが射としてある.

- $A \times B \to A$
    - $\pi_1 (a, b) = a$
- $A \times B \to B$
    - $\pi_2 (a, b) = b$

### 射の積

層 $A,B,C,D$ とそれらの間の2つの射

- $f: A \to B$
- $g: C \to D$

があるとき自然に

- $f \times g : A \times C \to B \times D$
- $(f \times g)(a, c) = (f a, g c)$

という射 $f \times g$ を定義することができる.

念の為に確認すると,

$f,g$ が射であることから $E(f a) = Ea$ と $E g(c) = Ec$ が従い,
$(a,c) \in A \times C$ であることから $Ea=Ec$ である.
従って $E(f a)=E(g c)$ なので
$(f a, g c) \in B \times D$ であることが分かって well-defined である.

## 層の冪

集合 $A, B$ に対して集合 $B^A$ を $A$ から $B$ への写像全体として定めたのと同様のことを層についても定める.
写像の代わりにちょうど層間の射 (のようなもの) を用いる.

層 $A, B$ があるとき層 $B^A$ を定めてこれを冪と呼ぶ.

- $B^A = \{ (f, V) | \text{関数}~f : A \to B, V \in \mathcal O_X \}$
    - $E(f,V) = V$
    - $(f,V) \rceil U = (f', V \cap U)$
        - $f'$ は $A \to B$ なる関数であって,
        - $f'(a) = f(a \rceil U)$
    - ただし $(f, V) \in B^A$ について次の2つを要請する:
        - $E(fa) = Ea \cap V$
        - $f(a \rceil U) = f(a) \rceil U$

さて, 元 $(f,V) \in B^A$ を, ただ単に $f \in B^A$ と書くことにする.
このとき $f$ には $Ef (=V) \in \mathcal O_X$ というデータが伴っているものとする.
単なる略記だと思えばよい.
例えば同じ一つの $f$ について異なる2元 $(f, V_1), (f, V_2)$ が $B^A$ に含まれることはありえるので,
この2つを単に $f$ と書いてしまうと区別ができないが, $Ef$ というデータが暗に持たされているのであくまで異なるものと考える.
(例えば一方を $f_1$ と書いてもう一方を $f_2$ と書くなど.)

この略記を用いて改めて $B^A$ の定義を書くと次のようになる.

- $B^A = \{ f | \text{関数}~f : A \to B \}$
    - $Ef \in \mathcal O_X$
        - (要請はあるがそれを満たすなら自由に定めてよい)
    - $f \rceil U$ は次のような関数 $f' : A \to B$
        - $f'(a) = f(a \rceil U)$
    - ただし
        - $E(fa) = Ea \cap Ef$
        - $f(a \rceil U) = f(a) \rceil U$

> $f \in B^A$ は射そのものではない.
> 射の第二の要請は定義に含まれるため満たされるが, 第一の要請 $E(fa)=Ea$ は一般には定義からは従わない.

## evaluation

$f \in B^A$ は関数であるので $a \in A$ を関数適用することができる.
この関数適用という操作自体が射であることを見ていく.

関数 $ev$ を次のように定める.
$$ev : A \times B^A \to B$$
$$ev : (a, f) \to f(a)$$

ただしこの定義域の直積は **層の直積** であることに注意.
すなわち, $(a,f) \in A \times B^A$ には $E(a,f)=Ea=Ef$ という制約がある.

関数 $ev$ は射である.

### $ev$ は射であることの証明

射の定義に照らしあわせて証明する.

i)
$$\begin{align*}
E(ev(a,f))
& = E(f(a))     & \cdots \text{関数evの評価} \\
& = Ef \cap Ea  & \cdots f \in B^A \text{ なので} \\
& = E(a,f)      & \cdots \text{層の直積}
\end{align*}$$
ii)
$$\begin{align*}
ev((a,f) \rceil U)
& = ev (a \rceil U, f \rceil U) & \cdots \text{直積の制限} \\
& = (f \rceil U)(a \rceil U)    & \cdots \text{関数evの評価} \\
& = f((a \rceil U) \rceil U)    & \cdots \text{冪の制限} \\
& = f(a \rceil U)     & \\
& = fa \rceil U       & \cdots \because f \in B^A \\
& = ev(a, f) \rceil U & \cdots \text{関数evを逆に使った}
\end{align*}$$

### 冪の普遍性

<div class=thm>
層 $A,B,C$ と射 $g : A \times C \to B$ があるとき, 次を可換にする射 $h : C \to B^A$ が $g$ に対して唯一存在する.

```dot
digraph {
    graph [bgcolor=transparent];
    node [shape=plaintext];
    edge [arrowhead=vee];
    rankdir=LR;

    "A×C" -> B [label=g];
    "A×C" -> "A×B^A" [label="1×h"];
    "A×B^A" -> B [label=ev];
    { rank=same; "A×C" "A×B^A" }
}
```
</div>

この定理は $A\times C \to B$ という射全体と, $C \to B^A$ という射全体とが一対一対応してることを言っている (随伴).

証明は, 図式を可換にするような射 $h$ が少なくとも1つは存在することと, このようなものが存在するならばそれらは等しいために唯一であることを示すという二工程に分けることにする.

#### 証明・存在性

TODO(明日書きます)

#### 証明・唯一性

TODO(明日書きます)

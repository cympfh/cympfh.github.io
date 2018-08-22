% 層の射、直積、冪、evaluation
% 2018-08-19 (Sun.)
% 層

## 層の定義

ここでは次のような形のものを層と呼ぶ.

<div class=thm>
位相空間 $(X, \mathcal O_X)$ の上の層 $A$ とは集合 $A$ に

- 関数 $E : A \to \mathcal O_X$
- 二項演算 $\rceil : A \times \mathcal O_X \to A; a \rceil U \in A$

を加えたもののこと.
ただし次の4つが要請される.

1. 任意の $a, b \in A$ に対して、$a \rceil \emptyset = b \rceil \emptyset$
1. $a \rceil (Ea) = a$
1. $E (a \rceil U) = Ea \cap U$
1. $(a \rceil U) \rceil V = a \rceil (U \cap V)$

</div>

ちなみに演算の優先度は,
$E$ (関数適用) $>$ $\cap > ~ \rceil$ .

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

<div class=thm>
関数 $ev$ を次のように定める.
$$ev : A \times B^A \to B$$
$$ev : (a, f) \to f(a)$$
</div>

ただしこの定義域の直積は **層の直積** であることに注意.
すなわち, $(a,f) \in A \times B^A$ には $E(a,f)=Ea=Ef$ という制約がある.

<div class=thm>
関数 $ev$ は射である.

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
</div>

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

まず関数 $h : C \to B^A$ を定義して, これが確かに射であることを確認する.
関数としては $c \in C$ に対して $f_c \in B^A$ とその $Ef_c$ (あるいは $(f_c, Ef_c) \in B^A$) を, 先の図式が可換になるように割り当ててやればよい.

可換であるとはつまり, $(a, c) \in A \times C$ について次の2つ

- $g(a, c)$,
- $ev((1 \times h)(a, c)) = ev(a, hc) = (hc)(a) = f_c(a)$

が等しいこと. そのようにしたいので, これをそのまま
$$f_c(a) = g(a, c)$$
として $f_c$ を定めればよい (仮の定義).

ただし注意として, 今考えた $(a, c)$ は直積から取ってきた点であるので $Ea=Ec$ という制約があり,
全ての点の $a$ について $f_c(a)$ の値が定まっているわけではない.
しかしながら $f_c$ は一般に $A \to B$ なる関数である必要があるので, 先程の $f_c$ の定義では未だ部分関数でしかない.

修正をします.
$$f_c(a) = g(a \rceil Ec, c \rceil Ea)$$
注意として $(a,c) \in A \times C (\iff Ea=Ec)$ については, 相変わらず $f_c(a)=g(a,c)$ を満たしているので可換性は守られている.

というわけで $c \in C$ に対して関数
$$f_c : A \to B$$
を定義することができた.

次に $Ef_c \in \mathcal O_X$ という値を定める.
これは $f_c$ とは独立に決めて良よくて, ここでは
$$Ef_c = Ec$$
と定める.
これは, 関数 $h$ を $h(c)=f_c$ という風に定めるつもりでいるのだが, $h$ が射であるようにするために
$$E(hc)=Ec$$
となる必要があるので, そのために自動的に決まる.

次に, 関数 $h : C \to B^A$ を定義する.
$$h(c) = (f_c, Ef_c) = (f_c, Ec)$$
とすればよい.
ただしこれが well-defined であることを確認する必要がある.
つまり $f_c \in B^A$ であるかだが, これは下のように確かめられる.

<div class=thm>
$f_c \in B^A$ の証明.

冪の定義に従って, 次の2つを確かめれば良い.

i. $E(f_c(a)) = Ea \cap Ef_c$
i. $f_c(a \rceil U) = f_c(a) \rceil U$

1つ目は
$$\begin{align*}
E(f_c(a))
& = E(g(a \rceil Ec, c \rceil Ea))     & \cdots f_c \text{ の定義} \\
& = E(a \rceil Ec, c \rceil Ea)        & \cdots g \text{ は射} \\
& = E(a \rceil Ec)                     & \cdots \text{ 直積の E の定義}\\
& = Ea \cap Ef_c
\end{align*}$$
なので.

2つ目は
$$\begin{align*}
f_c(a \rceil U)
& = g(a \rceil U \rceil Ec, c \rceil Ea \rceil U)     & \cdots f_c \text{ の定義} \\
& = g(a \rceil Ec, c \rceil Ea) \rceil U              & \cdots \text{ 直積の制限} \\
& = f_c(a) \rceil U
\end{align*}$$
なので.
</div>


以上で関数
$$h : C \to B^A$$
$$h(c) = (f_c, Ef_c)$$
が定義された!

次に $h$ が射であることを確認する.

i. $E(hc) = Ef_c=Ec$
i. $h(c \rceil U) = (f_{c \rceil U}, Ef_{c \rceil U}) = (f_{c \rceil U}, E(c \rceil U))$
    - $f_{c \rceil U}(a) = g(a \rceil Ec \cap U, c \rceil U \rceil Ea) = f_c(a) \rceil U = (f_c \rceil U)(a)$
        - よって (関数として) $f_{c \rceil U} = f_c \rceil U$
    - $Ef_{c \rceil U} = E(c \rceil U) = Ec \cap U = E(f_c \rceil U)$
        - 以上2つより $h(c \rceil U) = hc \rceil U$

であるので確かに,
<center>
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
</center>
を可換にするような射 $h : C \to B^A$ は少なくとも一つは存在する.

#### 証明・唯一性

与えられた $g$ に対してこのような $h$ は唯一しか存在しない.
これを示す常套的手段として次のような方法を取る.
今 $h$ の他に $h'$ があるとき, 実は $h=h'$ であることを示す.
これによって, 2つ以上存在することが言えなくなる.
先ほどの存在性と合わせることで, 唯一の存在であることが言えたことになる.

$h'$ もまた上の図式を可換にするような射であるとする.
$$\forall c \in C, h(c) = h'(c)$$
を示すことで $h=h'$ を言うことにする.

自由に取ってきた $c \in C$ について, $h(c) = h'(c)$ を言う.
注意として $h(c) \in B^A$ であるので,
この値の等価性を示すには $h(c)=(f,Ef)$ とすると $f$ の関数としての等価性と $Ef$ の集合としての等価性を合わせて言う必要がある.

i. 2つは射であるので
$$E(hc)=Ec=E(h'c)$$

ii. $h(c)=h'(c)$ を示す.
2つは $A \to B$ な関数なので, 好きに取ってきた $a \in A$ について
$h(c)(a) = h'(c)(a)$ を示せばよい.

今もし $Ea=Ec \iff (a,c) \in A \times C$ ならば, 可換性より即座に
$h(c)(a) = ev(a,hc)=g(a,c)=\cdots=h'(c)(a)$
が言える.

さて
$E(h(c)(a))=E(f_c(a))=Ef_c\cap Ea=Ec \cap Ea$
であるので
$h(c)(a) = h(c)(a) \rceil Ec \cap Ea ( \in B)$
であるが,
$$\begin{align*}
h(c)(a) \rceil Ec \cap Ea
& = h(c) (a \rceil Ec) \rceil Ea  & \cdots h c \in B^A \text{ なので} \\
& = (hc \rceil Ea) (a \rceil Ec)  & \cdots h c \in B^A \text{ なので} \\
& = (h(c \rceil Ea)) (a \rceil Ec)  & \cdots h \text{ が射なので} \\
\end{align*}$$
であるので結局 $(a',c')=(a \rceil Ec, c \rceil Ea)$ を $h$ に適用した場合を考えればよくて,
このとき $Ea'=Ec'$ であるので先ほどの議論から $h$ の値と $h'$ の値は等しい.

以上から $h=h'$.

### メモ

層 $A$ から $B$ への射全体を圏論的に $Hom(A,B)$ と書いてやると,
今の定理はつまり
$$Hom(A \times C, B) \simeq Hom(C, B^A)$$
であることを主張していた.

この $A$ の部分を隠してやると, 適当な $F,G$ を用いて
$$Hom(F(C), B) \simeq Hom(C, G(B))$$
と書き直せる.
これを随伴 [wikipedia](https://ja.wikipedia.org/wiki/%E9%9A%8F%E4%BC%B4%E9%96%A2%E6%89%8B) という. $F,G$ を随伴関手という.

### メモ

今の定理はカリーハワード対応を書いてやると

- 論理
    - $\left( (A \land C) \implies B \right) \iff \left( C \implies A \implies B \right)$
- プログラム (Haskell)
    - `(a, c) -> b` $\iff$ `c -> a -> b`
    - 左から右をカリー化という

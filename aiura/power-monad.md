% 冪集合モナド
% 2018-07-08 (Sun.)
% 圏論

## Kleisli triple の定義

圏 $C$ があるとする.
Kleisli triple (単に triple) とは次の $(T,\eta,-^{\#})$ という三つ組:

1. $C$ の対象を $C$ の対象に割り当てる関数 $T: Ob(C) \to Ob(C)$
1. $C$ のそれぞれの対象 $A$ について $\eta_A : A \to TA$ という射を与えるもの
1. $C$ の射 $f : A \to TB$ に対して、射 $f^{\#} : TA \to TB$ を与えるもの

ただし次を要請する:

1. 射 $f : A \to TB$ について、$f = f^\# \circ \eta_A$
1. 対象 $A$ について、$\eta_A^\# = 1_{TA}$
1. 射 $f: A \to TB, g: B \to TC$ について、$g^\# \circ f^\# = (g^\# \circ f)^\#$

### 冪集合 triple

対象が全ての集合で、射が写像であるような圏 $Sets$ を考える.
対象 $A$ に対して
$$A \mapsto PA=\{X : X \subseteq A\}$$
という割り当てを考えられる.
この $P$ は冪集合を作っているわけだが、これは適切な $\eta, -^{\#}$ によって triple になる.

$\eta_A : A \to PA$ を考える.
自明なものとしては
$$\eta_A (a) = \{a\}$$
がある. これを採用する.

要請の1から適切な $-^{\#}$ を考える.
$$\begin{align*}
f(a) & = f^\#(\eta_A(a)) \\
     & = f^\#(\{a\})
\end{align*}$$
これが成り立つためには $f(a) \in PB$ に注意すれば
$$f^\#(\alpha) = \bigcup_{a \in \alpha} f(a)$$
とすればよいことが分かる.

残りの要請2,3がたしかに成立していることを確認する.

#### 要請2

$$\begin{align*}
\eta_A^\# & : PA \to PA \\
\eta_A^\#(\alpha)
& = \bigcup_{a \in \alpha} \eta(a) \\
& = \bigcup_{a \in \alpha} \{a\} \\
& = \alpha
\end{align*}$$
となって確かに $\eta_A=1$ となっている.

#### 要請3

- $f: A \to PB, f^\#: PA \to PB$
- $g: B \to PC, f^\#: PB \to PC$

について、
$$\begin{align*}
(g^\# \circ f^\#)(\alpha)
& = g^\# \left( \bigcup_{a \in \alpha} f(a) \right) \\
& = \bigcup_{b \in \bigcup_{a \in \alpha} f(a)} g(b) \\
& = \bigcup_{a \in \alpha} \bigcup_{b \in f(a)} g(b) \\
(g^\# \circ f)^\#(\alpha)
& = \bigcup_{a \in \alpha} g^\#(f(a)) \\
& = \bigcup_{a \in \alpha} \bigcup_{b \in f(a)} g(b) \\
\end{align*}$$
であるので確かに2つは一致している.

## 冪関手 (fmap)

triple における $T$ 、冪集合の例での $P$ は単に対象を対象に割り当てるものだったが、
同様に射にも割り当てを構成することで (自己) 関手となる.
それには下の図式を用いる.

```dot
digraph {
    rankdir=LR;
    bgcolor=transparent;
    node [shape=plaintext];
    A -> B [label=f]
    B -> TB [label=eta_B]
    TA -> TB [label="(eta_B . f)#"]
}
```

即ち射 $f: A \to B$ に対して
$$Tf := (\eta_B \circ f)^\#$$
とする.

冪集合 triple $P$ の場合、これは次のようになる.
$$\begin{align*}
f & : A \to B \\
Pf & : PA \to PB \\
Pf(\alpha)
&= (\eta \circ f)^\#(\alpha) \\
&= \bigcup_{a \in \alpha} (\eta \circ f)(a) \\
&= \bigcup_{a \in \alpha} \{f(a)\} \\
&= \{ f(a) : a \in \alpha \}
\end{align*}$$

## 自然変換

圏 $C,D$ について2つの関手 $F,G : C\to D$ があるとする.
$C$ の各対象 $A$ に対して、$D$ の射:
$$\alpha_A : FA \to GA$$
を割り当てるような $\alpha$ を自然変換という.
ただし、次を要請する.

- $C$ の射 $f: A \to B$
    - それを $F, G$ で写した
        - $Ff: FA \to FB$
        - $Gf: GA \to GB$
    - $\alpha$ が与える
        - $\alpha_A : FA \to GA$
        - $\alpha_B : FB \to GB$
- これらについて、
    - $GF \circ \alpha_A = \alpha_B \circ Ff$

これを図式で書くと、下が可換であるということ

```dot
digraph {
    rankdir=LR;
    bgcolor=transparent;
    node [shape=plaintext];
    FA -> GA [label="α_A"];
    FB -> GB [label="α_B"];
    FA -> FB [label=Ff];
    GA -> GB [label=Gf];
}
```

### 冪集合の例

冪集合 triple で登場した $\eta$ はそのまま、自然変換 $1 \to P$ と見做すことができる.
即ち $\eta_A : A \to PA, a \mapsto \{a\}$ であったが、

```dot
digraph {
    rankdir=LR;
    bgcolor=transparent;
    node [shape=plaintext];
    A -> PA [label="η_A"];
    B -> PB [label="η_B"];
    A -> B [label=f];
    PA -> PB [label=Pf];
}
```

は確かに可換である.
念の為に確認すると、

- $(Pf \circ \eta_A)(a) = Pf(\{a\}) = \{f(a)\}$
- $(\eta_B \circ f)(a) = \{f(a)\}$

## モナド

圏 $C$ のモナドとは次のような三つ組 $(T,\eta,\mu)$ のことを言う.

1. $C$ から $C$ への (自己) 関手 $T$
1. 自然変換 $\eta: 1 \to T$
1. 自然変換 $\mu: T \circ T \to T$

ただし、次の２つの図式を可換にすることを要請する:

[TODO: ここに図式を書く. それまでは画像検索してもらうこと.]

Kleisli triple とモナドは等価で、違いは $f^\#$ と $\mu$ だが、それらは

- $\mu_{T^2A} = 1_{TA}^\#$
- $f^\# = \mu_{T^2B} \circ Tf$

で変換可能.

### 冪集合モナド

関手 $P$ と
自然変換 $\eta : 1 \to P$ 及び自然変換 $\mu : P^2 \to P$

$$\begin{align*}
\mu_A & : P^2A \to PA \\
\mu_A(\alpha) & = \bigcup_{a \in \alpha} a
\end{align*}$$

です.

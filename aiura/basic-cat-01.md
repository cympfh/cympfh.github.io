% ベーシック圏論 - 圏・関手・自然変換
% 2017-02-04 (Sat.)
% 数学 圏論

## INDEX

<div id=toc></div>

## 群・モノイドの圏

### 群

群とは集合に乗算の構造を入れたもので、単位元と逆元の存在を要請したものであった.
これは対象が唯一つからなる圏に相当する.
すなわち
群 $G = \{e, g_1, g_2, \ldots\}$ をつぎのような圏に対応させる:

```dot
digraph {
    graph [ bgcolor=transparent ];
    node [ width=0.0; shape=plaintext; ];
    edge [ arrowhead=vee ]
    G:nw -> G:ne;
    G:e -> G:se;
    G:s -> G:w;
}
```

対象は唯一つ (仮に、群 $G$ に対して対象 $G$ と名前付けしておく) で、
群の元 $g$ に対して射 $g: G \to G$ を対応させる.
加えて次の3つの条件を要請する.

1. 単位元 $e$ には恒等射 $e=1$
1. 群の乗算 $g_1 \circ g_2$ には射の合成 $g_1 \circ g_2$ を対応させる.
1. 射は全て同型射 (iso) である
    - 同型射であるとは逆射が存在すること
        - $(\forall f. \exists g. f \circ g = 1 \land g \circ f = 1)$
    - もちろん逆元を逆射に対応付けるのである

### モノイド

最後の条件「射は全て同型射」を取り除けば、ちょうど、群から「逆元が存在すること」という条件を取り除いたモノイドになる

## 群・モノイドの作用

群として書くが、逆元の性質は使わないので、
適宜モノイドとして読み替えても構わない内容である.

### 左作用

群 $G$ の集合 $S$ への作用とは、
元 $g \in G$ を $S \to S$ な一つの写像だと見做すことであった.
ここでは形式的に、次のような $\rho$ を$G$ の $S$ への左作用とする.

$$\rho : (G, S) \to S$$
$$\rho(g,s) = s'$$

$\rho$ は $G$ を $Hom(S,S)$ に写すしてるとも思えるので、そのような書き方も許容する.

$$\rho : G \to Hom(S,S)$$
$$\rho(g) = f
~~\text{s.t.}~~
f(s) = s'$$

群を写像に対応させる肝は、群の乗算を写像の合成に対応させたいから.
あと単位元は恒等写像になることを要請する.

- $\rho(e) = 1$
- $\rho(g_1 \circ g_2) = \rho(g_1) \circ \rho(g_2)$

この2つ目だが、書き換えると実際に $s \in S$ を適用させて書き直すと、
次のようなことを言っている:

$$\begin{align}
\rho(g_1 \circ g_2, s)
& = \rho(g_1, \rho(g_2, s)) \\
& = \rho(g_1, f_2(s)) \\
& = f_1(f_2(s))
\end{align}$$

さて、このような $\rho$ は、関手になっていると考えられる.
すなわち、対象が唯ひとつから成る圏 $G$ から、
対象が集合で射が写像な圏 $Sets$ への関手である.

- 唯ひとつの対象は、
    - $\rho(G) = S$.
- 元 $g$ を対応する写像に写す:
    - $\rho(g) = f$.

恒等射と、射の合成については先述したとおりで、

$$\rho(g_1 \circ g_2) = \rho(g_1) \circ \rho(g_2)$$

とすればいいのである.

```dot
digraph {
    graph [ bgcolor=transparent ];
    node [ width=0.0; shape=plaintext; ];
    edge [ arrowhead=vee ]
    rankdir=LR;
    G -> G2 [label=g1];
    G2 -> G3 [label=g2];
    G2 [label=G];
    G3 [label=G];

    S -> S2 [label=f1];
    S2 -> S3 [label=f2];
    S2 [label=S];
    S3 [label=S];

    {rank=same; G S}
    {rank=same; G2 S2}
    {rank=same; G3 S3}

    G -> S [label="ρ" style=dotted];
    G2 -> S2 [label="ρ" style=dotted];
    G3 -> S3 [label="ρ" style=dotted];
}
```

### 右作用

ほぼ同様であるが次のような $\rho$ を群 $G$ の集合 $S$ への右作用という.


$$\rho : (S, G) \to S$$
$$\rho(s, g) = s'$$

写像 (射) の合成についてだけ、左作用と異なって註意が必要で、

$$\begin{align}
\rho(s, g_1 \circ g_2) \\
& = \rho(\rho(s, g_1), g_2) \\
& = \rho(f_1(s), g_2) \\
& = f_2(f_1(s)) \\
\end{align}$$

と、適用の順序が逆になる.


```dot
digraph {
    graph [ bgcolor=transparent ];
    node [ width=0.0; shape=plaintext; ];
    edge [ arrowhead=vee ]
    rankdir=LR;
    G -> G2 [label=g1];
    G2 -> G3 [label=g2];
    G2 [label=G];
    G3 [label=G];

    S -> S2 [label=f1 dir=back];
    S2 -> S3 [label=f2 dir=back];
    S2 [label=S];
    S3 [label=S];

    {rank=same; G S}
    {rank=same; G2 S2}
    {rank=same; G3 S3}

    G -> S [label="ρ" style=dotted];
    G2 -> S2 [label="ρ" style=dotted];
    G3 -> S3 [label="ρ" style=dotted];
}
```

つまり、$f_1 = \rho(g_1)$ は $S \to S$ なのでわかりにくいけど、合成したときに、
元の $g_1$ と逆順になってることが分かる.

右関手の $\rho$ は、元の射を逆向きの射に写しているので、
これはまさに **反変関手** である.

## 双対(線形)空間

2つの線形空間 $V,W$ の間の線形写像全体を
$Hom(V,W)$
などと書く.

- 線形空間 $V, V', W$ について
    - 線形写像 $f \in Hom(V, V')$ に対して
    - 写像 $f^*$ を次のように定める
        - 引数を $g \in Hom(V', W)$ として、これを
        - $f^*(g) = g \circ f$ に写すもの

```dot
digraph {
    graph [ bgcolor=transparent ];
    node [ width=0.0; shape=plaintext; ];
    edge [ arrowhead=vee ]
    rankdir=LR;
    V -> V2 [label=f];
    V2 -> W [label=g];
    V2 [label="V'"];
}
```

線形空間 $W$ を固定して考えて、
自由に選んだ $f: V \to V'$ について以上のように $f^*$ を定めることができる.
では $f \mapsto f^*$ なる関数は一体何なのだろうか.
$f^*$ の型を考えると整理が附く.

$$f : V \to V'$$
$$f^* : Hom(V', W) \to Hom(V, W)$$

つまりこれは
$Hom(-,W)$
なる **反変** 関手である.
線形空間からなる圏から、線形写像からなる圏に写している.

> 括弧内の $-$ という記号は、そこを引数にする関数であることを示す.
> 例えば
> $A(-)$ とは $x \mapsto A(x)$ なる関数で、
> $B(-,y)$ とは $x \mapsto B(x,y)$ なる関数である.

とくに自明な $W$ として、体 $K$ を選んで、
$V, V', \ldots$ を $K$ の上の線形空間に限るとする.
関手 $Hom(-,K)$ は線形空間 $V$ を $Hom(V,K)$ に写すわけだが、
この $Hom(V,K)$ を $V$ の双対空間と呼んで $V^*$ と書いたりする.
(${}^*$ は $f^*$ の ${}^*$.)

## 反対圏と圏同型

### 反対圏

反対圏 (opposite category) または双対圏 (duality category)
("opposite" のが一般的っぽい)
とは、
形式的に射の向きを全て変えたものである.

フォーマルな定義としては次のようなもの.

圏 $\mathcal{C}$ の反対圏 $\mathcal{C}^{op}$ とは、

- $Ob(\mathcal{C}^{op}) = Ob(\mathcal{C})$
    - $A \in \mathcal{C}$ に対して明示的に $A^{op} \in \mathcal{C}^{op}$ とも書くが、大抵気にせず $A \in \mathcal{C}^{op}$ とも書く
- $Hom_{\mathcal{C}^{op}}(A,B) = Hom_\mathcal{C}(B,A)$
    - 明示的に、$f: B \to A$ に対して $f^{op}: A \to B$ と書く.

そして $\mathcal{C}^{op}$ における射の合成則は $\mathcal{C}$ から自然に導かれるもので定める:

$$f \circ g = h \iff g^{op} \circ f^{op} = h^{op}$$

```dot
digraph {
    graph [ bgcolor=transparent ];
    node [ width=0.0; shape=plaintext; ];
    edge [ arrowhead=vee ]
    rankdir=LR;
    subgraph cluster_0 {
        label="C-op"
        A -> B; B -> C [dir=back];
        A [label=""]
        B [label=""]
        C [label=""]
    }
    subgraph cluster_1 {
        label="C"
        D -> E [dir=back]; E -> F;
        D [label=""]
        E [label=""]
        F [label=""]
    }
}
```

### 圏同型

#### (共変) 関手

圏の間の (共変) 関手とは次のようなものであった.
関手 $F: \mathcal{C} \to \mathcal{D}$ とは

- 対象に関する写像
    - $\forall A \in \mathcal{C}, \exists B \in \mathcal{D}, F(A) = B$
- 射に関する写像
    - $\forall f \in \mathcal{C}, \exists g \in \mathcal{D}, F(f) = g$

そして射の合成についても整合性が取れるように (準同型) 写すことを要請する:

$$F(f \circ g) = F(f) \circ F(g)$$

#### 圏の圏

対象を圏、射を関手とするような圏が考えられる.
これは「圏の圏」 $\mathbb{CAT}$ と呼ばれる.

#### 対象の同型

圏 $\mathcal{C}$ において対象 $A$ と $B$ とが同型であるとは、
その間に双方向の射

- $f: A \to B$
- $g: B \to A$

があって、一方が他方の逆射になってること.
つまり

- $f \circ g = 1$
- $g \circ f = 1$

が成立すること.

$$A \cong B$$
と書く.

#### 圏の同型

圏 $\mathcal{A}$ と $\mathcal{B}$ とが同型であるとは、
その間に双方向の関手があって、一方が他方の逆関手になっていること.
これはつまり、圏の圏において、対象として同型であること、と同じことを言っている.
そして対象の時と全く同様に
$$\mathcal{A} \cong \mathcal{B}$$
と書く.

#### 反対圏と圏同型

反対圏は元の圏と同型であるか?
一般に同型ではない.

対象が3つくらいあって、その中に多少複雑に射が張っている圏では明らかに同型でないことが分かる.
次は先ほど見せた例である.

```dot
digraph {
    graph [ bgcolor=transparent ];
    node [ width=0.0; shape=plaintext; ];
    edge [ arrowhead=vee ]
    rankdir=LR;
    subgraph cluster_0 {
        label="C-op"
        A -> B; B -> C [dir=back];
        A [label="X"]
        B [label="Y"]
        C [label="Z"]
    }
    subgraph cluster_1 {
        label="C"
        D -> E [dir=back]; E -> F;
        D [label="X"]
        E [label="Y"]
        F [label="Z"]
    }
}
```

関手 $F: \mathcal{C} \to \mathcal{C}^{op}$ を考える.

$\mathcal{C}$ において $Y \to X$ がある.
これを $\mathcal{C}^{op}$ では
$F(Y) \to F(X)$
に写す必要がある.
対称性を考えれば

- $F(Y) = X \in \mathcal{C}^{op}$
- $F(X) = Y \in \mathcal{C}^{op}$

としたくなるが、
加えて
$Y \to Z$
を $F$ で写す先を考えると

- $F(Y) = Z \in \mathcal{C}^{op}$
- $F(Z) = Y \in \mathcal{C}^{op}$

となる.
つまり、$Y$ を $X, Z$ のどちらにも写したい (この時点で写像になっていない) し、
$X,Z$ をどちらも $Y$ に写したい (逆関手が構成できないことを示唆する).

別に関手それ自体は、行き先の圏全体に (全写像として) 写す必要はないし、部分圏に写すものは実際に今の例でも作れるが、そうすると逆関手が作れない.

というわけで、2つの圏は同型ではない.

次に対象が一つだけな圏を考える.
これは一般にモノイドに相当することは先述した.

```dot
digraph {
    graph [ bgcolor=transparent ];
    node [ width=0.4 height=0.5 shape=plaintext fixedsize=true ];
    M:nw -> M:ne;
    M:e -> M:se;
    M:s -> M:w;
    M [label=M];
}
```

```dot
digraph {
    graph [ bgcolor=transparent ];
    node [ width=0.4 height=0.5 shape=plaintext fixedsize=true ];
    M:nw -> M:ne;
    M:e -> M:se;
    M:s -> M:w;
    M [label="M-op"];
}
```

全ての射は唯ひとつの対象 ($M$ としておく) から出てそれ自身へ戻るから、
反対圏を考えても、図式それ自体は変わらないように見える.
それは合成則は図式には現れないからである.

つまり、
$$F(f) = f^{op}$$

なる関手を考えればこれが同型を与えるように思えるのだが、それは誤りである.
すなわち、
関手が要請するのは
$$f \circ g = h \iff F(f) \circ F(g) = F(f \circ g) = F(h)$$

であるが
反対圏における合成則は、ただ次のものである:
$$f \circ g = h \iff g^{op} \circ f^{op} = h^{op}$$

というわけで、単に $f$ を $f^{op}$ に写すだけの $F$ は同型を与えはしないし、
一般には対象が唯ひとつだろうが、
反対圏は同型ではない.

#### 群の反対圏 (opposite group)

群 $G$ を唯ひとつの対象からなる圏
$\mathcal{G}$
と見做す.
この時、
$\mathcal{G}$
と
$\mathcal{G}^{op}$
は同型である.

この事実は、射には常に反対射が存在することと、
$(f \circ g)^{-1} = g^{-1} \circ f^{-1}$
という性質によるものである.
ちょうど反対圏での合成が交換されることと対応している.
すなわち、

$$F(f) = f^{-1}$$
$$(F(f) = (f^{-1})^{op})$$

という関手が同型を与える.

## 自然変換

射を対象と見做した時にその間の射を関手と呼んだ.
これと同様に、関手を対象と見做した時にその間の射として自然変換なるものを考える.
そもそも圏論は自然変換なる概念を形式的に定義するために作られたものであるらしい.

自然変換とは、2つの関手

- $F: \mathcal{C} \to \mathcal{D}$
- $G: \mathcal{C} \to \mathcal{D}$

の間に定められ

- $\alpha: F \to G$

と書かれ、"$F$ を $G$ に写す自然変換" という.

そもそも関手 $F, G$ とは、
圏 $\mathcal{C}$ における

```dot
digraph {
    graph [ bgcolor=transparent ];
    node [ width=0.0; shape=plaintext; ];
    edge [ arrowhead=vee ]
    rankdir=LR;
    subgraph cluster {
        A -> B [label=f];
        }
}
```

を圏 $\mathcal{D}$ で


```dot
digraph {
    graph [ bgcolor=transparent ];
    node [ width=0.0; shape=plaintext; ];
    edge [ arrowhead=vee ]
    rankdir=LR;
    subgraph cluster {
        FA -> FB [label=Ff];
        GA -> GB [label=Gf];
    }
}
```

とする.
この $Gf: GA \to GB$ を $Gf: GA \to GB$ に、圏 $\mathcal{D}$ の範囲内で適切に移すのが、
自然変換 $\alpha$ である.
具体的には

```dot
digraph {
    graph [ bgcolor=transparent ];
    node [ width=0.0; shape=plaintext; ];
    edge [ arrowhead=vee ]
    rankdir=LR;
    subgraph cluster {
        FA -> GA [label=αA];
        FB -> GB [label=αB];
        FA -> FB [label=Ff];
        GA -> GB [label=Gf];
        {rank=same; FA GA}
        {rank=same; FB GB}
    }
}
```

を可換にするような射 $\alpha_A, \alpha_B$ を $A, B$ に対して与えるものである.
すなわち、自然変換 $\alpha: F \to G$ とは、
各 $A \in \mathcal{C}$ に対して射 $\alpha_B \in \mathcal{D}(FA, GA)$ を与えるものである.
「添字を対象に取る、射の族」などと言える.

```dot
digraph {
    graph [ bgcolor=transparent ];
    node [ width=0.0; shape=plaintext; ];
    edge [ arrowhead=vee ]
    rankdir=LR;
    C -> F:w [arrowhead=none]; F:e -> D [label=F];
    C -> G:w [arrowhead=none]; G:e -> D [label=G];
    F -> G [label=α color = "black:invis:black"];
    F [label="" fixedsize=false shape=none width=0 height=0];
    G [label="" fixedsize=false shape=none width=0 height=0];
    {rank=same; F G}
}
```

こんな風に図示することもあるけど、graphviz でこんなの再現するのが面倒なので二度と書かない.

### 群の作用の自然変換

先述したように、
群 $G$ は対象が唯一つの圏 $G$ と見做せ、
そして (左) 作用とは圏 $Sets$ への関手だった.
ではそのような関手 $S, T$ の間の自然変換は、群で言うところの何か.

$S, T$ は、圏 $G$ の唯ひとつの対象を、
($Sets$ における対象であるところの) 集合 $S, T$ にそれぞれ写すとする.
そして関手 $S, T$ が表している作用をそれぞれ、
$g \in G$ を
$\rho(g) : S \to S$、
$\pi(g) : T \to T$ という写像に写すものだとする.

とすると自然変換 $S \to T$ の役割は
$g: G \to G$ という射を $S, T$ で写した先をつなげて可換にするもの:

```dot
digraph {
    graph [ bgcolor=transparent ];
    node [ width=0.0; shape=plaintext; ];
    edge [ arrowhead=vee ]
    rankdir=LR;
    subgraph cluster {
        S0 -> S1 [label=ρg];
        T0 -> T1 [label=πg];
        S0 -> T0 [label=αG];
        S1 -> T1 [label=αG];
        S0 [label=S];
        S1 [label=S];
        T0 [label=T];
        T1 [label=T];
        {rank=same; S0 S1};
        {rank=same; T0 T1};
    }
}
```

つまり、射 $\alpha_G$ で繋げる.
最初の例だと、$f: A \to B$ に対して $\alpha_A, \alpha_B$ という2つの射が登場するが、
今の場合は、 $\alpha_G$ という一つの射が二度出現している.
対象が唯ひとつしかないので、自然変換 $\alpha$ とは、ただ唯一の射 $\alpha_G$ のことである.

で、上の図式が可換である.
すなわち

$$\rho(g) \circ \alpha_G = \alpha_G \circ \pi(g)$$

これは要するに準同型写像のこと.
$\rho(g)(s)$ も $\pi(g)(s)$ も細かいこと気にせず $g \cdot s$ と書いて、
$\alpha_G$ を **写像** $\alpha: S \to T$ だと思うと

$$\forall s \in S, g \cdot \alpha(s) = \alpha(g \cdot s)$$

と書き直せる.
というわけで、左作用の間の自然変換とは、準同型写像のことである.

### 関手圏

自然変換は関手を対象と見做したときの、その間の射だと述べた.
ということは、そのような圏を考えても良い.
恒等自然変換は自明なものを採用して、合成も大体自明な方法で定義する.

```dot
digraph {
    graph [ bgcolor=transparent ];
    node [ width=0.0; shape=plaintext; ];
    edge [ arrowhead=vee ]
    rankdir=LR;
    A -> F:w [arrowhead=none]; F:e -> B;
    A -> G:w [arrowhead=none]; G:e -> B;
    A -> H:w [arrowhead=none]; H:e -> B;
    F -> G [label=α color = "black:invis:black"];
    G -> H [label=β color = "black:invis:black"];
    F [label="" fixedsize=false shape=none width=0 height=0];
    G [label="" fixedsize=false shape=none width=0 height=0];
    H [label="" fixedsize=false shape=none width=0 height=0];
    {rank=same; F G H}
}
```

圏 $\mathcal{A}, \mathcal{B}$ に就いて、
$\mathcal{A}$ から $\mathcal{B}$ への関手を対象とし、
関手の間の自然変換を射としたものを、 **関手圏** といい、
$[\mathcal{A}; \mathcal{B}]$ とか
$\mathcal{B}^\mathcal{A}$ などと書く.

#### 例

対象が2つ ($0, 1$ とする) で、射が恒等射しかない (離散である) 圏を $2$ と言う.
適当な圏 $\mathcal{B}$ に対して、
$[2; \mathcal{B}]$ ($\mathcal{B}^2$) がどんなんか考えてみる.

関手 $2 \to \mathcal{B}$ であるが、
射については恒等射しかないので考えなくてよくて、
2つある対象 $0,1$ が $\mathcal{B}$ のどこに写るかだけを気にすれば良い.
すなわち、関手とは、$\mathcal{B}$ の対象から2つ選んで作る2つ組と同一視できる.

そのような関手を関手に写す自然変換は、ただ2つ組を2つ組に移せばいい.

```dot
digraph {
    graph [ bgcolor=transparent ];
    node [ width=0.0; shape=plaintext; ];
    edge [ arrowhead=vee ]
    rankdir=LR;
    subgraph cluster_1 {
        "G(0)" -> "G(1)";
        "F(0)" -> "G(0)";
        "F(1)" -> "G(1)";
        "F(0)" -> "F(1)";
        {rank=same; "F(0)" "G(0)"}
        {rank=same; "F(1)" "G(1)"}
    }
    subgraph cluster_0 { 0 -> 1; }
}
```

つまり、2つの射

- $F(0) \to G(0)$
- $F(1) \to G(1)$

を与えるのがここで言う自然変換である.
註意スべきはこれらの射は $\mathcal{B}$ の射であること.

以上の考察から、
$[2; \mathcal{B}]$ ($\mathcal{B}^2$) は、次のような圏と同型であることが分かる.

- 対象
    - $(B_1, B_2) \in Ob(\mathcal{B}) \times Ob(\mathcal{B})$
- 射
    - $(f_1, f_2) : (B_1, B_2) \to (C_1, C_2)$
    - where
        - $f_1 : B_1 \to C_1 (f_1 \in \mathcal{B}(B_1, C_1))$
        - $f_2 : B_2 \to C_2 (f_2 \in \mathcal{B}(B_2, C_2))$

実はこのような (下の) 圏を直積圏といい、今の場合 $\mathcal{B} \times \mathcal{B}$ を示した.
一般に $\mathcal{A} \times \mathcal{B} \times \cdots \times \mathcal{C}$ が定義できる.
そして離散圏 $n$ から圏 $\mathcal{B}$ への関手圏を考えると、
$\mathcal{B}^n \cong \mathcal{B} \times \cdots \times \mathcal{B}$
であることを示唆している.

### 自然同型

$F, G: \mathcal{A} \to \mathcal{B}$、$\alpha: F \to G$ について、
$\alpha$ が (または "$F$ と $G$ が") **自然同型** であるとは
$[\mathcal{A}; \mathcal{B}]$
において同型射であること.

これは、各 $A \in \mathcal{A}$ について $\alpha_A$ が同型射であること、とも同値.

$$F \cong G$$

などと書く.

## 圏同値

圏 **同型** ($\cong$) は 2 つの圏の間に関手 $F, G$ があって

- $G \circ F = 1$
- $F \circ G = 1$

となることとしていた.

ただしこれは厳しすぎる条件なのであまり使われない.
厳しいと言っているのは関手を $=$ で比較しているところである.
今は自然同型の概念によって、関手同士を同型 $\cong$ で比較できるようになった.
これは $=$ よりは緩い条件である.

### 圏同値の定義

2つの圏 $\mathcal{A}, \mathcal{B}$ が **圏同値** (或いは単に "同値") であるとは、
その2つの間に関手 $F: \mathcal{A} \to \mathcal{B}$ と $G: \mathcal{B} \to \mathcal{A}$ とがあって、

- $G \circ F \cong 1$
- $F \circ G \cong 1$

となること.
$F, G$ は $\mathcal{A}, \mathcal{B}$ に (圏) 同値を与える、などという.
圏同士が同値であることを

$$\mathcal{A} \simeq \mathcal{B}$$

と書く (下線が一本).

### 対象に関して本質的に全射 (essentially surjective on objects)

$F: \mathcal{A} \to \mathcal{B}$ と $G: \mathcal{B} \to \mathcal{A}$ によって
$$\mathcal{A} \simeq \mathcal{B}$$
だと仮定する.

定義より $G \circ F \cong 1$ かつ $F \circ G \cong 1$ である.
これは即ち同型な自然変換

- $\eta: 1 \to G \circ F$
- $\epsilon: F \circ G \to 1$

があることを言っている.

$\epsilon: F \circ G \to 1$
が同型であることは、各対象 $B$ について
$FG(B) \cong 1(B) = B$ であることと同値であった.
$B$ に対して $A=F(B) \in \mathcal{A}$ とすれば $F(A) \cong B$ となる.

すなわち、次のことが言える.

> 関手 $F: \mathcal{A} \to \mathcal{B}$ について、
> 任意の $B \in \mathcal{B}$ について
> ある $A \in \mathcal{A}$ があって
> $F(A) \cong B$
> となる.

このような性質を、
"関手 $F$ は **対象に関して本質的に全射** である" という.

同値を与える関手はいつも、対象に関して本質的に全射である.

### 関手の忠実 (faithful)、充満 (full)

関手の、射に関する写像についてのみ注目した時に、
それがいつも単射であることを **忠実** であるという.
またそれがいつも全射であることを **充満** であるという.

先ほどの例の続きを考える.

```dot
digraph {
    node [ width=0.0; shape=plaintext; ];
    edge [ arrowhead=vee ]
    rankdir=LR;
    bgcolor=transparent;
    compound=true;

    subgraph cluster_0 {
        A1 -> A2 [label=f]
    }
    subgraph cluster_1 {
        FA1 -> FA2 [label=Ff]
    }
    subgraph cluster_2 {
        GFA1 -> GFA2 [label=GFf];
        _A1 -> _A2 [label=f];
        _A1 -> GFA1 [label=η];
        _A2 -> GFA2 [label=η];
        _A1 [label=A1]
        _A2 [label=A2]
        { rank=same _A1 GFA1 }
        { rank=same _A2 GFA2 }
    }

    A2 -> FA1 [label=F ltail=cluster_0 lhead=cluster_1];
    FA2 -> GFA1 [label=G ltail=cluster_1 lhead=cluster_2];
    A2 -> _A1 [label=1 ltail=cluster_0 lhead=cluster_2 weight=0];
}
```

これは $f: A_1 \to A_2$ を2つの関手 $G \circ F$ と $1$ とで写した先を、
$\eta_{A_1}$ と $\eta_{A_2}$ とで繋げた図を見ている.
枠で囲んだ一つ一つが一つの圏であって、その中で可換であることを言っている.

すなわち、
$$f = \eta_{A_2}^{-1} \circ GFf \circ \eta_{A_1}$$

であることが分かる.
同値なので、自然変換が与える $\eta_A$ には逆射が必ずある.

> これが同型なら $f = GFf$ と、厳密にイコールになるが、
> 同値は、前後に適当な射を置けばイコールにできる、と言っている.

さて、以上のことは、同値を与える関手 $F$ は忠実であることを示している.
なぜなら、
$\mathcal{A}$ において2つの射
$f_1, f_2: A_1 \to A_2$ について

- $f_1 = \eta_{A_2}^{-1} \circ GFf_1 \circ \eta_{A_1}$
- $f_2 = \eta_{A_2}^{-1} \circ GFf_2 \circ \eta_{A_1}$

が成立して、
$F(f_1) = F(f_2)$ ならば、右辺が一致するので $f_1 = f_2$ となる.
これは単射性を言っているので、$F$ は忠実である.
全く同様に $G$ も忠実である.

次は逆に、
$F(A_1) \to F(A_2)$ な任意の射 $g$ に対して
$$f = \eta_{A_2}^{-1} \circ Gg \circ \eta_{A_1}$$
とする.

```dot
digraph {
    node [ width=0.0; shape=plaintext; ];
    edge [ arrowhead=vee ]
    rankdir=LR;
    bgcolor=transparent;
    compound=true;

    subgraph cluster_1 {
        FA1 -> FA2 [label=g]
    }
    subgraph cluster_2 {
        GFA1 -> GFA2 [label=Gg];
        A1 -> A2 [label=f];
        A1 -> GFA1 [label=η];
        A2 -> GFA2 [label=η];
        { rank=same A1 GFA1 }
        { rank=same A2 GFA2 }
    }

    FA2 -> GFA1 [label=G ltail=cluster_1 lhead=cluster_2];
}
```

$f$ の定義域・値域は注意深い観察によって $f: A_1 \to A_2$ であることが分かる.
これを更に、2つの関手 $1, G \circ F$ で写したものを、上の図式に重ねると次のようになる.

```dot
digraph {
    node [ width=0.0; shape=plaintext; ];
    edge [ arrowhead=vee ]
    rankdir=LR;
    bgcolor=transparent;
    compound=true;

    subgraph cluster_1 {
        FA1 -> FA2 [label=g]
    }
    subgraph cluster_2 {
        GFA1 -> GFA2 [label=Gg];
        A1 -> A2 [label=f];
        A1 -> GFA1 [label=η weight=1];
        A2 -> GFA2 [label=η weight=1];
        _GFA1 -> A1 [label=η dir=back];
        _GFA2 -> A2 [label=η dir=back];
        _GFA1 -> _GFA2 [label=GFf];
        _GFA1 [label=GFA1]
        _GFA2 [label=GFA2]
        { rank=same A1 GFA1 _GFA1 }
        { rank=same A2 GFA2 _GFA2 }
    }

    FA2 -> GFA1 [label=G ltail=cluster_1 lhead=cluster_2];
}
```

これが可換なので

$$GFf = \eta \circ f \circ \eta^{-1} = Gg$$

を得る.
ここで $G$ の忠実性を使うことで、

$$Ff = g$$

を得る.

以上で分かったこととして、任意の射 $g$ に対して $Ff = g$ となる $f$ が存在する.
これは $F$ の全射性を言っている.
すなわち、 $F$ は充満である.


### 定理

$F, G$ が (圏) 同値を与えることと、
「対象に関して本質的に全射で、忠実で、充満」は同値.


% 層化 (sheafification)
% 2018-04-22 (Sun.)
% 層

位相空間 $X$ の上の前層について考える.
前層があるとき、以下のステップを踏むことでまず中間層に誘導し、さらにそれを層に誘導できる.
この手続きを層化という.

## INDEX

<div id=toc></div>

## 前層・層の定義

[前記事](sheaf.html) に書いた.

## 諸定義

層 $A$ の2元 $f,g$ について
$$[f=g] := \bigcup \{ U : f \rceil U = g \rceil U \}$$
と定める.
$U$ についての和を取っていることに註意.
特に $[f=f] = X$ (全体) である.

2元 $f,g$ が互いのドメインで制限したときに等しいことを「両立している」と表現する.
すなわち
$$f \rceil Eg = g \rceil Ef$$
のことである.

## 中間層の定義

前層 $A$ について
$$\forall f,g \in A, Ef \cap Eg \subseteq [f=g] \implies f\rceil Eg=g\rceil Ef$$
が成立するものを中間層と言う.
(逆は一般の前層で成立する.)

## 前層から中間層への誘導

前層 $A$ に次の同値関係を入れる.
$$f \equiv g \iff Ef=Eg \subseteq [f=g]$$
これで割って
$$\begin{align*}
\hat{A} = A/\!\!\equiv \\
\varphi : A \to \hat{A} \\
E \varphi(f) = Ef \\
\varphi(f) \rceil U = \varphi( f \rceil U)
\end{align*}$$
とする.
この $\hat{A}$ が中間層になっている.

## 誘導されたそれが中間層であることの確認

前層であることまでは自明だとして、中間層としての条件が満たされてることだけ確認する.

すなわち、任意の2元 $f,g \in A$ に対する $\varphi(f), \varphi(g) \in \hat{A}$ について
$$E\varphi(f) \cap E\varphi(g) \subseteq [\varphi(f)=\varphi(g)] \implies \varphi(f)\rceil E\varphi(g)=\varphi(g)\rceil E\varphi(f)$$
であることを確認する.

この式は $E\varphi$ と $\varphi \rceil$ の定義から
$$Ef \cap Eg \subseteq [\varphi(f)=\varphi(g)] \implies \varphi(f\rceil Eg)=\varphi(g\rceil Ef)$$
と書き直せる.

さらに $\implies$ から見て右辺は $\varphi$ のイコールなので同値関係のことを言っている.
$$\begin{align*}
     & \varphi(f\rceil Eg)=\varphi(g\rceil Ef) \\
\iff & f\rceil Eg \equiv g\rceil Ef \\
\iff & E(f\rceil Eg) = E(g\rceil Ef) \land E(g \rceil Ef) \subseteq [f \rceil Eg=g \rceil Ef] \\
\iff & Ef \cap Eg \subseteq [f \rceil Eg=g \rceil Ef] \\
\end{align*}$$
と書き直せる.

改めて示したい式を書き直すと
<div class=thm>
$$
Ef \cap Eg \subseteq [\varphi(f)=\varphi(g)]
\implies
Ef \cap Eg \subseteq [f \rceil Eg=g \rceil Ef]
$$
</div>
となる.

背理法で示す.
右辺が $\not\subseteq$ だとすると、
$$\exists x \in Ef \cap Eg, x \not\in [f \rceil Eg=g \rceil Ef]$$
という点 $x \in X$ があるはずである.
$[- = -]$ の定義まで戻れば、そのような点 $x$ に対して

$$\forall U (x \in U), f \rceil Eg \rceil U \ne g \rceil Ef \rceil U$$
である.
さらに $U \subseteq Ef \cap Eg$ となるように小さいものに限ると右辺がすっきりして
$$\forall U (x \in U \subseteq Ef \cap Eg), f\rceil U \ne g\rceil U$$
と言える.

さて $\implies$ より左辺について.
今の点 $x$ がやはり
$[\varphi(f) = \varphi(g)]$
に含まれないために $\not\subseteq$ であることを示す.

とりあえず $[-=-]$ を展開してく.
$$\begin{align*}
[\varphi(f) = \varphi(g)]
& = \bigcup \{ U : \varphi(f) \rceil U = \varphi(g) \rceil U \} \\
& = \bigcup \{ U : f \rceil U \equiv g \rceil U \} \\
& = \bigcup \{ U : Ef \cap U=Eg \cap U \land Ef \cap U \subseteq [f\rceil U=g\rceil U] \}
\end{align*}$$

ある $U$ で $x \in U$ かつ $Ef\cap U=Eg\cap U$ だとする.
このとき、いつも
$$Ef \cap U \not\subset [ f \rceil U = g \rceil U ]$$
である.
なぜなら
$$Ef \cap U \subset [ f \rceil U = g \rceil U ]$$
であるとすると (背理法)、
$x \in Ef \cap U$
なので
$$\begin{align*}
x & \in [ f \rceil U = g \rceil U ] \\
  & =   \bigcup \{ V : f \rceil U \rceil V = g \rceil U \rceil V \} \\
  \iff & \exists V, x \in V \land f \rceil U \rceil V = g \rceil U \rceil V \\
  \iff & \exists V, x \in V \land f \rceil (U \cap V) = g \rceil (U \cap V)
\end{align*}$$
最後の $(U \cap V)$ に対してさらに
$(U \cap V) \cap (Ef \cap Eg)$
を $W$ とすれば
$x \in W \subseteq Ef \cap Eg$ に対して
$f \rceil W = g \rceil W$
となってしまう.

したがって、 $[\varphi(f) = \varphi(g)]$ は点 $x$ が含まない.
というわけで
$$
Ef \cap Eg \not\subseteq [\varphi(f)=\varphi(g)]
$$
である.

以上から対偶が示されたので順も示された.

というわけで、 $\hat{A}$ は中間層である.
(背理法の中で更に背理法を使ってしまった.)

## 中間層から層への誘導

中間層 $A$ があるとき、
$$\mathcal{F} = \{ F \subseteq A | F \text{の2元は両立} \}$$
を定める.
この上に関数 $E, \rceil$ を次のように定める.

- $EF = \bigcup_{f \in F} Ef$
- $F \rceil U = \{ f \rceil U | f \in F\}$

$\mathcal F$ が層であるかなどは見ないが
$E(F \rceil U) = EF \cap U$
などは成り立つ.

$\mathcal F$ 上に同値関係を次のように定める.

$F_1, F_2 \in \mathcal F$ について
$$F_1 \equiv F_2
\iff
EF_1 = EF_2
\land
F_1 \cup F_2 \in \mathcal F$$

$\mathcal F$ の定義ゆえ、
$F_1 \cup F_2 \in \mathcal F$
とは、$F_1$ の任意の元と $F_2$ の任意の元とが両立することであることに註意.

また中間層故、この $\equiv$ は確かに同値関係になる.

以上から
$\def\FS{\mathcal F\!/\!\!\equiv}\FS$
が定まる.
$\varphi$ を商を取る関数
$$\varphi : \mathcal F \to \FS$$
とする.

$\FS$ 上の $E, \rceil$ は $\varphi$ によって自然に導かれる.
すなわち、

- $E(\varphi F) = \bigcup_{f \in F} Ef$
- $(\varphi F) \rceil U = \varphi (F \rceil U)$

このとき
$\langle \FS, E, \rceil \rangle$
は層となる.

## 誘導されたそれが層であることの確認

中間層 $A$ から誘導して得た
$\langle \FS, E, \rceil \rangle$
が層であることを確認する.

まず前層であることを簡単に見ていって、加えて、層であることを確認する

### notations

主に $\varphi$ を省略したいので、紛らわしくない限り次の略記法を用いる.

$F \in \mathcal F$ について
$$E(\varphi F) = EF = \bigcup_f Ef$$
であるので、
$E(\varphi F)$ を単に $EF$ と書く.

$\varphi$ の切断を $\psi$ とする.
ここで切断とは
$$\forall F \in \FS,~ \varphi (\psi F) = F$$
となるような $\psi : \FS \to \mathcal F$ のこと.
つまり、代表元を1つ取ってくるような関数のこと.

### 前層であることの確認

前層の公理を満たすことを実際に確かめる

1. $\forall F \in \mathcal F, (\varphi F) \rceil \emptyset = \{ \ast \}$
    - ただしここで $f \in A, f \rceil \emptyset = \ast$ とした
1. $(\varphi F) \rceil EF = \varphi \{ f \rceil EF | f \in F \} = \varphi \{ f | f \in F \} = \varphi F$
1. $E(F \rceil U) = \bigcup_f E(f \rceil U) = \bigcup_f (Ef \cap U) = \bigcup_f Ef \cap U = EF \cap U$
1. $(F \rceil U) \rceil V = \{f \rceil U | f \in F\}=\{f \rceil U \cap V | f \in F\}=F \rceil (U \cap V)$

以上から前層であることが確かめられた.

### 層であることの確認

前層であることは確かめたので、次を確かめればよい.

> 任意の $\mathcal G \subseteq \mathcal F$ について、
> $\mathcal G/\!\equiv$ の任意の2元が両立するならば、
> 唯一の和 $\bigcup \mathcal G$ が存在する.

まず、和として満たすべき性質を満たす集合が作れること (存在性) を示す.
次に、その存在が唯一なものであること (唯一性) を示す.

#### 1. 存在性

$$\bar{G} = \varphi \left( \bigcup_{G \in \mathcal G} G \right)$$
これが和としての性質を満たすことを確かめる.
和としての性質とは次の2つである.

1. $E\bar{G} = \bigcup_{G \in \mathcal G/\!\equiv} EG$
1. $G \in \mathcal G/\!\equiv \implies \bar{G} \rceil EG = G$

確認する.
1つ目は $\bar{G}$ の作り方から明らか.

2つ目.
$\varphi G_0 \in \mathcal G/\!\equiv$ について、
$$\begin{align*}
\bar{G} \rceil EG_0
& = \varphi \left( \bigcup_{G \in \mathcal G} G \right) \rceil EG_0 \\
& = \varphi \left(
    \{ g \rceil EG_0 | G \in \mathcal G, g \in G \}
\right) ~~~\text{ ... } E \text{ の定義より} \\
& = \varphi \left(
    \bigcup_{G \in \mathcal G} (G \rceil EG_0)
\right) ~~~\text{ ... } G \text{ ごとにまとめた} \\
& = \varphi \left(
    \bigcup_{G \in \mathcal G} (G_0 \rceil EG)
\right) ~~~\text{ ... } \varphi G \text{ と } \varphi G_0 \text{ は両立してるので (ただしそんなに自明ではない)} \\
& = \varphi \left(
    G_0 \cup \bigcup_{G \ne G_0} (G_0 \rceil EG)
\right) ~~~\text{ ... 後の説明の便宜上 } G=G_0 \text{ の場合とそれ以外とに分けた} \\
& = \varphi G_1 \text{ とおく}
\end{align*}$$

示したいのは $\varphi G_0 = \varphi G_1$ であること.
すなわち $G_0 \equiv G_1$ であること.
$\equiv$ であることを示すには次の2つを見れば良いのだった.

i. $EG_0 = EG_1$
i. $G_0 \cup G_1 \in \mathcal F$

##### i.

$$\begin{align*}
EG_1
& = E\left( G_0 \cup \bigcup_{G \ne G_0} (G_0 \rceil EG) \right) \\
& = EG_0 \cup \bigcup_{G \ne G_0} E(G_0 \rceil EG) \\
& = EG_0 \cup \bigcup_{G \ne G_0} (EG_0 \cap EG) \\
& = EG_0
    ~~~\text{... } EG_0 \supseteq (EG_0 \cap EG) \text{ より}
\end{align*}$$

##### ii.

$$\begin{align*}
G_0 \cup G_1
& = G_0 \cup \left( G_0 \cup \bigcup_{G \ne G_0} (G_0 \rceil EG) \right) \\
& = \left( G_0 \cup \bigcup_{G \ne G_0} (G_0 \rceil EG) \right) \\
& = G_1
\end{align*}$$

というわけで $G_0 \cup G_1 = G_1$ なので $G_1 \in \mathcal F$ であることを確かめればよい.
$$\varphi G_1 = \varphi \left(
    \bigcup_{G \in \mathcal G} \psi(G_0 \rceil EG)
\right)$$
であったことを思い出すと、
2元 $f, g \in G_1$ は

- $\exists F \in \mathcal{G}, f \in (G_0 \rceil EF)$
- $\exists G \in \mathcal{G}, g \in (G_0 \rceil EG)$

と書ける.
$(G_0 \rceil EF)$ などは単なる集合なので更に次のように書き換えられる.

- $\exists F \in \mathcal{G}, \exists f' \in G_0,~ f = f' \rceil EF$
- $\exists G \in \mathcal{G}, \exists g' \in G_0,~ g = g' \rceil EG$

このときに $f, g$ が両立していることを見たい.
ここで $f', g'$ は $G_0$ の元であって $G_0$ は $\mathcal F$ の元である.
$\mathcal F$ の作り方を思い出すと、 $f', g'$ は両立しているのだった.
これを利用する.

$$\begin{align*}
f \rceil Eg
& = (f' \rceil EF) \rceil Eg \\
& = (f' \rceil EF) \rceil Eg' \rceil EG \\
& = (g' \rceil Ef') \rceil EF \rceil EG ~~~\text{... 両立性より} \\
& = g \rceil Ef' \rceil EF ~~~\text{... 戻していく} \\
& = g \rceil Ef
\end{align*}$$

というわけで $f, g$ は両立している.
というわけで $G_0 \cup G_1 = G_1$ の任意の2元はつねに両立している.
なので $G_0 \cup G_1 \in \mathcal F$ である.

以上 i. ii. より、$\varphi G_0 = \varphi G_1$ である.

以上より $\bar{G}$ は和としての性質を満たしている.

#### 2. 唯一性

他に和としての性質を満たす $\varphi H \in \FS$ があるとする.
このとき
$$\varphi H = \bar{G}$$
であることを示すことで、和が唯一であって
$$\bigcup \mathcal G = \FS$$
であることが証明できたことになる.

やっていく.

##### i.

どちらも和としての性質を満たすことを仮定しているので
$$EH = \bigcup EG = E \bar{G}$$

##### ii.

$H \cup \psi \bar{G} = H \cup \bigcup_{G \in \mathcal G} G$
の任意の2元が両立することを見る.

###### 1.
$g_1, g_2 \in \bigcup_{G \in \mathcal G} G$ が両立することは、
$\bar{G}$ が和の性質を満たすことを示すときに、さっき示した.

###### 2.
$h_1, h_2 \in H$ が両立すること.
これは $H \in \mathcal F$ であることから自明.

###### 3.
というわけで本題は、

> $g \in \bigcup_{G \in \mathcal G} G$ と $h \in H$ とが両立すること.

$g$ についてはある $G \in \mathcal G$ があって
$g \in G \in \mathcal G$
である.

$H$ は $\mathcal G$ の和なので、そのような $G$ を用いて、
$$H \rceil EG = G$$
となる.
左辺は
$$\{ h' \rceil EG | h' \in H \}$$
なので、$h$ について
$h \rceil EG$
という値は、$H \rceil EG$ に属する.
従って $G$ にも属する.
というわけで、
$$\exists g' \in G,~ h \rceil EG = g'$$

まずこの式の両辺の $E$ の値を取ることで
$$Eh \cap EG = Eg'$$
を得る.

また両辺に $\rceil Eg$ を掛けることで
$$\begin{align*}
h \rceil Eg
& = h \rceil EG \rceil Eg ~~~\text{... } Eg \subset EG \text{ なので} \\
& = g' \rceil Eg \\
& = g \rceil Eg' ~~~\text{... } G \text{ の2元は両立してる} \\
& = g \rceil (Eh \cap EG) ~~~\text{... すぐ上で求めた値を代入した} \\
& = (g \rceil EG) \rceil Eh
& = g \rceil Eh
\end{align*}$$
というわけで $h \rceil Eg = g \rceil Eh$ が得られ、 $g, h$ も無事両立している.

というわけで $H \cap \psi \bar{G}$ の2元はいつも両立している.

というわけで
$$\varphi H = \bar{G}$$
が得られた!!

以上.

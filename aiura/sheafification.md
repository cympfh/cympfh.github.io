% 層化 (sheafification)
% 2018-04-22 (Sun.)
% 層

位相空間 $X$ の上の前層について考える.
前層があるとき、以下のステップを踏むことで層に誘導できる.
この手続きを層化という.

## Def. 前層

[前記事](sheaf.html) の一番最初に書いた.

## 諸定義

層 $A$ の2元 $f,g$ について
$$[f=g] \equiv \bigcup \{ U : f \rceil U = g \rceil U \}$$
と定める.
$U$ についての和を取っていることに註意.
特に $[f=f] = X$ (全体) である.

2元 $f,g$ が互いのドメインで制限したときに等しいことを「両立している」と表現する.
すなわち $$f \rceil Eg = g \rceil Ef$$ のことである.

## Def. 中間層

前層 $A$ について
$$\forall f,g \in A, Ef \cap Eg \subseteq [f=g] \implies f\rceil Eg=g\rceil Ef$$
が成立するものを中間層と言う.
(逆は一般の前層で成立する.)

## 前層から中間層

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

### 確認
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

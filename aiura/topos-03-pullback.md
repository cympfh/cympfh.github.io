% トポスはイコライザーとプルバックを持つ
% 2019-11-01 (Fri.)
% トポス 圏論

$\require{AMScd}$
$$\def\true{\mathrm{true}}$$

## 概要

[トポス](topos-01.html) はいつもイコライザーを持ち, プルバックを持つ.


## トポスはイコライザーを持つ

任意の

```dot
digraph {
    graph [bgcolor=transparent];
    node [shape=plaintext];
    edge [arrowhead=vee];
    rankdir=LR;
    A:e -> B [label=f];
    A:e -> B [label=g];
    A [shape=plaintext];
    B [shape=plaintext];
}
```

について必ずイコライザー $e$ がある.

```dot
digraph {
    graph [bgcolor=transparent];
    node [shape=plaintext];
    edge [arrowhead=vee];
    rankdir=LR;
    E -> A [label=e];
    A:e -> B [label=f];
    A:e -> B [label=g];
    A [shape=plaintext];
    B [shape=plaintext];
}
```

### 復習と直感的な説明

[前回](topos-01.html), トポスにはイコール射があることを言った.
直感的にはこれは射を関数と見た時のその値のイコールを表現している.
Set 圏を考えるとイコライザーというのは詰まるところ関数の値が等しい部分を取った部分集合とそこからの包含写像のことである.

- $E = \{ a \in A \mid fa = ga \}$
- $e(a) = a$

従って今回で言えば $fa=ga \iff (=)_B(fa, ga) = \true \iff (=)_B \circ \langle f, g \rangle (a) = \true$ が成立する部分を見ればいい.
true になる部分を取るには, subobject classifier を使う.

### 証明

$f,g \colon A \to B$
について積を考えると
$\langle f,g \rangle \colon A \to B \times B$
がある（トポスは積を必ず持つので）.

また前回定義した $(=)_B = cl(\Delta_B)$ を合成すると
$(=)_B \langle f,g \rangle \colon A \to \Omega$
が出来る.

これの subobject を取ったものを $e \colon E \to A$ と定める.
$$\begin{CD}
E @>!>> 1 @>!>> 1 \\
@VeVV @. @VtVV \\
A @>\langle f,g \rangle>> B \times B @>(=)_B>> \Omega
\end{CD}$$
これがプルバック.

この $e$ が $f,g$ のイコライザーであることを今から言う.

先の四角形を変形してやると

$$\begin{CD}
E @>!>> 1 \\
@V\langle f,g \rangle ~ e VV @VtVV \\
B \times B @>(=)_B>> \Omega
\end{CD}$$

という可換図式が得られる.

一方で $(=)$ の定義を思い出すと

$$\begin{CD}
B @>!>> 1 \\
@V\Delta_B VV @VtVV \\
B \times B @>(=)_B>> \Omega
\end{CD}$$

という可換図式はプルバックである.
従って, 普遍射 $h \colon E \to B$ があって,

$$\begin{CD}
E @>h>> B \\
@V\langle f,g \rangle ~ e VV @V\Delta_B VV \\
B \times B @= B \times B
\end{CD}$$

が成り立っている.
これを見ると $\langle fe, ge \rangle = \langle h,h \rangle$
すなわち $fe = ge$ が言えている.

あとは普遍性だが, これは今の逆をそのまま辿っていけば言える.

適当な $k \colon X \to A$ で $fk=gk$ であるとする.
このことから下図の左の四角形が言える.
それに右の四角形は元々成り立っている.

$$\begin{CD}
X @>fk>> B @>!>> 1 \\
@V\langle f,g \rangle ~ k VV @V\Delta_B VV @VtVV \\
B \times B @= B \times B @>(=)_B>> \Omega
\end{CD}$$

というわけでこの全体の四角形が可換である.
この四角形を変形する.

$$\begin{CD}
X @>!>> 1 \\
@VkVV @VtVV \\
A @>(=)_B \langle f,g \rangle >> \Omega
\end{CD}$$

一番最初の

$$\begin{CD}
E @>!>> 1 \\
@VeVV @VtVV \\
A @>(=)_B \langle f,g \rangle >> \Omega
\end{CD}$$

がプルバックであることから, 普遍射 $X \to E$ がある.
これがイコライザーとしての普遍射になっている.

以上で $e$ がイコライザーであることが確認できた.

## トポスはプルバックを持つ

任意の

$$\begin{CD}
. @. A \\
@. @VfVV \\
B @>g>> C
\end{CD}$$

に対して必ずある $p_1, p_2$ があって以下がプルバック.

$$\begin{CD}
P @>p_1>> A \\
@Vp_2VV @VfVV \\
B @>g>> C
\end{CD}$$

### 補足

トポスに限らず, 積とイコライザーを持つ圏ならプルバックは常に存在する.

### 証明

積があるので

- $f \pi_1 \colon A \times B \to C$
- $g \pi_2 \colon A \times B \to C$

がある.
これのイコライザーを $e \colon E \to A \times B$ とすると,

$$\begin{CD}
E           @>\pi_1 e>> A \\
@V\pi_2 eVV @VfVV \\
B @>g>> C
\end{CD}$$

がプルバック.

イコライザーであるから可換性は明らか.
普遍性を確認する.

他の $X \colon A, X \colon B$ があって

$$\begin{CD}
X           @>>> A \\
@VVV @VfVV \\
B @>g>> C
\end{CD}$$

だとする.
すると $A \times B$ の普遍性より
$! \colon X \to A \times B$ である.
もちろん

$$\begin{CD}
X           @>\pi_1!>> A \\
@V\pi_2!VV @VfVV \\
B @>g>> C
\end{CD}$$

つまり $(f\pi_1)! = (g\pi_2)!$ である.

すると今度は $E$ がイコライザーであることの普遍性から
$!! \colon X \to E$
であってこれがプルバックとしての普遍射である.

以上から $E$ がプルバックであることが分かった.

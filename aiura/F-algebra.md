% F-代数
% 2018-11-20 (Tue.), 2022-07-24 (Sun.)
% 圏論

$\def\N{\mathbb N}\def\C{\mathcal C}$
$\def\succ{\mathrm{succ}}$
$\def\banana#1{(\!|#1|\!)}$
$\def\Sets{\mathrm{\mathcal{S}ets}}$

## INDEX

<div id=toc></div>

## 参考

- [wikipedia/始代数](https://ja.wikipedia.org/wiki/%E5%A7%8B%E4%BB%A3%E6%95%B0)
- [圏論勉強会 第七回@ワークスアプリケーションズ](http://nineties.github.io/category-seminar/7.html#/43)
    - [YouTube](https://www.youtube.com/watch?v=j3bY_djVjiQ) にこの資料で講義してる動画があって, これが丁寧なので良い
- [Functional Programming with Bananas, Lenses, Envelopes and Barbed Wire](https://maartenfokkinga.github.io/utwente/mmf91m.pdf)
    - 上の動画で紹介されてた論文
    - ここでも "Algebraic data types" として紹介されてるし, catamorphism という概念が始代数に相当する

## F-代数

圏 $\mathcal C$ における $F$-代数とは, 関手 $F : \mathcal C \to \mathcal C$ を以って, ある対象 $X$ と射 $f : FX \to X$ の組
$$(X, f)$$
のことをいう.
ここで $X$ をこの $F$-代数の台という.
紛らわしくなければ単に $X$ を $F$-代数と呼ぶ.

## F-代数の圏

圏 $\mathcal C$ の上の $F$-代数全体を対象とする圏を考える.
2つの $F$-代数 $(X,f)$ と $(Y,g)$ があるときに,
$\mathcal C$ の射 $h : X \to Y$ が $\mathcal C$ にあって下が可換になるとき,

$$\require{amscd}$$
$$\begin{CD}
X @<f<< FX \\
@VhVV  @VFhVV \\
Y @<g<< FY
\end{CD}$$

このときに
$$h : (X,f) \to (Y,g)$$
と書いて, これを $F$-代数の射とする.

## F-始代数

$F$-代数の圏の始対象を, $F$-始代数と言う.

### 例: 自然数

集合の圏 Sets の関手
$$F : \Sets \to \Sets$$
$$X \mapsto 1+X$$
を考える.
ここで $1$ は単集合 $\{ \ast \}$ で, $+$ は集合の直和とする.

$F$-始代数は自然数 $\N$ と写像
$$\nu : 1+\N \to \N$$
$$\begin{align*}
\nu ~ \ast & = 0 & \text{ when } \ast \in 1 \\
\nu ~ m & = m + 1 & \text{ when } m \in \N
\end{align*}$$
の組 $(\N, \nu)$ になる.
ここで $\nu$ は全単射になっている.

確かにこれが始対象であることを確認する.
すなわち,
自由にとってきた $F$-代数 $(X, f)$ に対して, 唯一の射 $(\N, \nu) \to (X,f)$ があることを見れば良い.

ちなみに, そのような射のことを $f$ に対して $\banana{f}$ と書く.
(この括弧は "バナナ括弧" として
["Functional Programming with Bananas, Lenses, Envelopes and Barbed Wire"](../paper/bananas-lenses-envelopes-barbedwire.html)
で導入されているものに倣った.)

$\banana{f}$ は満たすべき可換性から具体的に構成できるので存在することは分かる.

$$\begin{CD}
\N @<\nu<< 1+\N \\
@V\banana{f}VV  @VF\banana{f}VV \\
X @<f<< 1+X
\end{CD}$$

可換性から
$$\begin{align*}
\banana{f} ~ 0
& = \banana{f} \nu \ast \\
& = f (F \banana{f}) \ast \\
& = f(1+\banana{f}) \ast \\
& = f 1 \ast \\
& = f \ast \\
\banana{f} ~ (m+1)
& = \banana{f} \nu m \\
& = f (F \banana{f}) ~ m \\
& = f (1+\banana{f}) ~ m \\
& = f \banana{f} ~ m
\end{align*}$$
これが $\banana{f}$ の定義になっている.
つまり任意の $n \in \N$ は $0$ または $m+1$ の形になっているので右辺で与えられる.
ただし
$\banana{f}(m+1)$ の値を得るには
$\banana{f}(m)$ の値を分かっている必要があるが,
これはつまり自然数に関する (数学的) 帰納法から正しく定義出来ていることがわかる.

また結局これを満たさないといけないことから $\banana{f}$ の存在も唯一.

### 例: リスト

Sets (または Hask 圏) における対象 $A$ と $X$ に対して $1+AX$ を考える.
ここで $AX$ とは $A$ と $X$ との直積のこと,
$1+AX$ とは単集合 $1 = \{\ast\}$ と $AX$ との直和のこと.

$$F : X \mapsto 1+AX$$

とする, $F$-始代数はリストと呼ばれる構造
$$([A], \nu)$$
になる.

ここで
$$[A] = 1 + A + A^2 + A^3 + \cdots$$
$$\nu : 1+A[A] \to [A]$$
$$\begin{align}
\nu~\ast & = \ast \\
\nu~(a, \ast) & = a \\
\nu~(a, a') & = (a, a')
\end{align}$$

ここで一番下の式は
$(a, a') \in A \times A^m$
に対して
$(a, a') \in A^{m+1}$
を割り当てていることに註意.
そしてやはりこの $\nu$ は全単射である.

自然数の場合と全く同様に,
任意の $F$-代数 $(X, f)$ に対して, 唯一の射
$$\banana{f} : ([A], \nu) \to (X,f)$$
が存在して,

$$\begin{CD}
[A] @<\nu<< 1+A[A] \\
@V\banana{f}VV  @VF\banana{f}VV \\
X @<f<< 1+AX
\end{CD}$$

となることが分かる.

念の為に書くと,
$$\begin{align*}
\banana{f} ~ \ast
& = \banana{f} \nu \ast \\
& = f ~ (1+A\banana{f}) ~ \ast \\
& = f \ast \\
\banana{f} ~ a
& = \banana{f} \nu (a, \ast) \\
& = f ~ (1+A\banana{f}) ~ (a, \ast) \\
& = f ~ (a, \banana{f}~\ast) \\
& = f ~ (a, f~\ast) \\
\banana{f} ~ (a, a')
& = \banana{f} \nu (a, a') \\
& = f ~ (1+A\banana{f}) ~ (a, a') \\
& = f ~ (a, \banana{f} ~ a') \\
\end{align*}$$

これによって $\banana{f}$ が構成されて唯一.
例えば $(a,b,c) \in A^3$ について,
$$\begin{align*}
\banana{f} ~ (a,b,c)
& = f(a, \banana{f} ~ (b,c)) \\
& = f(a, f(b, \banana{f} ~ c)) \\
& = f(a, f(b, f(c, \banana{f} ~ \ast))) \\
\end{align*}$$
敢えて $f(a,b) = a \oplus b$ と書くことにすれば,
$$\banana{f}(a,b,c) = a \oplus (b \oplus (c \oplus \ast))$$
と書ける.

## Lambek の補題

今まで見てきた $F$-始代数はすべて全単射であったがこれは実は定理として成り立つ.

$(X, f)$ が $F$-始代数であるとき, $f$ は同型
$$FX \simeq X$$
を与える.

始代数であることから唯一射 $i$ で以て
$$i \colon (X,f) \to (FX,Ff)$$
があり, また $f$ が射
$$f \colon (FX,Ff) \to (X,f)$$
になっている.
このことを一つの可換図式に書くと次のようになる.

$$\begin{CD}
X      @<f<<   FX \\
@ViVV          @VFiVV \\
FX     @<Ff<<  F^2X \\
@VfVV          @VFfVV \\
X      @<f<<   FX \\
\end{CD}$$

このことは $i$ が $f$ の逆射になっていることを言っており,
$f$ が $FX \simeq X$ であることが示された.

% モノイダル圏, モノイド対象
% 2020-08-26 (Wed.)
% 圏論

$\require{AMScd}$

## index

<div id=toc></div>

## モノイダル圏

圏 $C$ について, 次のような双関手 $\otimes$ 及び対象 $I$ があるとする:

1. $\forall (X, Y) \in C \times C,~ X \otimes Y \in C$
1. $\exists I \in C,~ \forall X \in C,~ I \otimes X \simeq X \otimes I \simeq X$

このときこの $(\otimes, I)$ を以てして, $C$ はモノイダル圏であるという.

### 例. Set と直積

圏 Set において $X \otimes Y = X \times Y$, $I = \{\ast\} ~(=1)$ とすればこれはモノイダル圏.

### 例. 自己関手圏と合成

圏 $C$ があるときに $C$ から $C$ への関手だけを集めたものは圏になる.
これを関手圏 $C^C$ という.
この圏における射は自然合成.

$F,G \in C^C$ は $C$ から $C$ への関手なので自由に合成できて,
$$F \otimes G := FG$$
と定めればこれはモノイダル圏.
ここで恒等関手 $1_C$ が $I$ として働く.
$$F \otimes 1 = F = 1 \otimes F$$

## モノイド対象

モノイダル圏 $C$ があるときに, 次のような $(M, \mu, \eta)$ があるとする:

- 対象 $M \in C$
- 射 $\mu \colon M \otimes M \to M$
    - "乗算" と呼ぶ
- 射 $\eta \colon I \to M$
    - "単位" と呼ぶ

次の二つが成り立つことを要請する:

1. 結合則

$$\begin{CD}
M^3 @>1 \otimes \mu>> M^2 \\
@V\mu \otimes 1VV     @V\mu VV \\
M^2 @>\mu>> M \\
\end{CD}$$

2. 単位元

$$\begin{CD}
1 \otimes M @>\eta \otimes 1>> M \times M @<1 \otimes \eta << M \otimes 1 \\
@| @V\mu VV @| \\
M @= M @= M \\
\end{CD}$$

以上を満たす $(M, \mu, \eta)$ 或いは単に $M$ のことを **モノイド対象** という.

### 例. Set と直積

このモノイド対象を **モノイド** という.
$a, b \in M$ に対して $\mu(a, b)$ を積 $ab$ などと呼んだ.

### 例. 自己関手圏と合成

このモノイド対象を **モナド** という.
例えば [冪集合モナド](power-monad) なんかは Set から Set への自己関手圏におけるモナドの一つになっている.

% トポス - 前層の圏
% 2019-10-19 (Sat.)
% トポス 圏論

$\require{AMScd}$
$$\def\C{\mathcal C}\def\Sets{\mathrm{Sets}}\def\E{\mathcal E}\def\op{\mathrm{op}}\def\Y{\mathcal Y}$$

[前回](topos-01.html) はトポスの定義と, トポスの最も簡単な例として $\Sets$ があることを述べた.
今回は非自明だが典型的なトポスの例として前層を紹介する.

## 前層の圏

$\C$ を任意の圏とする.
対象を $\C$ から $\Sets$ への反変関手であるような関手圏
$$\E = \Sets^{\C^{\op}}$$
を $\C$ の上の **前層** （の圏）という.

## 前層はトポス

$\C$ がどんなものであっても, その上の前層はトポスである.
トポスには３つの要件があった.
前層がその３つを満たすことを順に見ていく.

### 終対象（$1$）, 積, 冪の存在

$1$ 及び積の存在は $\Sets$ のそれを使う.

#### 終対象

$1 \in \E$ は次で定まる.
$$1 \colon \C^{\op} \to \Sets$$
$$1 \colon A \mapsto 1$$

これが確かに終対象であることを定義通り確かめる.
すなわち, 任意の $F \in \E$ について, $s \colon F \to 1$ が唯一あることを見ればいい.

ここで $F$ は $\E$ の対象で $s$ は $\E$ の射であるが, $\E$ は関手圏であったので,
$F$ は関手 $\C^{\op} \to \Sets$ で $s$ は自然変換 $F \to 1$ である.
自然変換であるとはすなわち, $\C$ における任意の射を $F$ および $1$ で写したものの間にいい感じの射を与えてくれること.
そして自然変換 $s \colon F \to 1$ は対象 $A$ には $s_A \colon FA \to 1A$ (ここで $1A=1$) を与えてくれるのだった.

これを図式で書くと次の通り.

$$\begin{CD}
A        @.   FA      @>s_A>>  1A       \\
@VfVV         @AFfAA           @A1fAA   \\
B        @.   FB      @>s_B>>  1B
\end{CD}$$

左の縦の $f \colon A \to B$ は $\C$ から任意に取ってきた射.
これを $F$ と $1$ で $\Sets$ に写してる.
反変なので矢印の向きが逆になっている.
横向きに $s_A, s_B$ でこれをつないで四角形を作っているが, ここが可換であることが自然変換であることの要件.
$1A=1B=1$, $1f=1$ なので右の四角形だけ書き直すと,

$$\begin{CD}
FA      @>s_A>>  1    \\
@AFfAA           @|   \\
FB      @>s_B>>  1
\end{CD}$$

となる. さて $s_A, s_B$ は結局, 終対象への射なのでそれは終対象の要件から唯一であることが分かる.
$$s_A = !_A$$
そしてそのとき問題なく可換でもある.

というわけでこのような自然変換 $s$ は唯一存在する.
従って $1 \in \E$ は確かに終対象.

#### 積

次に積.
これも $\Sets$ の積をそのまま使う.
$F, G \in \E$ について, $F \times G$ を次で定める.
$$F \times G \colon \C^{\op} \to \Sets$$
$$(F \times G)(A) = FA \times GA$$

これが積であることは明らかだよね.

#### 冪

次に冪対象.
これは [米田の補題](Yoneda.html) 及びカリー化を使うと自然に出てくる.
すなわち米田の補題によれば,
関手 $F \colon \C^{\op} \to \Sets$ は
$$\Sets^{\C^{\op}}(\C(-,A),F) \simeq FA$$
を満たす.
ここで $\C(-,A)$ とは $\C$ の対象 $B$ を $\C(B,A)$ に写すような関手
$\C^{\op} \to \Sets$
である.
簡単に $\Y^A$ と書くことにする.
そして
$\Sets^{\C^{\op}}(\Y^A, F)$
とは
$\Y^A$ から $F$ への自然変換全体からなる集合のことである.

先の $F$ に（あるかは分からないが）冪対象 $F^G$ を入れてみると,
$$\Sets^{\C^{\op}}(\Y^A, F^G) \simeq F^G(A)$$
が出てくる.
この左辺にアンカリー化を施すと
$$\begin{align*}
F^G(A)
& \simeq \Sets^{\C^{\op}}(\Y^A, F^G)  \\
& \simeq \Sets^{\C^{\op}}(\Y^A \times G, F)
\end{align*}$$
が得られる.
最後のものは積しか使われていないし, 積はさっき定義したので確かに存在する.
そこで
$$F^G \colon \C^{\op} \to \Sets$$
$$F^G(A) := \Sets^{\C^{\op}}(\Y^A \times G, F)$$
と定義すればよい.

### 始対象, 余積

結論だけ述べると

- $0(A) = 0$,
- $(F+G)(A) = FA + GA$.

### subobject classifier

#### 部分対象（subobject）, 部分関手（subfunctor）

subobject classifier を定めるに先立って部分対象（subobject）を（今頃になってようやく！）定義しておく.

ある圏の対象 $A,B$ について $A$ が $B$ の **部分対象** であることを,
mono 射 $A \to B$ が存在することと定義し
$$A \subset B$$
と書いて表す.
これは特に Sets 圏においてはいわゆる「部分集合$(\subset)$」の一般化だと思える.
圏論で Sets を扱う場合, その要素までは見ないので, 例えば
$\{0\} \subset \{1,2\}$
である.
あくまで単射的な対応がつけばいい.

関手 $F, G \colon \C \to \mathcal D$ について $F$ が $G$ の **部分関手** であるとは,
任意の対象 $X$ について
$$FX \subset GX$$
であることで, このとき
$$F \subset G$$
だと書く.

#### $\Omega \in \E$

$$\tilde{\Omega} \colon \C^{\op} \to \Sets$$
$$\tilde{\Omega}(A) = \{ F \mid F \subset \C(-, A) \}$$

ここで $\C(-,A)$ はやはり米田の補題で出てきた関手で $\Y^A$ などとも書いたものである.
$\Y^A$ の部分関手全体を $\tilde{\Omega}$ と定めた.
さらにその中に順序を定める.

$F, G \subset \C(-, A)$ について,
$\exists ! \colon G \to F$ で

$$\begin{CD}
F      @>mono>>  \Y^A    \\
@A!AA           @|   \\
G      @>mono>>  \Y^A
\end{CD}$$

となるのを $F \succeq G$ だと定める.
そして $F \equiv G \iff F \succeq G \land G \succeq F$ として
$\tilde{\Omega}$
の上の同値を定めることで
$$\Omega(A) = \tilde{\Omega}(A) / \!\equiv$$
とする.

#### true morphism

$$t \colon 1 \to \Omega$$
$$t_A \colon 1 \to \Omega(A)$$
$$t_A(\ast) = \Y^A$$

で定める.

以上で定まった $(\Omega, t)$ が $\E$ の subobject classifier である.

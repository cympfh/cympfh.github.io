% 対象の冪と eval 射
% 2019-02-11 (Mon.)
% 圏論

## 概要

対象の冪を定義し eval 射との関係を見る.

## 関連

昔に層の場合の冪や eval 射をやった: [sheaf-eval](sheaf-eval.html).

## 諸定義

### 対象の冪

随伴を使って冪を定義をする.

圏 $\mathcal C$ とその対象 $A \in \mathcal C$ について,
$- \times A$
なる関手 $\mathcal C \to \mathcal C$ を左随伴にするような関手
$$P^A \colon \mathcal C \to \mathcal C$$
があるとする.
このとき
$B \in A$
について
$P^A(B)$
を
$B^A$ と書いて, これを **冪** (冪対象) と呼ぶ.

> このように $-$ を引数のためのプレースホルダーとして用いて無名関数を表現している.
> つまり $- \times A$ というのは引数を1つ取って $-$ のところに入れるという関数である.
> Scala で言うアンダースコア ( `_` ).
> だから例えば上で出てきた $(- \times A)$ というのは, $B$ を受け取って $B \times A$ を返すモノである.
> ただし射については註意が必要で射 $f$ を $f \times 1_A$ に写す.

関手 $P^A$ のことはこれ以降 $(-)^A$ と書く.
$$- \times A \dashv (-)^A$$

以上が冪の定義.

#### transpose

ところで随伴 $(\dashv)$ というのは,
任意の $X,Y \in \mathcal C$ について次のような同型が自然に成り立つことだった.
$$\mathcal C(X \times A, Y) \simeq \mathcal C(X, Y^A)$$

この対応を $\hat{ }$ で表すことにする.
即ち左辺から取った射 $f$ に右辺で対応するものを $\hat{f}$ と書くし,
右辺で取った $g$ に左辺で対応するものを $\hat{g}$ と書く.
特に $\hat{\hat{f}} = f$ であることに註意 (一対一対応なので).

この $\hat{f}$ のことを $f$ の **transpose** と呼ぶそう.

### eval 射

随伴性より
$$\mathcal C(Y^A \times A, Y) \simeq \mathcal C(Y^A, Y^A)$$
である.
右辺には $1_{Y^A}$ があるのでこれの左辺で対応する射を
$$\def\eval{\mathrm{eval}}\eval \colon Y^A \times A \to Y$$
$$\eval = \hat{1}$$
と定義する.

> Sets とかで言えば, 要は eval とは関数適用 (apply) のことに他ならない.
> 冪対象 $B^A$ というのは $A$ から $B$ への射全体のこと.

## 関手 $(-)^A$

ところで $(-)^A$ がどのような関手であるかを見ておく.
つまり射をどのように写すかをまだ見ていないがこれは随伴性から自然に導かれる.

$g \colon Y \to Z$ について,
$g^A \colon Y^A \to Z^A$ がどのようなものであるかは次の可換図からわかる.

$\require{AMScd}$
$$\begin{CD}
\mathcal C(Y^A \times A, Y) \ni \eval @>{\hat{ }}>> \mathcal C(Y^A, Y^A) \ni 1 \\
@VVV @VVV \\
\mathcal C(Y^A \times A, Z) @>{\hat{ }}>> \mathcal C(Y^A, Z^A)
\end{CD}$$
すなわち
$$g^A = \widehat{g \circ \eval}$$
と写すことが導かれる.

## 冪と eval の普遍性

$$\eval \colon Y^A \times A \to Y$$
は次のような普遍性を持っている.
すなわち,
$$\forall f \colon X \times A \to Y,
\exists ! f' \colon X \to Y^A,$$
$$\begin{CD}
X \times A @= X \times A \\
@Vf' \times 1VV @VfVV \\
Y^A \times A @>\eval>> Y
\end{CD}$$

もちろん, この $f'$ は $\hat{f}$ のことである.

#### 証明

$f$ について随伴性より次の可換図が成り立つ:
$$\begin{CD}
\mathcal C(Y^A, Y^A) @>>> \mathcal C(Y^A \times A, Y) \\
@V\hat{f} \circ -VV @V(\hat{f} \times 1) \circ -VV \\
\mathcal C(X, Y^A) @>>> \mathcal C(X \times A, Y)
\end{CD}$$
左上の $1_{Y^A}$ から可換を回せば
$\widehat{\hat{f} \circ 1} = (\hat{f} \times 1) \circ \eval$
すなわち
$f = (\hat{f} \times 1) \circ \eval$
を得る.
ここで二重の transpose は打ち消すことに註意.

というわけで $f' = \hat{f}$ とすれば先の普遍性の図式は可換になることがわかる.
またこのような射が一意であることも随伴性から明らかである.
念の為に書くと, 他の $f'$ についても成立すると仮定したときに $\hat{f'}$ について今の証明と同じ随伴性を確かめると,
$f = (f' \times 1) \eval = \hat{f'}$
が出てきて,
$\hat{f} = f'$
となる.

ところで, 逆に, この普遍性を eval と冪の定義としてもよい.
(実際, 層の冪なんかはそうやって定義された.)
ただし射の対応を与えて適切に $(-)^A$ を関手にしないと随伴性は成り立たない.
適切に与えた場合に随伴になるのは自明なので省略.
図式だけ書くと, $g \colon Y \to Z$ について次が可換になれば良い.
$$\begin{CD}
X \times A @= X \times A \\
@V\hat{f} \times 1VV @VfVV \\
Y^A \times A @>\eval>> Y \\
@Vg^A \times 1VV @VgVV \\
Z^A \times A @>\eval>> Z
\end{CD}$$

左の縦の射 $(g^A \circ \hat{f}) \times 1 = (g^A \times 1) (\hat{f} \times 1) \colon X \times A \to Z^A \times A$ は,
右の縦の射 $g \circ f \colon X \times A \to Z$ の transpose によって,
$(g^A \circ \hat{f}) \times 1 = \widehat{gf} \times 1$
と書ける.
すなわち
$$g^A \circ \hat{f} = \widehat{gf}.$$

この $f$ に $\eval$ を入れるとさっきのが出てくる

## 例 (Sets)

集合と関数からなる圏 Sets での例を考える.
この圏での直積 $\times$ は普通の集合の直積のこと.
$$\def\Sets{\mathrm{Sets}}\Sets(X \times A, Y) \simeq \Sets(X, Y^A)$$
この対応はいわゆるカリー化 (左辺から右辺) のこと.
すなわち関数 $f \colon X \times A \to Y$ は各 $x \in X$ について,
$$f_x \colon A \to Y$$
を定めることができる $(f(x,a) = f_x(a))$.
従って, $Y^A$ というのを
$\{ g \mid g : A \to Y \}$ ($A$ から $Y$ への関数全体) と定めれば,
$f$ は
$$f_{-} \colon X \to Y^A$$
$$f_{-} \colon x \mapsto f_x$$
なる関数と同一視できる.

これが Sets での冪対象.
次に eval 射を見る.

まず $1 \in \Sets(Y^A, Y^A)$ という恒等関数を考える.
これは $f \colon A \to Y$ なる関数を受け取ったら $f$ を返す.
これに対応する関数 $\hat{1} \colon Y^A \times A \to Y$ はさっき定めたことから,
$$\hat{1}(f, a) = \hat{1}_f(a) = f(a)$$
$\hat{1}_f = f$ に註意.
というわけで $\hat{1}$ というのは関数 $f$ と引数 $a$ を受け取って $f(a)$ を返す関数に過ぎない.
これを関数適用 (apply) という.

---

なんで apply 射って呼ばないんだろう.


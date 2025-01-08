% 対象の冪と eval 射
% 2019-02-11 (Mon.)
% 圏論

$\def\C{\mathscr{C}}$
$\def\transpose#1{\overline{#1}}$
$\def\Sets\{\mathcal{Set}}$
$\require{amscd}$

## INDEX
<div id=toc></div>

## 概要

対象の冪（冪対象）を定義し eval 射との関係を見る.

## 関連

- 層における冪と eval 射の例: [sheaf-eval](sheaf-eval).

## 諸定義

### 対象の冪

随伴を使って冪の定義をする.

圏 $\C$ とその対象 $A \in \C$ があるとき,
$$T \colon \C \to \C$$
$$T(X) = X \times A$$
なる関手を左随伴にするような関手 $P^A$ があるとする.
$$\C(X \times A, Y) \simeq \C(X, P^A(Y))$$

ところで関手 $T$ について引数部分をプレースホルダー ("$-$") で置き換えることで,
単に $(- \times A)$ と書いたりする.
また $P^A(Y)$ のことを $Y^A$ と書くことにすれば,
関手 $P^A$ は $Y \mapsto Y^A$ という形を取るから, $(-)^A$ と書いても良さそう.
$$(- \times A) \dashv (-)^A$$

以上のとき, $P^A(B) = B^A$ のことを
**冪対象**
という.

### transpose

今, 冪 $(-)^A$ があるとする. すなわち次の自然同型がある.
$$\C(X \times A, Y) \simeq \C(X, Y^A)$$
これはつまり,
左右は射の集合なわけだが, この2つには一対一の対応があることを言っている.
その対応を上付き線で表すことにする.
例えば左から取ってきた射 $f$ に対応する右での射を $\transpose{f}$ と書く.
右から取ってきた射 $g$ に対応する左での射を $\transpose{g}$ と書く.
一対一対応であることから $\transpose{\transpose{f}} = f$ である.
$\transpose{f}$ のことを $f$ の **transpose** と呼ぶ.

### eval 射

今までの $X$ に $Y^A$ を代入することで,
$$\C(Y^A \times A, Y) \simeq \C(Y^A, Y^A)$$
を得る.
このとき, 右辺は自分自身への射集合なので, 恒等射 $1$ を含む.
この対応を取って,
$$\def\eval{\mathrm{eval}}\eval \colon Y^A \times A \to Y$$
$$\eval = \transpose{1}$$
と定義する.

## 関手 $(-)^A$

ところで $(-)^A$ がどのような関手であるかを見ておく.
というのも射の写し方をまだ見ていなかったが,
これは随伴性から自然に導かれる.

$g \colon Y \to Z$ を写して得られる射
$g^A \colon Y^A \to Z^A$
がどのようなもの（であるべき）かは次の可換図式からわかる.

$$\begin{CD}
\C(Y^A \times A, Y) @>{\mathrm{transpose}}>> \C(Y^A, Y^A) \\
@V(g \circ -)VV @VV(g^A \circ -)V \\
\C(Y^A \times A, Z) @>{\mathrm{transpose}}>> \C(Y^A, Z^A)
\end{CD}$$

ここで左上から $\eval \in \C(Y^A \times A, Y)$ を選んで, 右下への写し方を見ると,
$$g^A \circ \transpose{\eval} = \transpose{g \circ \eval}$$
$\transpose{\eval}$ は $1$ だったから結局,
$$g^A = \transpose{g \circ \eval}$$
と写すことが導かれる.

## 冪と eval の普遍性

$\eval \colon Y^A \times A \to Y$ は次のような普遍性を持っている.
すなわち,
$$\forall f \colon X \times A \to Y ,~
\exists ! f' \colon X \to Y^A,$$
$$\begin{CD}
X \times A @= X \times A \\
@Vf' \times 1VV @VfVV \\
Y^A \times A @>\eval>> Y
\end{CD}$$

もちろん, この $f'$ は $\transpose{f}$ のことである.

#### 証明

$f \colon X \times A \to Y$
と
$\transpose{f} \colon X \to Y^A$
について随伴性より次の可換図が成り立つ:
$$\begin{CD}
\C(Y^A, Y^A) @>{\mathrm{transpose}}>> \C(Y^A \times A, Y) \\
@V(- \circ \transpose{f})VV @V(- \circ (\transpose{f} \times 1))VV \\
\C(X, Y^A) @>{\mathrm{transpose}}>> \C(X \times A, Y)
\end{CD}$$
この図式の左上から恒等射 $1$ を取ってきて, これで可換を回すと,
$$\transpose{\transpose{f}} = \eval \circ (\transpose{f} \times 1)$$
を得る. ここで左辺の二重の transpose は打ち消し可能なので,
$$f = \eval \circ (\transpose{f} \times 1)$$
となる.

というわけで $f' = \transpose{f}$ とすれば最初の普遍性の図式が可換になることがわかる.
またこのような射が一意であることも随伴性から明らかである.
念の為に書くと, 他の $f'$ についても成立すると仮定したときに $\transpose{f'}$ について今の証明と同じ随伴性を確かめると,
$f = (f' \times 1) \eval = \transpose{f'}$
が出てきて,
$\transpose{f} = f'$
となる.

ところで, 逆に, この普遍性を eval と冪の定義としてもよい.
(実際, [層の冪](sheaf-eval) ではそうやって定義された.)
ただし射の対応を与えて適切に $(-)^A$ を関手にしないと随伴性は成り立たない.
適切に与えた場合に随伴になるのは自明なので省略.
図式だけ書くと, $g \colon Y \to Z$ について次が可換になれば良い.
$$\begin{CD}
X \times A @= X \times A \\
@V\transpose{f} \times 1VV @VfVV \\
Y^A \times A @>\eval>> Y \\
@Vg^A \times 1VV @VgVV \\
Z^A \times A @>\eval>> Z
\end{CD}$$

左の縦の射 $(g^A \circ \transpose{f}) \times 1 = (g^A \times 1) (\transpose{f} \times 1) \colon X \times A \to Z^A \times A$ は,
右の縦の射 $g \circ f \colon X \times A \to Z$ の transpose によって,
$(g^A \circ \transpose{f}) \times 1 = \transpose{gf} \times 1$
と書ける.
すなわち
$$g^A \circ \transpose{f} = \transpose{gf}.$$

この $f$ に $\eval$ を入れるとさっきのが出てくる

## 例. 集合の圏

集合と関数からなる圏 $\Sets$ での例を考える.
この圏での直積 $\times$ は普通の集合の直積（デカルト積）のこと.
$$\Sets(X \times A, Y) \simeq \Sets(X, Y^A)$$
この対応は **カリー化** (左辺から右辺への対応) として知られている.
すなわち関数 $f \colon X \times A \to Y$ は各 $x \in X$ について,
$$f_x \colon A \to Y$$
$$f_x(a) = f(x,a)$$
を定めることができる.
さらに $Y^A$ を $A$ から $Y$ への関数全体からなる集合
$$Y^A = \{ g \mid g : A \to Y \}$$
と定めれば, $f$ は
$$f_{-} \colon X \to Y^A$$
$$f_{-} \colon x \mapsto f_x$$
なる関数と同一視できる.
この $f$ と $f_{-}$ との関係が transpose になっている.

これが $\Sets$ での冪対象.
次に eval 射を見る.

まず $1 \in \Sets(Y^A, Y^A)$ という恒等関数を考える.
$\eval$ はこれに対応する $\transpose{1} \colon Y^A \times A \to Y$.
$$f_x(a) = f(x,a)$$
に, $f_{-}=1, f=\eval$ を代入すると,
$$1_f(a) = \eval(f,a)$$
を得る.
ここで $1_f = f$ だから結局,
$$\eval(f,a) = f(a)$$
となる.

というわけで $\eval$ は関数 $f$ と引数 $a$ を受け取って $f(a)$ を返す操作を表す.
これはふつう関数適用 (apply) と呼ばれる.

---

"eval 射" よりも "apply 射" の方がしっくりくる.


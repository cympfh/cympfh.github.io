# テンソルとはなにか

## 空間のテンソル積

2つの線形空間 $V, W$ があるとき,
ある特別な性質を持つ線形空間 $V \otimes W$ を構成することが出来る.
この $\otimes$ を **テンソル積** という.
$V \otimes W$ の元のことを **テンソル** という
$V \otimes W$ のことは $V$ と $W$ のテンソル積空間とか単にテンソル空間と呼ぶことにする.

> テンソル空間はあくまでも線形空間であることに注意.
> 従ってテンソルとはベクトルの一種である.

再帰的にテンソル積を適用することで
$$(V_1 \otimes V_2) \otimes V_3$$
などと3つ以上のテンソル積が出来るが, 実は結合則を満たすので単に
$$V_1 \otimes V_2 \otimes V_3$$
と書く.

一つの線形空間の $n$ 個のテンソル積
$$V \otimes V \otimes \cdots \otimes V$$
を
$$V^{\otimes n}$$
と書く.

## テンソルの性質

テンソル積の具体的な構成を述べる前にその性質を紹介する.

双線形写像
$$f \colon V \times W \to U$$
に対して線形写像
$$\bar{f} \colon V \otimes W \to U$$
が自然に一対一対応する.
上の型の双線形写像全体と, 下の型の線形写像全体が自然同型であるとも言える.

$$\{ \text{bilinear} \colon V \times W \to U \} \simeq \{ \text{linear} \colon V \otimes W \to U \}$$

自然と言っている意味はその対応の仕方にある.
ある双線形写像
$$\kappa \colon V \times W \to V \otimes W$$
があって,
$$\bar{f} \circ \kappa = f$$
であること.
ここで $\circ$ は関数合成.

> 関数のイコールとして書くなら,
> $\forall v \in V, \forall w \in W, \bar{f}(\kappa(v, w)) = f(v, w)$
> ということ.

$\kappa$ は双線形写像と線形写像の対応を与えてくれる.
線形写像 $\bar{f}$ を与えたとき, 対応する双線形写像 $f$ は $\bar{f} \circ \kappa$ で作れる.
逆に $f$ から $\bar{f}$ を作る操作も自然に作れるはずで,
これは $\kappa$ の逆関数 **のようなもの** を合成することで得られる.

- $f = \bar{f} \circ \kappa$
- $\bar{f} = f \circ \kappa^{-1}$

そしてしかもこの2つの操作を行うと元に戻る.

テンソルとは,
直積空間という線形空間でないものの間にある双（多重）線形写像という一見線形写像の拡張概念に見えるものが,
実はテンソル空間という線形空間と, その間の線形写像だけで表現できることを言っている.

## 普遍性による定義

以上に述べた性質を簡潔に書き直すと次のようになる.
これをテンソルの定義とする.
尚この定義に登場する写像は線形写像と多重線形写像に限る.

任意のベクトル空間
$V, W$ について次のような $\kappa$ と $U_0$ が必ず存在する.
この $U_0$ のことを $V \otimes W$ と書く.

- $\kappa \colon V \times W \to U_0$
- $\forall U, \forall \phi \colon V \times W \to U, \exists ! \bar{\phi} \colon U_0 \to U,$ such that $\phi = \bar{\phi} \kappa$

## ベクトル同士のテンソル積

$\kappa \colon V \times W \to V \otimes W$
はすなわち,
2つのベクトル $v \in V, w \in W$ についてテンソル積 $V \otimes W$ の元, すなわちテンソルに割り当てる.
$$\kappa(v, w) \in V \otimes W$$
このテンソルのことを
$$v \otimes w$$
と書いて「$v$ と $w$ とのテンソル積」などと言うことがある.

しかしながら $\kappa$ は実は一般に全射ではないので,
全てのテンソルが $v \otimes w$ の形で書けるわけではないことに注意.

## テンソルの構成

ではテンソル積の具体的な構成法を一つ示す.
ただし有限次元の線形空間のみを扱う.

線形空間 $V, W$ の基底をそれぞれ

- $\langle v_1, v_2, \ldots, v_n \rangle$
- $\langle w_1, w_2, \ldots, w_m \rangle$

とする.
このとき今から $nm$ 次元の線形空間 $U_0$ を作る
（これが実はテンソル積空間 $V \otimes W$ であることは後々証明する）.

$U_0$ の基底は
$$\langle u_{ij} \mid i=1,2,\ldots,n ;~ j=1,2,\ldots,m \rangle$$

次に双線形写像 $\kappa \colon V \times W \to U_0$ を次で定める.
$$\kappa(v_i, w_j) = u_{ij}$$
$\kappa$ は双線形写像としたので基底の写り方だけ定めれば十分である.
一方で基底の写り方だけで言えば次のようなものが $\kappa$ の逆関数のようなものである.
$$\kappa^{-1}(u_{ij}) = (v_i, w_j)$$
当然, 値域の $V \times W$ は線形空間ではないのでこれは線形写像ではなく,
一般の値 $\alpha^{ij} u_{ij}$ の値を定めないから関数ですらない.
ここでは単に基底の写し方を定めるものとして定めておく.

さて実は以上で以て $U_0$ がテンソル積 $V \otimes W$ である.
そのことを今から見ていく.

まず双線形写像 $f \colon V \times W \to U$ が与えられたとする.
このとき上の $\kappa^{-1}$ を右に合成することで,
基底の写り方
$$(f \circ \kappa^{-1}) (u_{ij}) = f(v_i, w_j)$$
が定まる.
$\kappa^{-1}$ というのが基底の写し方しか定めていないのだが,
この式は $u_{ij} \in U_0$ を $f(v_i, w_j) \in U$ に写してると見れるので,
適切に定義することで線形写像にすることができる.
それを $\bar{f}$ と定義する.
$$\bar{f} \colon U_0 \to U$$
$$\bar{f} (\alpha^{ij} u_{ij}) = \alpha^{ij} f(v_i, w_j)$$
この $\bar{f}$ が所望であることを確認するには
$f = \bar{f} \circ \kappa$
であることを見ればよい.
それには関数の外延性をチェックすればよい.
すなわち一般の $(\beta^i v_i, \gamma^j w_j) \in V \times W$ についての値が等しいことを見ればよい.
$$\begin{align*}
(\bar{f} \circ \kappa)(\beta^i v_i, \gamma^j w_j)
& = \bar{f} ( \beta^i \gamma^j \kappa(v_i, w_j) ) \\
& = \bar{f} ( \beta^i \gamma^j u_{ij} ) \\
& = \beta^i \gamma^j f(v_i, w_j) \\
& = f(\beta^i v_i, \gamma^j w_j)
\end{align*}$$
なので確かにそう.

双線形写像 $f$ からスタートしたが,
線形写像 $\bar{f}$ からスタートして逆に辿っても同様のことが確認できる.

というわけで結局
$$V \otimes W = 
\langle u_{ij} \mid i=1,2,\ldots, \mathrm{dim}(V) ;~ j=1,2,\ldots, \mathrm{dim}(W) \rangle$$
ということが分かった.

## 実多重線形写像としてのテンソル

テンソルは多重線形写像と深い関わりがあった.
また別な定義として, 実多重線形写像そのものをテンソルと定義する方法がある.
すなわち, 線形空間 $V_1, V_2, \ldots, V_m$ と実数全体 $\mathbb R$ を用いて
$$V_1 \times V_2 \times \cdots \times V_m \to \mathbb R$$
という型を持つ多重線形写像をテンソルと呼ぶ.

> 一つの実多重線形写像が一つのテンソルなので,
> テンソル積空間 $V \otimes W$ に相当するのは,
> 実多重線形写像 **全体** である.

### 先の定義との対応

$n$ 次元の $V$ と $m$ 次元の $W$ のテンソル積 $V \otimes W$ を考える.
先に述べたような構成をすればテンソル積は $nm$ 次元の線形空間であり,
その元テンソルは $\alpha^{ij} u_{ij}$ $(i=1,2,\ldots,n ;~ m=1,2,\ldots,m)$ と書ける.

実多重線形写像は実はこの数ベクトル表示に対応している.
すなわち,
$$g \colon V \times W \to \mathbb R$$
$$g(v_i, w_j) \mapsto \alpha^{ij}$$
と定める.
これは結局, $i,j$ に対応する係数は $\alpha^{ij}$ であることを情報として持つ.

もちろん逆に $g$ が与えられても $g(v_i, w_j) u_{ij}$ として先の形に戻せる.
したがって等価である.

---

## 出典

- [普遍性からのテンソル](/taglibro/2019/05/16.html)
- [行列や多重配列のことをテンソルと呼ぶのやめろ](/taglibro/2019/01/22.html)

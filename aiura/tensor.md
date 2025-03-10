% 普遍性からのテンソル
% 2019-05-16 (Thu.)
% 線形代数

## 概要

歴史的にはそもそもテンソルとはテンソル積で得られるベクトル空間の元として定義される.
つまりテンソルの定義にはテンソル積の定義が先立つ.

## index

<div id=toc-level-2></div>

## 参考

1. [ベクトル空間のテンソル積とテンソル空間](http://daisy.math.sci.ehime-u.ac.jp/users/tsuchiya/math/fem/exterior/section1.pdf)
    - 愛媛大学の講義資料? (たぶん)

## notation

ベクトル空間 $U,V,W$ について,
$U \to V$ と書いたら $U$ から $V$ への **線形** 写像のことを表すこととする.
また更に, $U \times V \to W$ と書いたら $U$ と $V$ との直積から $W$ への **双線形** 写像のこととする.

2つの写像 $\alpha, \beta$ について $\alpha \beta$ のように単に並べて,
合成写像 $\alpha \circ \beta$ を表す.
また関数適用も $f(x)$ の代わりに単に並べて $fx$ と書く.

添字に関して, アインシュタインの縮約記法を採用する.
例えば $a^i f(a_i)$ という式は $\sum_i$ を省略しており, その $i$ の範囲は文脈から自明なものとする.

## 注意

体を $k$ で固定して考える.
また登場するベクトル空間はすべて有限次元とする.

## 普遍性によるテンソル積の定義

ベクトル空間 $V, W$ について次のようなベクトル空間 $U_0$ が必ず存在して, それのことを
$V$ と $W$ のテンソル積 $V \otimes W$ と書く.
$U_0$ に要請する性質は次の通り.

1. $\exists \kappa \colon V \times W \to U_0$
1. $\forall U, \forall \phi \colon V \times W \to U, \exists! \overline{\phi}\colon U_0 \to U$ such that $\phi = \overline{\phi} \kappa$

2つ目が1つ目の $(U_0, \kappa)$ に対する普遍性になっていることが分かる.

### 補題

先の条件は次の同値な条件に書き直せる

1. $\kappa \colon V \times W \to U_0$ があって $U_0$ は $\kappa(V \times W)$ で生成される空間である
1. $\forall U, \forall \phi \colon V \times W \to U, \exists \overline{\phi}\colon U_0 \to U$ such that $\phi = \overline{\phi} \kappa$
    - $\exists$ の $!$ が取れた
    - それ以外は同じ

同値なことの確認は難しくないので略.

<details><summary>NOTE</summary>
特に言っておくと, $U_0$ が $\kappa(V \times W)$ から生成されるとは
$\kappa$ が epi であることを言っている.
すなわち,
$$\alpha \kappa = \beta \kappa \implies \alpha = \beta.$$
ただし普通の写像での全射であるとまでは言ってないので注意.
生成するとは結局, $U_0$ にある基底
$\langle g_1,\ldots,\rangle$
があって, この各 $g_i$ に写す方法がありさえすればよい.
任意の $\gamma^i g_i$ に写せるとまでは言っていない (特に $\kappa$ は双線形写像なので).

念のために生成することと epi であることが同値であることを見る.

$V$ の基底を $\langle e_i \rangle$, $W$ の基底を $\langle f_j \rangle$,
$U_0$ の基底を $\langle g_k \rangle$ とする.

$\kappa(V \times W)$ が $U_0$ を生成することと,
$\alpha \kappa = \beta \kappa$
を仮定するときに $\alpha=\beta$ を示す.

各基底 $g_k$ について, ある $(v_k, w_k) \in V \times W$ があって,
$g_k = \kappa(v_k, w_k)$
である.
$U_0$ の任意の元 $u = \gamma^k g_k$ について,
$$\begin{align*}
\alpha u & = \gamma^k \alpha g_k \\
         & = \gamma^k \alpha \kappa(v_k, w_k) \\
         & = \gamma^k \beta \kappa(v_k, w_k) \\
         & = \beta u
\end{align*}$$
であるので $\alpha = \beta$.

逆は対偶で示す.
生成しないことを仮定すると, ある基底 $g_k$ を生成しないから,
$g_k$ の成分だけ射影する関数 $\alpha$ とそれを2倍する関数 $\beta=2\alpha$ を用意すれば,
$\alpha \kappa = \beta \kappa ~(=0)$
となるがもちろん $\alpha \ne \beta$ である.
</details>

## テンソル積の存在

テンソル積の定義を述べたが, そのような $U = V \otimes W$ は必ず存在する.
例えば次である (もちろん線形同型を除けば唯一である).

$V$ を $m$ 次元 $\langle e_i \rangle$,
$W$ を $n$ 次元 $\langle f_j \rangle$ とするとき, $U$ は $mn$ 次元であって,
$$U = \langle g_{ij} \mid 1 \leq i \leq n, 1 \leq j \leq m\rangle$$
$$\kappa \colon V \times W \to U$$
$$\kappa(e_i, f_j) = g_{ij}$$
とする.

定義から明らかに $\kappa(V \times W)$ は $U$ を生成し, $\kappa$ は epi である.

普遍性を確認する. つまり適当な $U'$ と $\phi \colon V \times W \to U'$ があるとする.
このときに,
$$\overline{\phi} \colon U \to U'$$
$$\overline{\phi} g_{ij} = \phi(e_i, f_j)$$
で線形写像として定義する (基底の行き先だけを示したのであとはこれの線形結合で定義する).

任意の $(v, w) = (a^i e_i, b^j f_j) \in V \times W$ について,
$$\begin{align*}
\overline{\phi} \kappa (v, w)
& = a^i b^j \overline{\phi} \kappa(e_i, f_j) \\
& = a^i b^j \overline{\phi} g_{ij} \\
& = a^i b^j \phi(e_i, f_j) \\
& = \phi(v, w) \\
\end{align*}$$
したがって, $\overline{\phi} \kappa = \phi$.

$\overline{\phi}$ が唯一であることは $\kappa$ が epi であることから従う.
つまり, 他に $\psi$ があるなら
$\overline{\phi} \kappa = \psi \kappa$ であるので, $\overline{\phi} = \psi$ が導かれる.

というわけで普遍性は確かに満たしており, これがテンソル積であることが確認できた.
特にこの $\kappa$ のことを **標準写像** という.

## テンソル

テンソル積の元のことを **テンソル** と呼ぶ.

$V \otimes W$ 及びその写像 $\kappa \colon V \times W \to V \otimes W$ について,
$\kappa(v, w)$ のことを $v \otimes w$ と書く.
$\kappa$ が全射とは限らないという話から,
任意の $V \otimes W$ のテンソルがこの $v \otimes w$ という形式で書けるわけではない.
(和でなら表現できる.)

テンソル積やテンソルは 2 つ以上でも再帰的に定義でき, また結合則が成り立つ（らしい）ので括弧を付けずに例えば $U \otimes V \otimes W$ だとか $u \otimes v \otimes w$ だとか書ける.

## 定理

体 $k$ の上のベクトル空間 $V$ に対して, 線形写像の集まり
$\{ f \mid f \colon V \to k \}$
のことを $V$ の双対空間といい $V^*$ と書くのであった.

ここでは便宜的に, 直積に対しては双線型写像の集まりということにして
$(V \times W)^*$
という書き方も許してもらうことにする.

次の定理が成り立つ.
$$V \otimes W \simeq (V^* \times W^*)^*$$

### 証明

$(V^* \times W^*)^*$ もまた $V$ と $W$ のテンソル積であることを示す.
テンソル積どうしは普遍性より同型であるから, それだけ示せばok.

いい感じの
$$\xi \colon V \times W \to (V^* \times W^*)^*$$
によって $((V^* \times W^*)^*, \xi)$ がテンソル積になることを示す.

$(v, w) \in V \times W$ を
$$h \colon V^* \times W^* \to k$$
$$h(f,g) = f(v) g(w)$$
という $h$ に対応付ける写像を $\xi$ だとする.

ところで基底は双対基底にしておく.
すなわち $\langle h_{ij} \mid i, j \rangle$ が基底で,
$$h_{ij}(f_{i'}, g_{j'}) = \begin{cases}
1 & \text{ when } i=i' \text{ and } j=j' \\
0 & \text{ otherwise }
\end{cases}$$
$$f_i(e_{i'}) = \begin{cases}
1 & \text{ when } i=i' \\
0 & \text{ otherwise }
\end{cases}$$
$$g_j(f_{j'}) = \begin{cases}
1 & \text{ when } j=j' \\
0 & \text{ otherwise }
\end{cases}$$
こうすれば $\xi(v_i, w_j) = h_{ij}$.

任意の $\phi \colon V \times W \to U$ に対して,
$$\overline{\phi} h_{ij} = \phi(v_i, w_j)$$
とする（くらいしか自然な写像はない）.

任意の $(v,w) \in V \times W$ について,
$$\begin{align*}
\overline{\phi} \xi (a^i e_i, b^j f_j)
& = a^i b^j \overline{\phi} h_{ij} \\
& = a^i b^j \phi(v_i, w_j) \\
& = \phi (a^i v_i, b^j w_j)
\end{align*}$$
だから可換.

普遍性は略.
気が向いたら計算する.

というわけで, テンソルというとそれに対応する双線型写像があるから, 双線型写像のことをテンソルと同一視してよい.

ベクトル空間 $V_1, \ldots, V_n$ があるときに,
$V_1 \otimes \cdots \otimes V_n$ のテンソルに一対一対応する多重線型写像
$$V_1 \times \cdots V_n \to k$$
がある.

対応は成分ごとに $\kappa$ と $\xi$ で写せばよい??（未確認）

$\require{amscd}$
$$\begin{CD}
V \otimes W @<\kappa<< V \times W @>\xi>> (V^* \times W^*)^*
\end{CD}$$

## おわり

よくある解釈としては適切な基底と, 適切な積の構造を入れさえすれば,
結局多次元配列で表現される.
例えば $m$ 次元ベクトル空間と $n$ 次元ベクトル空間のテンソル積は, $m \times n$ の二次元配列で表現できる.
この意味で, テンソルを行列の拡張と思うことができる.



% ボルツァーノ＝ワイエルシュトラスの定理
% 2020-02-07 (Fri.)
% 集合位相

$\def\Rn{\mathbb R^n}$

## 定理

有限次元ユークリッド空間
$\Rn$
においては,
コンパクトであることと有界閉集合であることは同値.

$$\forall Z \subset \Rn, Z \text{ is compact } \iff Z \text{ is bounded and closed.}$$

証明は次の3つに分けた補題から示される.

### 補題 1: コンパクト $\implies$ 閉集合

これは [以前に](topo.html) 証明済みなので概略だけ言う.
$\Rn$ はハウスドルフ空間である（実数が稠密であるのでそれは明らか）.

コンパクト集合 $Z$ があるとき,
その補集合
$Z' = \Rn \setminus Z$ が開集合であることが確認できればいい.
開集合であることは, 任意の点の周りに開集合が取れればいい.
つまり,
$$\forall x \in Z', \exists \text{ open } U, x \in U \subset Z'$$
というように $U$ が構成できればいい.
ここでハウスドルフの性質を使う.
点 $x$ に対して全ての点 $z \in Z$ を分離出来る.
$$\forall z \in Z, \exists z \in V_z \in Z, \exists x \in U_z, V_z \cap U_z = \emptyset$$
これで $U_z$ をすべて集めて積をとれば $x \in \bigcup U_z \subset Z'$ には違いないのだけど, 一般に無限個の開集合の積は開集合とは限らない.
ここで $Z$ のコンパクト性から, $\{ U_z \}$ の内, 有限個だけ集めれば $Z$ の被覆になっている.
それを $\{ V_z \mid z \in S \}$ とするとき, 対応する
$\{ U_z \mid z \in S \}$
を考えれば, これは $U$ と重ならないので
$U = \bigcup_{z \in S} U_z$
とすればいい.
これは有限個の積なので確かに開集合.

補集合が開集合なので $Z$ は開集合.

### 補題 2: コンパクト $\implies$ 有界

一つのサイズが有限のような被覆で $\Rn$ を覆って見せればよい.
例えば, 球の列
$$\{ U_i = ( \| x \|_2 < i ) \mid i = 1,2,\ldots \}$$
は確かに $\Rn$ の被覆である.

$Z \in \Rn$ がコンパクトならば,
$$\{ U_i \cap Z \}$$
の内有限個を集めれば $Z$ の被覆になっている.
有限個なのでその添字 $i$ の最大値 $I$ が取れて,
$Z$ の半径として $I$ という上限が得られる.
従って $Z$ は有界.

補題 1,2 を合わせて, コンパクト $\implies$ 有界閉集合, が示された.

### 補題 3: 有界閉集合 $\implies$ コンパクト

有界閉集合 $Z$ がコンパクトであることを示す.
一般にコンパクト集合の部分集合はコンパクトなので,
$Z$ より大きな閉集合を作ってそれがコンパクトであることを示す.

$Z$ は有界なので適当なサイズの超立方体 $C_0$ の $1$ 個で $Z$ を被覆できる
$(C_0 \supset Z)$.

$C_0$ がコンパクトでないと仮定して矛盾を導く.
適当な被覆 $\{U_i\}$ を考える.
コンパクトでないので有限被覆を持たない.

$C_0$ を一辺サイズ $1/2$ の $2^n$ 個の立方体に分割することを考える.
小立方体の内の少なくともどれかは, やはり $\{U_i\}$ の有限被覆を持たない.
そうでないと全て有限被覆で済むことになって $C_0$ がコンパクトであることに反する.
というわけでその有限被覆を持たない小立方体の一つを $C_1$ とする.

このことを繰り返してくと $C_0, C_1, C_2, \ldots$ という列が出来る.
サイズは半分ずつになっていくので, その極限はある一点 $x$ に収束する.
ここで $C_0$ が閉集合であるので極限値 $x$ は $C_0$ に含まれる.

被覆の内 $x$ を含むものを $x \in U_j$ とする.
これに対して十分大きな $k$ を取れば $x \in C_k \subset U_j$ とできる.
これは $C_k$ が有限被覆を持たないことに矛盾する.
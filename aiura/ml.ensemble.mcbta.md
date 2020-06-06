% MCBTA の定理
% 2019-09-24 (Tue.)
% アンサンブル学習

$\def\err{\mathrm{error}}$

## 概要

多いは全てより良い (Many Could be Better Than All).

## アンサンブル学習

ざっくりアンサンブル学習が何なのか述べる.

教師あり学習とは真の関数
$f \colon \mathcal X \to \mathcal Y$
を有限のサンプル $D \subset \mathcal X \times \mathcal Y$ から推測すること
（あるいはその分布を推測するなど）
であるが,
何でもいいが一つの学習の枠組みによって構成した一つの予測器 $h$ ($h \approx f$) ではその性能にどうしても限界がある.

そこで予測器を複数通りの方法で複数構成する.
$$H = \{ h_1, h_2, \ldots, h_m \}$$

これを一つの予測器と見做す.
予測の方法は各予測器 $h_i$ の何かしらの平均を取るとか, 多数決を取るなどする.
例えば重み付き平均を取るとすれば,
$H$ を次のようにして予測関数と見做す.

- $H \colon \mathcal X \to \mathcal Y$
- $H(x) = \sum_i w^i h_i(x)$
    - $w^i \geq 0; \sum_i w^i = 1$

### アンサンブル予測器の予測誤差

これは $h_i$ どうしが互いの欠点を補うことを期待している.
例えばテストデータセットについて,
各データが $H$ の内の過半数には正しく予測されるが残りには誤って予測されるようなことを考える.
この場合は各 $h_i$ を単体で使うとその性能はせいぜい 50% 強程度である.
しかし常にどのデータも過半数には正しく予測されるのであれば, $H$ としての性能は 100% 正しく予測できることになる.

もちろんこれは各 $h_i$ の性能が多様でバラバラであることを期待している.
(だから $H$ の構成方法には工夫が必要になる.)

さて先のように $H = w^i h_i$ という重み付き平均で構成した場合の予測誤差を評価してみる.
平均の自乗誤差は
$\int \left[H(x) - f(x)\right]^2 p(x) dx$
である.

$$\begin{align*}
\int \left[H(x) - f(x)\right]^2 p(x) dx
& = \int \left[\sum_i w^i h_i(x) - f(x)\right]^2 p(x) dx \\
& = \int \left[\sum_i w^i \left( h_i(x) - f(x) \right) \right]^2 p(x) dx & ~~ \sum_i w^i=1 \text{ であることを使っている } \\
& = \int \left[\sum_i w^i \left( h_i(x) - f(x) \right) \right] \left[ \sum_j w^j \left( h_j(x)-f(x) \right) \right] p(x) dx \\
& = \sum_i \sum_j w^i w^j \int \left( h_i(x) - f(x) \right) \left( h_j(x)-f(x) \right) p(x) dx \\
\end{align*}$$

最後の
$\int \left( h_i(x) - f(x) \right) \left( h_j(x)-f(x) \right) p(x) dx$
を
$C_{ij}$
と置くことにする.
これは各 $h_i, h_j$ に関する値で, $i=j$ なら普通に $h_i$ 自体の予測誤差.
一般には $h_i$ と $h_j$ の誤差の相関になっている.

$$\err(H) = w^i w^j C_{ij}$$

## MCBTA; 予測器の選別

予測器のセット $H$ が与えられた時,
一般には $H$ 全てを使うのが最適ではなく,
適切に選んだ部分 $H' \subset H$ が最適になり得る.
これを MCBTA の定理という.

### アンサンブル枝刈り

その選別に先に導出した $\err$ を使う.
ただし簡単のため $w^i = 1/n$ ($n$ は $H$ のサイズ) とする.
すると
$$\err(H) = \frac{1}{n^2} \sum_i \sum_j C_{ij}$$
になる.
ここで仮に $h_k$ を抜いてみると, $H' = H \setminus \{ h_k \}$ の誤差は
$$\err(H') = \frac{1}{(n-1)^2} \sum_{i \ne k} \sum_{j \ne k} C_{ij}$$

$\err(H) > \err(H')$ とあれば $h_k$ を抜いていい.


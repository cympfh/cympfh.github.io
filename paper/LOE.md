% Local Ordinal Embedding
% http://www.tml.cs.uni-tuebingen.de/team/luxburg/publications/TeradaLuxburg_ICML2014.pdf
% 埋め込み表現 多様体学習

## 概要

順序構造が定められた対象に関する埋め込み表現を考える.
ここで順序というのは対象同士の距離に関する大小のこと.
このような順序に関する制約を満たす埋め込み表現を作る問題を考える.
これを最適化問題に落とし込んで解く手法として SOE を提案する.
次に問題を制約を kNN に限定した場合に適用したものを LOE として提案する.

## イントロ

対象の集合 $X = \{x_1, x_2, \ldots, x_n\}$ とそれらの距離
$\xi \colon X \times X \to \mathbb R_{\geq 0}$
があるとする.
ここで $X$ は陽に与えられるが $\xi$ は観測できない関数だとする.
その代わりに次のような順序だけが与えられている.

$$(i,j,k,l); \xi_{ij} \lt \xi_{kl}$$

そこで適切な埋め込み表現
$$\hat{x_i} \in \mathbb R^p$$
を全ての対象について割り当てることで,

$$\xi_{ij} \lt \xi_{kl} \iff \| \hat{x_i} - \hat{x_j} \| \lt \| \hat{x_k} - \hat{x_l} \|$$

これを満たすようにしたい.

> このような問題は Sheparad 1962, Kruskal 1964 の時代から研究されてきたそう.
> 最近は機械学習の文脈でよく出てくるようになった.

## Soft Ordinal Embedding; SOE

### 問題設定

対象を $[n] = \{1,2,\ldots,n\}$ だとし,
制約として $A \subset [n]^4$ が与えられる.
これの意味は,
$$(i,j,k,l) \in A \iff \xi_{ij} \lt \xi_{kl}$$
ということ.

このときに埋め込み表現の行列
$$X \in \mathbb R^{n \times p}$$
を構成することを考える.
ここで $p$ は最初に決めて固定しておく.
$x_i$ で $X$ の行ベクトルを表し, これが対象 $i$ の表現.
普通のユークリッド距離を $d_{ij}(X) = \| x_i - x_j \|$ と書く.

厳密に制約 $A$ を全て満たすことの表現は次の $\mathcal L$ がゼロになることだ.
$$\mathcal L_1(X \mid A) = \sum_A \mathbb{1}[d_{ij}(X) \geq d_{kl}(X)]$$
しかし, これは連続関数でもないし直接最適化の目的関数にするのは難しい.

これをソフトにしてやる.
次は Johnson, 1973 によるやり方.
$$\mathcal L_2(X \mid A) = \frac{\sum_A (\max(0, d^2_{ij}(X) - d^2_{kl}(X)))^2 }{ \sum_A d^2_{ij}(X) - d^2_{kl}(X) }$$

### SOE

一方で本論文で彼らは別なやり方を提案してる.
正のスケールパラメータ $\delta > 0$ を用いて,

$$\mathcal L(X \mid A, \delta) = \sum_A (\max(0, d_{ij}(X)+\delta-d_{kl}(X)))^2$$

これの最小化を考える.
この最適化問題を **SOE; soft ordinal embedding** と名付けてある.

論文の記法に従うと $o_{ijkl} = \mathbb{1}[(i,j,k,l) \in A]$ を使って,
$$\mathcal L(X \mid A, \delta) = \sum_{i,j,k,l} o_{ijkl} (\max(0, d_{ij}(X)+\delta-d_{kl}(X)))^2$$
としてある.

SOE とその $\delta$ に関して次の性質がある.
$A,p$ について, $\delta_1, \delta_2$ のそれぞれで SOE の最適解を求めることを考える.
$\delta_1$ による最適解を $X$ とする. このとき

$$X' = \frac{\delta_2}{\delta_1} X$$

は $\delta_2$ による最適解（の一つ）になっている.

> $\delta=0$ のとき, SOE には自明な解として $X=0, d=0$ がある.
> これは一番最初の厳密なバージョン $(\mathcal L_1)$ でも同じことが言えた.
> 2つ目の Johnson による方法 $(\mathcal L_2)$ では分母にも距離があるからこれが防げていた.
> 今回は $\delta$ をある程度大きくしておくことで, 単純に $d=0$ とするだけでは不十分で,
> $d_{kl} - d_{ij} \geq \delta$ という差が付くような距離を持たせる必要がある.
> このことによって自明な距離にはならない.
> では $\delta$ としてどんな値に設定する必要があるかという別な問題が生じるように思えるところだが,
> 先述した性質は, 実はどんな $\delta$ であっても,
> 本質的には（up to 拡大縮小）一意な最適解が得られることを言っている.

### Majorization Algorithm（優関数法）

SOE の最適化を求めるアルゴリズム.

実関数 $f \colon X \to \mathbb R$ について, $g$ が $f$ の majorizing 関数であるとは, 次のようなもののこと.

- $g \colon X \times X \to \mathbb R$
- $f(x_0) = g(x_0, x_0) ~ \forall x_0 \in X$
- $f(x) \leq g(x, x_0) ~ \forall x,x_0 \in X$

例えば今 $x,x'$ について $g(x',x) \leq g(x,x)$ だとすると,
$g$ の定義から $f(x') \leq g(x',x) \leq g(x,x)=f(x)$ を得る.
つまり $g$ に関して最小化することは $f$ に関する最小化にもなっていることが分かる.
$f$ よりも最小化しやすい majorizing $g$ を構成できれば
$$x_{t+1} \leftarrow \mathrm{argmin}_x g(x, x_t)$$
を逐次的に実行してくような最適化法がありえる.

というわけで SOE の $\mathcal L$ の majorizing 関数を構成する.

$$\tilde{L}(X,Y) = \alpha_{ijkl} (x_i - x_j)^2
+ \alpha_{ijkl}^\ast (x_k - x_l)^2
-2\beta_{ijkl} (x_i - x_j)^t (y_i - y_j)
-2\beta_{ijkl}^\ast (x_k - x_l)^t (y_k - y_l)
+\gamma_{ijkl}$$

このとき

- $\mathcal L(X) \leq \tilde{L}(X,Y)$
- $\mathcal L(X) = \tilde{L}(X,X)$

が満たされていて確かに $\tilde{L}$ は $\mathcal L$ の majorizing 関数になっている.
ただしここで $\alpha,\alpha^\ast,\beta,\beta^\ast,\gamma$ は $Y$ から適切に決まるパラメータ.
論文の補遺ページにあるがここでは省略.

## Local Ordinal Embedding; LOE

### 問題設定

一般の順序制約は $O(n^4)$ に関するものなので広すぎる.
一気に狭めた問題を考える.

対象を $[n]=\{1,2,\ldots,n\}$ とする.
制約として kNN と呼ばれる各対象の隣接点集合
$$\Gamma \colon [n] \to 2^n$$
$$\Gamma_i \subset [n]$$
$$|\Gamma_i| = k$$
が与えられるとする.

ここで kNN の意味は次のようである.
$$j \in \Gamma_i \land l \not\in \Gamma_i \implies \xi_{ij} \lt \xi_{il}$$
つまり kNN $\Gamma_i$ は $i$ から見て近い対象を集めてきた集合である.

kNN $\Gamma$ はグラフで表現することも出来る.
すなわち, 対象を頂点とし, $j \in \Gamma_i$ のことを有向辺 $i \to j$ で表現する.
これを kNN グラフ $G$ という.

kNN グラフ $G$ が与えられたときに,
対象に埋め込み表現 $X \in \mathbb R^{n \times p}$ を適切に表現することで,
$G$ を再現するようなものを求めよというのが問題である.

### 学習アルゴリズム

次元 $p$ は最初に決めて固定してある.

kNN グラフ $G$ の隣接行列を $A = (a_{ij})_{ij}$ とする.
辺 $(i \to j)$ があるとき（すなわち $j \in \Gamma_i$） $a_{ij}=1$ さもなくばゼロである.
$$a^\ast_{ijk} = a_{ij} (1 - a_{ik})$$
という値を定める.
このとき, kNN の制約を満たすことは次の値が最小化されゼロであること.

$$\mathcal{L}(X \mid \delta) = \sum_{i,j,k} a^\ast_{ijk}
\max\left( 0, d_{ij}(X) + \delta - d_{ik}(X) \right)^2$$

これについて先述した majorizing 関数を構成すると次のようになる.

$$\mathcal{L}(X \mid \delta) \leq \sum_{s=1}^p \left[
x_s^t M x_s - 2x_s^t H y_s
\right] + \gamma$$

ここで $x_s, y_s$ は $X,Y \in \mathbb{R}^{n \times p}$ の列ベクトル.
$M,H,\gamma$ は $Y$ から適切に定まるパラメータ.
論文の補遺ページにあるがここでは省略.
そして右辺は普通に微分できる形をしてるので, $Y$ に対して 最小化する $X$ は代数的に求まる.

## LOE の実験

適当に作ったダミーデータから kNN グラフを構築,
もとのダミーデータが復元できるかを見る.
大体出来てる.
本当にもとの座標を復元したいなら LOE 一択といった結果.

![](https://i.imgur.com/HXtJq8A.png)

二次元データや三次元データ, kNN グラフからの復元など何通りかの実験結果が載ってある.
上図はその一つ.

補遺の Figure 2 は kNN の k を変えた場合に復元されたデータを比較してる.
少なすぎる $(k=10)$ と難しいのは当然だが,
多すぎる $(k \geq 450)$ 場合でも次第に潰れるようになってる.
全部が隣接点になるから, それもそうか.

## 感想

Majorization Algorithm が複雑だ.
適当な任意の勾配法で学習させてもいいのかな.

実験を見ると復元でき具合は LOE が抜き出てる.
t-SNE がピーキーだ.
最もその辺は, 復元というよりは点と点が隣同士にあって繋がってるかどうかだけを気にしてるような手法だと思うので比較対象としてフェアじゃない気もするけども.
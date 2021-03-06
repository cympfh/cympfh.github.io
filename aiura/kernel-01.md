% カーネル法 - Introduction
% 2016-09-18 (Sun.)
% 機械学習
% カーネル法によるパターン解析 第1章

## index

<div id=toc></div>

## 線形分類

データ $x \in \mathbb{R}^n$ を二値 $y \in \{-1,1\}$ に分類したい.
**線形分類** は $\mathbb{R}^n$ 上に超平面 (二次元上なら直線) を引いて、$x$ がそれより上にあるか下にあるかで分類する方法である.
どちらでも良いのだが、超平面より上にあるなら $y=+1$ で、下にあるなら $y=-1$ とする.

$\mathbb{R}^n$ 上の超平面はベクトル $w \in \mathbb{R}^n$ とスカラー $b \in \mathbb{R}$ を以って、方程式

$$\langle w, x \rangle + b = 0$$

と表せる.
ここで $\langle x_1, x_2 \rangle$ はベクトル $x_1, x_2$ の内積のこと.
幾何的な文脈では $w$ は法線ベクトルで、$b$ はy切片である.
どうせ次元 $n$ が1増えても誰も気にしないので、$x$ の後ろに定数 1 を結合して、$w$ の後ろに $b$ を結合することで、

$$\langle w, x\rangle = 0$$

と書ける.
式を少しでもすっきりさせたいので、こうする.
データが上にあるか下にあるかは $>0$ か $<0$ で表現できる.

線形分類器とは、与えられた $\{(x_i, y_i)\}_{i=1,2,\ldots,N}$ について、それを正しく (もしかしたら完全にではなくとも、できるだけ) 分類するような超平面のことである.
即ち、
$$\forall i, (\langle w,x_i \rangle > 0 \land y_i = +1) \lor (\langle w,x_i \rangle < 0 \land y_i = -1)$$
が成り立つような $w$ のことである.

また逆に、ある $w$ によって上が満たせるとき、データ $\{x_i\}_i$ は **線形分離可能** である、と言う.

また、そのような $w$ を計算する過程のことを、 **線形分類器の学習** と呼ぶ.
学習のためのアルゴリズムはいくつかあるが、[パーセプトロン](NNs.html) は単純ながらも興味深い.
この方法を踏襲した[AROW](arow.pdf) や、また[SVM](svm.html) も原理的にはこれと同じである.
そしてこれら全てに共通してることとして次のような事実がある.

パーセプトロン、AROW、SVM で学習して得られた $w$ は、ある $\{\alpha_i\}_{i=1,2,\ldots,N}$ ($\alpha_i \in \mathbb{R}$) が存在して次で表現される:
$$w = \sum_i \alpha_i x_i.$$
即ち、学習される超平面は、学習データ $x_i$ の線形和で表される.

## 双対表現

$w$ の別な表現があるのなら、それを代入したくなるのが人情.

$$\langle w, x' \rangle = \sum_i \alpha_i \langle x_i, x' \rangle$$

## 特徴空間

線形分類器の致命的な問題は、そもそもデータは線形分離可能とは限らないこと.
曲面でしか分離できないようなケースも十分考えられる.
適当な関数 $\phi$ によって
$x \in \mathbb{R}^n \mapsto \phi(x) \in \mathbb{R}^m$
と写すことで線形分離が可能になるかもしれない.
この写した先の空間を **特徴空間** と呼ぶ.

特徴空間での線形分類を考えるには、前章までで述べていた $x$ を $\phi(x)$ に置き換えれば良い.

双対表現を用いる場合、$\phi$ 自体を陽に記述できる必要はない.
なぜなら
$$\langle w, \phi(x') \rangle = \sum_i \alpha_i \langle \phi(x_i), \phi(x') \rangle$$
の右辺が計算できれば良いので、
$\kappa(x_1, x_2) = \langle \phi(x_1), \phi(x_2) \rangle$
なる $\kappa$ を直接考えても問題ないから.
これは $\kappa$ の中身に依っては計算量の削減にもつながる.
この $\kappa$ を **カーネル関数** と呼ぶ.

## まとめ

線形分類器は次のような $f$ である.
$f$ の構成には、学習データ $\{x_i\}_{i=1,2,\ldots,N}$ 、パラメータ $\{\alpha_i\}_{i=1,2,\ldots,N}$ 及びカーネル関数 $\kappa$ が必要.

- $f(x) = \sum_{i=1}^N \alpha_i \kappa(x_i, x)$.

そしてこれを用いた分類はこう:

- $y = +1$ if $f(x) > 0$ else $-1$.

## カーネル関数を用いることの利点

もしかしたら計算量が削れるのも良いことだが、利点はそれだけではない.
カーネル関数の型は $\kappa: (T, T) \rightarrow \mathbb{R}$ であれば何だって良い.
今まで、 $x \in \mathbb{R}^n$ としていたが、 $x$ を実ベクトルに限る必要は最早ない.
$x$ が集合であってもグラフであっても、適切なカーネル関数を設計できるなら線形分類器を構成することができる.

あと、直接 $\phi$ を設計することは $\kappa$ を設計することに表現力は落ちる.
$\kappa$ は $\phi$ から導けるからである.
しかし逆に $\phi$ を $\kappa$ から導けるとは限らない.
例えば[rbfカーネル](http://ibisforest.org/index.php?Gaussカーネル) は $\phi$ を陽に記述することはできないが、
なかなか強いカーネルとしてしばしば用いられる.
この事実は $\kappa$ の設計は $\phi$ の設計 (つまりどんな特徴空間を用いるか、の設計) よりも大きな表現力を持つことを言っている.


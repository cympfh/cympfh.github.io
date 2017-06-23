% Factorization Machines (FMs)
% http://www.csie.ntu.edu.tw/~b97053/paper/Rendle2010FM.pdf
% 分類器 機械学習

## FMs とは何か

超スパースなデータにも使える予測器. 線形分類器の拡張になっている.
基本的に回帰モデルの形をしているが、分類器としても使えるし、スコアを計算するものだと思えばランキングを予測するようにも使える.
スパースでデータ量が増えても線形程度にしか時間及び空間が増えない.

## 手法の概要

データ $x \in \mathbb{R}^n$ から $y$ を予測するモデルとして

$$\hat{y} = w_0 + \langle w, x \rangle + \sum_{i < j} \langle v_i, v_j \rangle x_i x_j$$

とする (この形を 2-way FM という).

ここで

- $w_0 \in \mathbb{R}$
- $w \in \mathbb{R}^n$
- $V \in \mathbb{R}^{n \times k}$
    - $v_i \in \mathbb{R}^k$ は $V$ の $i$-th 行ベクトル
    - $k$ はある自然数 (モデルのためのハイパーパラメータ)
- $x_i$ は入力 $x$ の $i$-th 成分
- $\langle \cdot, \cdot \rangle$ は2つの同じ長さの行/列ベクトルの内積

第二項までは通常の線形分類器であり、
第三項はデータの成分間の相互作用 (interaction) を表現している.
$\langle v_i, v_j\rangle$ は相互作用の為の重みである.
これ自体を $i, j$ 間の相互作用 (interaction) と呼ぶ.
わざわざ一個の重み $w_{i,j}$ として表現をしないのは、
陽に $w_{i,j}$ を計算し保持しておくと、$O(n^2)$ の空間が必要になるし、予測の計算も $O(n^2)$ 掛かる.
適当な $k$ を決めて $V$ を持つことにすると、空間は明らかに $O(nk)$ で済み、
後述するように予測の計算も $O(nk)$ で済む.

### データの持ち方

データの持ち方が若干特殊.
基本的に素性を何でも突っ込む (ベクトル結合).

例えば、ユーザー $U$ と、映画 $M$ があって、
ユーザーに関する素性 $V$ と映画に関する素性 $N$ があったときに、
ユーザー $u \in U$ の映画 $m \in M$ に対する評価値 $y \in \mathbb{R}$ を予測することを考える.
(この例は元論文にあるものを参考にしている.)

データ $x$ (列ベクトル) を次のように作る.

- $x_u$: ユーザー $u \in U$ を 1-of-K (one-hot) 表現で $|U|$ 次元ベクトルで表現する
- $x_m$: 映画 $m \in M$ を同様に 1-of-K で $|M|$ 次元ベクトルで表現
- $x_v$: 他の素性もよしなにベクトルで表現
- $x_n$: よしなに

これらを結合して $|U|+|M|+\cdots$ 次元の列ベクトル $x$ とする.

このようにしてデータ
$$\mathcal{D} = \{ (x_i, y_i) \}_i$$
を作る.

元論文では、この列ベクトル $(x_i)_i$ を縦に並べて大きな行列としている.

### 耐スパース性

FMsはデータが超スパースであることを仮定している.
そのような場合、
例えばユーザー $u_1$ の 映画 $m_1$ に対する評価がデータに含まれないことが多い.
ということは、$u_1$ (に相当する成分) と $m_1$ (に相当する成分) との相互作用を推定することは出来なさそうに思える.
FMs が上手いのはそれを直接推定することはせず、
$v_{u_1}$ 及び $v_{m_1}$ を推定して、その内積を相互作用としていることである.
それらは別な関係、例えば $u_1$ と $m_2$ との関係、$u_2$ と $m_1$ との関係などから推定出来るかもしれない.

### 予測の計算方法

初めに示した計算式そのままだと $O(kn^2)$ 掛かりそうだが、式変形を施すと $O(kn)$ で済む.

すなわち、第三項であるが (簡略のため先に二倍したものを考えると)、

- $2 \sum_{i < j} \langle v_i, v_j \rangle x_i x_j = \sum_i \sum_j \langle v_i,v_j x_i x_j \rangle - \sum_i \langle v_i,v_i \rangle x_i x_i$
    - $= \sum_i \sum_j \sum_k v_{i,k} v_{j,k} x_i x_j - \sum_i \sum_k v_{i,k}^2 x_i^2$
    - $= \sum_k \left[ \sum_i \sum_j v_{i,k} v_{j,k} x_i x_j - \sum_i v_{i,k}^2 x_i^2 \right]$
    - $= \sum_k \left[ (\sum_i v_{i,k} x_i) (\sum_j v_{j,k} x_j) - \sum_i v_{i,k}^2 x_i^2 \right]$
    - $= \sum_k \left[ (\sum_i v_{i,k} x_i)^2 - \sum_i (v_{i,k} x_i)^2 \right]$

これなら $O(kn)$ で計算できる.

### 最適化 (学習)

微分は容易だし、好きな最適化ソルバを流用すれば良い.

- $\frac{\partial}{\partial w_0} \hat{y} = 1$
- $\frac{\partial}{\partial w_i} \hat{y} = x_i$
- $\frac{\partial}{\partial v_{i,k}} \hat{y} = x_i \sum_j v_{j,k} x_j - v_{i,k} x_i^2$

## $d$-way FM

先述した形のものは、ちょうど2つの成分の相互作用だけを見るので 2-way FM と呼ぶ.
これは一般化できて、ちょうど $d$ つ成分の相互作用を考慮する

$$\hat{y} = w_0 + \langle w, x \rangle + \sum_{i_1 < i_2 < \cdots < i_d} \left( \prod_i x_i \right) \langle v_{i_1}, v_{i_2}, \ldots v_{i_d} \rangle$$

も考えられる. これを $d$-way FM と呼ぶ.
ここで、
$\langle v_1,v_2,\ldots,v_d \rangle$ は
成分間の積の和で
$\sum_i \sum_k v_{i,k}$
と定める.

## SVM との比較

## 行列分解との比較


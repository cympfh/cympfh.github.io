% Multilayer Perceptron Algebra
% https://arxiv.org/abs/1701.04968
% 深層学習 代数

## INDEX
<div id=toc></div>

## 概要

簡単のため、多層パーセプトロン (MLP) を扱う.
2つ以上の MLP の合成、或いは MLP の分解などの具体的な方法を定め、その性質を Accuracy を指標にして調べることを目的とする.
ただし現状 (1701.04968v1) では、ほとんど自明な性質しか描かれてない上に数式に誤植が多いので脳内補完しながら読んだ.
当たり前だが出現する対訳は全て私が勝手に与えた

## 私の感想

代数操作を定義するのに、いちいち、ここまで厳密に書かなくても、

$$(\mathcal{N}_1 + \mathcal{N}_2)(x)
=
\sigma\left(\omega\cdot\left[\begin{array}\\\mathcal{N}_1(x)\\\mathcal{N}_2(x)\end{array}\right] - \theta\right)$$

($\omega, \theta$ がなんか $\lambda$ でうだうだ書かれる謎のパラメータ)
って風に (外延的に) 定めて、具体的な構成はおまけページに書く程度にすればいいのに.
なぜなら、この論文で定義として与えられた構成法は、わざわざ書く必要のないくらい、自明すぎる方法であるし、データ圧縮にもなってないので実用的ではないから.

## 動機

予測器
$\mathcal{X} \to \mathcal{Y}$
を MLP で構成し、
ラベル付きのデータから教師あり学習をしたとする.
ここで2つの異なるデータセット $D_1$ 及び $D_2$ を用いて学習したものを
$\mathcal{N}_1, \mathcal{N}_2$
とする.
どうすればこの2つの (学習済み) MLP から、
データセット $D_1 \cup D_2$ で学習したのと同等の MLP を得ることが出来るだろうか.
もし出来るのであれば、そのような操作を和と定義して

$$\mathcal{N}_1 + \mathcal{N}_2$$

と書きたい.
ただし、この目的は本研究では未だ達成されてないので註意.

## $\ell$ 層MLP ($\ell$-layer MLP)

> ここはみんな知ってることなのでそんなに厳密に書かない.

$\mathcal{N}$ が $\ell$ 層MLP であるとは、$\ell$ 個の正の整数

$$n_1, n_2, \ldots, n_\ell$$

があって、
次のような関数及び行列のこと.

- 関数 $b_k$:
    - $b_k(\mathcal{N}) = \mathbb{R}^{n_k}$
        - これは第 $k$ 層の空間のこと
    - $(k=1,2,\ldots, \ell)$
- 重み行列 $\omega_k$
    - $(k=1,2,\ldots, \ell-1)$
- 閾値ベクトル $\theta_k$
    - $(k=1,2,\ldots, \ell-1)$
- 関数 $f_k : \mathbb{R}^{n_k} \to \mathbb{R}^{n_{k+1}}$
    - $f_k(x) = \sigma \left( \omega_k x - \theta_k \right)$
    - $(k=1,2,\ldots, \ell-1)$
        - ここで $\sigma$ は要素ごと (element-wise) のシグモイド関数

そして $f_1$ から $f_{\ell-1}$ を順に合成した関数のことを $\mathcal{N}$ と同一視する:

$$\mathcal{N} = f_{\ell-1} \circ \cdots \circ f_2 \circ f_1$$

註意すべきこととして、
全ての層で $\sigma$ による活性化を仮定している.
従って $\mathcal{N}$ の値域は
$(0, 1)^{n_\ell}$.

以上の定義は結局、関数 $f_k$ を定めるためのもので、
$\omega_k$ 及び $\theta_k$ (そしてそれらの次元を決定するための $b_k$)
はそのための **パラメータ** である.
本研究では、次のような状況を想定している.
即ち、まず MLP を構造を決定する $b_k$ を固定していて、
あるデータセットが与えられ、それに最適なパラメータを既に学習している.
学習済みのパラメータを含めて、MLP $\mathcal{N}$ と呼んでいる.

特に
$\mathcal{N}$ のパラメータ $\omega_k$ のことを
$\omega_k(\mathcal{N})$
と冗長に書くことにする.
$\theta_k$ も同様.

### 二値分類と多クラス分類

1. 二値分類するような
$\ell$ 層 MLP $\mathcal{N}$ とは、
$b_\ell(\mathcal{N}) = \mathbb{R}$
であって、
$\mathcal{Y} = \{+, -\}$
で、
$\mathcal{N}(x) > 0.5$
なら $+ \in \mathcal{Y}$ に、
さもなくば $- \in \mathcal{Y}$ に予測するもの.

2. 多クラス分類するような
$\ell$ 層 MLP $\mathcal{N}$ とは、
$b_\ell(\mathcal{N}) = \mathbb{R}^m$
であって ($m$ はクラス数)、
$\mathcal{Y} = \{1,2,\ldots,m\}$
で、
$y = \text{argmax}_i \mathcal{N}(x)_i$
に分類するようなもの.

#### 正解率

以上の予測の方法で、
データセット $D$ に関する $\mathcal{N}$ の正解率 (accuracy) を測って

$$\mathcal{A}_D(\mathcal{N})$$

と書く.

## MLP 操作の諸定義

ここから MLP の変換・合成に関する操作をいくつか定義する.

### 補MLP (Complementary Net)

$\ell$ 層 MLP $\mathcal{N}$ に対して、関数の出力が $y$ のときに $1-y$ を出力するような
$\ell$ 層 MLP を次のようにして定める.
そしてこれを $\mathcal{N}$ の補MLPと呼び $\mathcal{N}^c$ と書く.

- $b_k(\mathcal{N}^c) = b_k(\mathcal{N})$
- $\omega_k(\mathcal{N}^c) = \begin{cases}\omega_k(\mathcal{N}) & \text{when } k < \ell -1 \\ - \omega_{\ell-1}(\mathcal{N}) & \text{otherwise }\end{cases}$
- $\theta_k(\mathcal{N}^c) = \begin{cases}\theta_k(\mathcal{N}) & \text{when } k < \ell -1 \\ - \theta_{\ell-1}(\mathcal{N}) & \text{otherwise }\end{cases}$

つまり、最後の層のパラメータだけ、符号を逆転させるのである.

### MLP和 (Sum Net)

$b_1(\mathcal{N}_1) = b_1(\mathcal{N}_2)$
かつ
$b_\ell(\mathcal{N}_1) = b_\ell(\mathcal{N}_2) = \mathbb{R}$
であるような2つの
$\ell$ 層 MLP
$\mathcal{N}_1$ と
$\mathcal{N}_2$ があるとする.
これらの和
$$\mathcal{N}_1 + \mathcal{N}_2$$
を
$\ell+1$ 層 MLP として与える.

- $b_1(\mathcal{N}_1 + \mathcal{N}_2) = b_1(\mathcal{N}_1) = b_1(\mathcal{N}_2)$
- $b_k(\mathcal{N}_1 + \mathcal{N}_2) = b_k(\mathcal{N}_1) \otimes b_k(\mathcal{N}_2)$ $(k=2,3,\ldots,\ell)$
- $b_{\ell+1}(\mathcal{N}_1 + \mathcal{N}_2) = \mathbb{R}$
- $\omega_1(\mathcal{N}_1 + \mathcal{N}_2) = \left[\begin{array}\\\omega_1(\mathcal{N}_1)\\\omega_1(\mathcal{N}_2)\end{array}\right]$
- $\omega_k(\mathcal{N}_1 + \mathcal{N}_2) = \left[\begin{array}\\\omega_k(\mathcal{N}_1)&\\&\omega_k(\mathcal{N}_2)\end{array}\right]$ $(k=2,3,\ldots,\ell-1)$
- $\omega_\ell(\mathcal{N}_1 + \mathcal{N}_2) = \left[\begin{array}\\\lambda&\lambda\end{array}\right]$
- $\theta_k(\mathcal{N}_1 + \mathcal{N}_2) = \left[\begin{array}\\\theta_k(\mathcal{N}_1)\\\theta_k(\mathcal{N}_2)\end{array}\right]$ $(k=1,2,\ldots,\ell-1)$
- $\theta_\ell(\mathcal{N}_1 + \mathcal{N}_2) = \frac{1}{2} \lambda$


$\lambda$ はたぶん適当な実数パラメータだと思う.
何の説明も無いけど.

要するに、
$\mathcal{N}_1$ と $\mathcal{N}_2$
という2つの計算があるから、その計算過程をそれぞれ並べて計算するような MLP を構成することができる.
当然2つの出力があるので、それを1つにまとめるような一層を、最後に加えている.
$\lambda$ はその２つの結果のまとめ方に関するパラメータである.
(だからって何でこうなってるのか分からない. もっといい方法が在るだろう.)

#### MLP 一般和 (Multi-Sum Net)

2つのMLPの和を定義したから次は一般に $J$ 個のMLP

$$\mathcal{N}_1, \mathcal{N}_2, \ldots, \mathcal{N}_J$$

の和
$$\sum_j \mathcal{N}_j$$
を定義する.
まあ大体上と同じなので大体省略するけど、違いは

- $\theta_\ell(\sum_j \mathcal{N}_j) = \frac{1}{J} \lambda$

くらい.
うーん、
$\theta_k$ は掛け算するわけじゃないのにこれ何の意味があるんだろう.

### MLP 差 (Difference Net)

$$\mathcal{N}_1 - \mathcal{N}_2 = \mathcal{N}_1 + \mathcal{N}_2^c$$

### MLP 内積 (I-Product)

$b_\ell(\mathcal{N}_1) = b_\ell(\mathcal{N}_2) = \mathbb{R}$
であるような2つの $\ell$ 層 MLP
$\mathcal{N}_1, \mathcal{N}_2$
の積 (内積)

$$\mathcal{N}_1 \times \mathcal{N}_2$$

を $\ell+1$ 層 MLP として定義する.

- $b_k(\mathcal{N}_1 \times \mathcal{N}_2) = b_k(\mathcal{N}_1) \otimes b_k(\mathcal{N}_2)$ $(k=1,2,\ldots,\ell)$
- $b_{\ell+1}(\mathcal{N}_1 \times \mathcal{N}_2) = \mathbb{R}$
- $\omega_k(\mathcal{N}_1 \times \mathcal{N}_2) = \left[\begin{array}\\\omega_k(\mathcal{N}_1)&\\&\omega_k(\mathcal{N}_2)\end{array}\right]$ $(k=1,2,\ldots,\ell-1)$
- $\omega_\ell(\mathcal{N}_1 \times \mathcal{N}_2) = \left[\begin{array}\\\lambda&\lambda\end{array}\right]$
- $\theta_k(\mathcal{N}_1 \times \mathcal{N}_2) = \left[\begin{array}\theta_k(\mathcal{N}_1)\\\theta_k(\mathcal{N}_2)\end{array}\right]$ $(k=1,2,\ldots,\ell-1)$
- $\theta_\ell(\mathcal{N}_1 \times \mathcal{N}_2) = \frac{3}{2} \lambda$

和と違うのは最初の入力からすでに並列になってることくらい.
最後の $\theta_\ell$ は意味不明.

#### MLP 一般内積

$$\prod_j \mathcal{N}_j$$

## 特性 MLP (Characteric MLP)

あるデータ集合

$$\mathcal{X} \subset \mathbb{R}^m$$

からの有限のサンプリング (データセット)

$$D \subset \mathcal{X}$$

があるとする.
$\mathcal{X}$ に関する特性関数とは、データ点 $x$ が $\mathcal{X}$ に属するかどうかで
$1, 0$ を出力する関数であるが、
これに相当する、特性関数ならぬ **特性MLP** を $D$ から構成することを考える.
実際には $\sigma$ で活性化してるので厳密に $1, 0$ が出力されることはないが、
話を簡単にするために、厳密にそういう出力されるものを考える.
また $D$ しか与えられないのでそから $\mathcal{X}$ を推定する必要がある.
これらの事情から次の2つを要請する.

1. $D$ の任意の要素 $x$ に対して $1$ を出力する
1. $D$ の任意の点とも (ユークリッド距離で) $\epsilon$ だけ離れてる点 $x$ に対して $0$ を出力する

特にこの2つ目であるが、$D$ から $\mathcal{X}$ を推測するために、
ある程度小さい正の数 $\epsilon$ だけ、どの $D$ の要素とも離れていれば、
$\mathcal{X}$ には属さないと仮定したネガティブサンプリングを行っている.
すなわち、
$D$ に対して $\epsilon$ 近傍を ($D_\epsilon$) の補集合
$D_\epsilon^c$
からサンプリングを行う.

改めて書くと、
点集合 $D$ の特性 MLP $\mathcal{K}_D$ とは、

1. $\mathcal{K}_D(D) = 1$
1. $\mathcal{K}_D(D_\epsilon^c) = 0$

を近似的に満たすものと定める.

### 特性 MLP の性質

正解率は全部、任意のあるデータセット (固定) について測るものとして添字を省略する (だよね?).

- $\mathcal{A}(\mathcal{K}_D^c) = \mathcal{A}(\mathcal{K}_{D^c})$
    - $\mathcal{K}_D^c = (\mathcal{K}_D)^c$ だよね、普通に考えて.
    - $D^c = \mathbb{R}^n \setminus D_\epsilon$ だと思う.
- $\mathcal{A}(\mathcal{K}_{D_1 \cup D_2}) = \mathcal{A}(\mathcal{K}_{D_1} + \mathcal{K}_{D_2})$
- $\mathcal{A}(\mathcal{K}_{D_1 \times D_2}) = \mathcal{A}(\mathcal{K}_{D_1} \times \mathcal{K}_{D_2})$

## MLP 操作の諸定義 (part 2)

詳細は略すが他にも次のような操作を定めている.

1. 分解 (Component Net)
    - 最後の次元 $n_\ell$ が $>1$ の場合にその第 $i$ 成分だけ取り出すネットワークに分解できる
    - というのも今までほとんど $n_\ell=1$ の場合しか扱ってなかったので
1. 外積 (O-Product)
    - 逆に、合成するもの


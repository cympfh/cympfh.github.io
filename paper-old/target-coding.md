% Deep Representation Learning with Target Coding
% http://personal.ie.cuhk.edu.hk/~ccloy/files/aaai_2015_target_coding.pdf
% 深層学習

> この引用の形になって書かれてる文は私の感想です.
> それ以外は論文に書かれている内容です.
> 特に図表は論文からの引用です.

## 概要

ラベルの符号化 (Target Coding) の重要性

![](https://i.imgur.com/vTLv5is.png)

果たして 1-of-K coding が最良の方法だろうか.

## 準備

### Target Coding

Target Coding を定義する.

シンボル (有限) 集合 $T$ を用意する.
典型的には binary alphabet set $T=\{0,1\}$ がある.

ラベルの数に相当する $n$ と一つの code の長さに相当する $\ell$ について
$$S \in T^{n \times \ell}$$
なる行列 $S$ を code と呼ぶ.
$S$ の各行を codeword という.
つまり $S$ は $n$ 個の codeword を含んでいて、各 codeword は長さ $\ell$ の $T$ の列である.

<!--
code $S$ に対してシンボルの行/列ごとの出現数を $A, B$ として持っておく.
すなわち、

- $A = \{\alpha_i\}_{i=1}^n$
    - $\alpha_{i,k}$ は $S_{i \cdot}$ に $T_k$ ($k$ 個目のシンボル) が出現する回数
- $B = \{\beta_j\}_{j=1}^\ell$
    - $\beta_{j,k}$ は $S_{\cdot j}$ に $T_k$ が出現する回数

-->

#### 1-of-K coding

ラベルの数が $K$ のとき、

- $T=\{0,1\}$
- $S \in T^{K \times K}$ ($n=\ell=K$)
    - $S_{ij} = \delta_{i,j}$ (単位行列)

なる code を 1-of-K coding という.

#### Hadamard code

アダマール行列を code として用いる.
アダマール行列とは次のようなもの.

$$H^2 = \left[
\begin{array}{cc}
+ & + \\
+ & - \\
\end{array}
\right]$$
$$\begin{align*}
H^4 & = H^2 \otimes H^2 \\
& = \left[
\begin{array}{cccc}
+ & + & + & + \\
+ & - & + & - \\
+ & + & - & - \\
+ & - & - & + \\
\end{array}
\right]
\end{align*}
$$
$$H^{2m} = H^m \otimes H^2$$

として $H^m \in \{+,-\}^{m\times m}$ が定義される. ただし $m$ は2の累乗.
ここで $+,-$ は $+1,-1$ のこと.
$\otimes$ とは要素ごとの積 (Kronecker product, tensor product).

$H^m$ から次の手順で code にする

1. 1行目と1列目 (全部 $+$) を消して $\{+,-\}^{m-1 \times m-1}$ にする
1. 要素の $+,-$ それぞれを $0,1$ に写す $(+ \mapsto 0, - \mapsto 1)$
1. $K$ 行を選んで $\{0,1\}^{K \times m-1}$ にする $(K \leq m-1)$
    - 選び方? (後述)

以上で code $\{0,1\}^{K \times m-1}$ を手に入れる.
従って codeword の長さはいつも2の累乗から1引いた数になる (e.g. 127, 255).

> ところではじめの $H^2$ を単位行列に取り替えれば同じ作り方で 1-of-K が作れるな

##### アダマール行列の性質

1. **Uniformness** どの行/列にも $1 \in T$ が $m/2$ 個以上含まれる
1. どの codeword 同士を比較しても、ハミング距離が全て等しく $m/2$

##### $K$ 行の選び方

$T^{m-1 \times m-1}$ から $K$ 行を選ぶ必要がある.
この指標として、各列について $1$ を含む割合が uniform であることがある.
思想的にはラベルの数のちょうど半分 ($K/2$) 個だけが、各列に $1$ があるのが理想.
その方法として貪欲法で行を取ってく方法と、単にランダムに選ぶ方法を試している.

![](https://i.imgur.com/YJjhjzj.png)

貪欲でもこのくらいは大体理想状態にできる.

## 実験

### 特徴ベクトル

CIFAR-100 のうちから特に似てる
tigar, lion, leopard
の3クラスについて CNN (Figure 3) で分類学習を行う.
CNN の最後の4層 (全結合してる) それぞれでのベクトルをプロットして獲得した表現を調べる.

![](https://i.imgur.com/IoeeTVc.png)

HC-127 は codeword の長さが 127 の Hadamard code.
-255 は長さが 255 のそれ.

> 最後手前まではどれも変わらない.
> HC-127 はこれは改良になってるのかよくわからんな.
> HC-255 までくると良くなってそうだけど、HC の良さなのか codeword の長さの良さなのかわからん.
> 1-of-K の codeword は長さ $K=3$ なわけだし.
> とは言え良くなる気持ちはわかる. ラベルが完全に排他的ではなく、lion or leopard というラベルが新しく着けられるわけだから.

### $K$ 行の選び方

貪欲法とランダムを比較したが、分類性能ではわずかに貪欲法のが良かった.

> 本当に僅かだったので、どうでもいいっぽい.
> となるとますます HC の良さが分からなくなるな.
> 例えば列方向に冗長性をもたせた 1-of-K でいいのでは？

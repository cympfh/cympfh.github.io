% [1605.06955] Semi-Supervised Classification Based on Classification from Positive and Unlabeled Data
% https://arxiv.org/abs/1605.06955
% 分類器 半教師アリ学習

## リンク

1. [[1605.06955] Semi-Supervised Classification Based on Classification from Positive and Unlabeled Data](https://arxiv.org/abs/1605.06955)
2. [夏のトップカンファレンス論文読み会 (9/18, 2017): Semi-Supervised Classification Based …](https://www.slideshare.net/tomoya-sakai/20170918-sakai)

## 概要

半教師アリ学習をする.
典型的な PU 学習 (Positive and Unlabeled classification learning) は、ラベル無しデータについて何かしら分布に仮定がないと解けない.
提案手法はラベル無しデータに分布を仮定しない半教師アリ学習を解く.

## Background

まず典型的な PN, PU, NU 学習を確認する.

### Notation

$y \in \{+1,-1\}$ に対して、Positive, Negative, Unlabeled データは

- $\mathcal{X}_P = \{x^P_i \in \mathcal{X} \}_i \sim p_P(x) = p(x | y=+1)$
- $\mathcal{X}_N = \{x^N_i \in \mathcal{X} \}_i \sim p_N(x) = p(x | y=-1)$
- $\mathcal{X}_U = \{x^U_i \in \mathcal{X} \}_i \sim p(x) = \theta_P p_P(x) + \theta_N p_N(x)$
    - $\theta_P = p(y=+1), \theta_N = p(y=-1)$
    - $\theta_P + \theta_N = 1$

予測器として実関数 $g: \mathcal{X} \to \mathbb{R}$ とその上の損失関数 $\ell: \mathbb{R} \to \mathbb{R}$ を定める.
ここで $\ell(m)$ は $m=1$ の時に最小を撮るような関数だとする.
予測値が負である場合は $\ell(-m)$ と使うことにする (つまり $\ell(y,g(x))=\ell(yg(x))$ としている).
これを考慮して risk 関数を次のように定義する.

- $R_P(g) = \mathbb{E}_P \left[ \ell(g(x)) \right]$
- $R_N(g) = \mathbb{E}_N \left[ \ell(-g(x)) \right]$
- $R_{U,P}(g) = \mathbb{E}_U \left[ \ell(g(x)) \right]$
- $R_{U,N}(g) = \mathbb{E}_U \left[ \ell(-g(x)) \right]$

### PN 学習

Positive と Negative だけで学習するもので、普通の教師アリ学習のこと.
目標は risk を最小化する $g$ を見つけること.
全体のrisk を次のように、データの分布に従って足す.
$$R_{PN}(g) = \theta_P R_P(g) + \theta_N R_N(g) \tag{1}$$
ちなみに、もし $\ell(m)$ としてヒンジ関数 $\max(0,1-m)$ を採用すると、これはSVMになる.

### PU 学習

Positive と Unlabeled とだけがある場合の学習.
[du Plessis らによる方法](http://www.ms.k.u-tokyo.ac.jp/2014/NIPS2014b.pdf)
では、$p_N(x)$ が出現しないように PN risk を設計して、これを使う.

Unlabeled を Negative であると分類することを考える.
このときの risk は、確かに Negative を Negative であると正しく分類する場合と、
Positive を Negative であると誤る場合とがあるとして、
$$\mathbb{E}_U \left[ \ell(-g(x)) \right]
= \theta_P \mathbb{E}_P \left[ \ell(-g(x)) \right]
+ \theta_N \mathbb{E}_N \left[ \ell(-g(x)) \right]$$
だとする.
これを "negative sample" だと表現しているが、その意味はよくわからない.
元論文読まないとね.

これを式 (1) に代入して
$$R_{PU}(g)
= \theta_P \mathbb{E}_P \left[ \ell(g(x) - \ell(-g(x)) \right]
+ \mathbb{E}_U \left[ \ell(-g(x)) \right]$$
ここで
$\tilde{\ell}(m) = \ell(m) - \ell(-m)$,
$R^C_P(g) = \mathbb{E}_P\left[\tilde{\ell}(g(x))\right]$
と置いて式を簡単にすると
$$R_{PU}(g) = \theta_P R^C_P(g) + R_{U,N}(g) \tag{2}$$

#### Non-Convex Approach

損失関数が $\ell(m) + \ell(-m)=1$ を満たすとすると、
$\tilde{\ell}(m) = 2 \ell(m) - 1$.
これを式 (2) に入れると、
$$R_{PU}'(g) = \theta_P (2 R_P(g) - 1) + R_{U,N}(g)$$
$P:U$ のデータが $2\theta_P:1$ の重みで扱われていることが分かる.

先の条件を満たすような損失関数としてランプ関数
$$\ell(m) = \frac{1}{2} \max(0, \min(2, 1-m))$$
がある.

```@gnuplot
set grid
set xrange [-2:2]
set yrange [-0.2:1.2]
min(x, y) = x < y ? x : y
max(x, y) = x > y ? x : y
ramp(m) = max(0, min(2, 1-m))/2
plot ramp(x)
```

#### Convex Approach

今度は損失関数が
$\ell(m)-\ell(-m)=-m$
を満たすとする.
つまり
$\tilde{\ell}(m) = -m$
だとすると、
$$R_{PU}''(g) = \theta_P \mathbb{E}_P \left[ -g(x) \right] + R_{U,N}(g)$$
を得る.

簡単のために
$R^L_P(g) = \mathbb{E}_P \left[ -g(x) \right]$
と置くことで
(これは $\ell(m) = -m$ なる損失関数を用いた場合の risk)
$$R_{PU}''(g) = \theta_P R^L_P(g) + R_{U,N}(g)$$
とする.

### NU 学習

PU 学習の対称版だから、対称的に
$$R_{NU}(g) = \theta_N R^C_N(g) + R_{U,P}(g) \tag{2}$$
を得る.
またnon-convex, convex 版として
$$R_{NU}'(g) = \theta_P (2 R_N(g) - 1) + R_{U,P}(g)$$
$$R_{NU}''(g) = \theta_N R^L_N(g) + R_{U,P}(g)$$

## 提案される半教師アリ学習

Positive, Negative, Unlabeled データがそれぞれ与えられた場合の半教師アリ学習として、
PN, PU, NU を組み合わせた
**PUNU 学習**
と
**PNU 学習**
という2つを提案する.

### PUNU 学習

PU と NU を組み合わせたもので、
$0 \leq \gamma \leq 1$
について
$$R^\gamma_{PUNU}(g) = (1-\gamma) R_{PU}(g) + \gamma R_{NU}(g)$$
とするもの.

non-convex 版を考えると、
$$R^\gamma_{PUNU}(g) =
2(1-\gamma)\theta_P R_P(g)
+ 2\gamma\theta_N R_N(g)
+ \mathbb{E}_U \left[ (1-\gamma) \ell(-g(x)) + \gamma \ell(g(x)) \right]
- (1-\gamma) \theta_P
- \gamma \theta_N$$

$\gamma=1/2$ とすると、
$\left[ (1-\gamma) \ell(-g(x)) + \gamma \ell(g(x)) \right]$
はちょうど $\left(\ell(g(x)) + \ell(-g(x))\right)/2$ で、仮定から定数.
他の定数部分も無視すれば (最適化問題なので)
$$R^\gamma_{PUNU}(g) = \theta_P R_P(g) + \theta_N R_N(g) + \mathrm{Const}$$
これは結局、 PN 学習と一致する.

同様に convex 版を考える.
$$R^\gamma_{PUNU}(g) =
(1-\gamma) \theta_P R^L_P(g) + \gamma \theta_N R^L_N(g)
+ \mathbb{E}_U \left[ (1-\gamma) \ell(g(x)) + \gamma \ell(-g(x)) \right]$$

です。
例えば $\gamma < 1/2$ とすると、PU の方の risk をより優先するので Negative に分類され易くなる.

### PNU 学習

別な方法として PN と PU (または NU) を組み合わせることが考えられる.
すなわち、

- $R_{PNPU}(g) = (1-\gamma) R_{PN}(g) + \gamma R_{PU}(g)$
- $R_{PNNU}(g) = (1-\gamma) R_{PN}(g) + \gamma R_{NU}(g)$

ということ.
実用的にはこの2つをさらに組み合わせる (それを PNU と呼んでいる).

$$R^\eta_{PNU}(g) = \begin{cases}
R^\eta_{PNPU}(g) & \eta \geq 0 \\
R^\eta_{PNNU}(g) & \eta < 0
\end{cases}$$

ここで $\eta$ はまた新しいパラメータで、
$-1 \leq \eta \le 1$
の範囲で取り得るものとする.

例えば

- $R^1_{PNU}(g)=R_{PU}(g)$
- $R^0_{PNU}(g)=R_{PN}(g)$
- $R^{-1}_{PNU}(g)=R_{NU}(g)$

## 解析

まだ読んでない

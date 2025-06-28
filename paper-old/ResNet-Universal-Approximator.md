% [1806.10909] ResNet with one-neuron hidden layers is a Universal Approximator
% https://arxiv.org/abs/1806.10909
% 深層学習

## 概要

ResNet の残渣を求めるところは、隠れ層にノードがただ1個さえあれば (下図)、活性化関数に relu を使うことで、
任意のルベーグ積分可能関数 ($\ell_1(\mathbb R^d)$) を近似 (uniformly approximate) できる.

<figure>
<img src="https://i.imgur.com/6NbUuVi.png" />
<caption>論文より引用</caption></figure>

> ただし彼らの言う ResNet とは Figure.1 で示されるブロックを縦に積んだものに限っていて、
> 例えば畳み込み層などは気にしていない.

## 万能関数近似性

よく知られたものは、3層 (隠れ層がただ1つのもの) のニューラルネットワークで、
隠れ層に十分ノードがあれば (fat であれば)、あるクラスの関数を近似できるという定理だった.

一方で深い (tall) ニューラルネットワークについては、この性質についての解析がまだなされていなかったが、
この論文は ResNet がその性質を持つことを示した.

浅いNNではその必要となるノード数が精度に対して指数的に必要になるのに対して、
深さを優先したNNでは必要となるノード数は多項式かせいぜい線形にしか増えないという利点がある.

> だからこそ、経験的に、より深いNNを採用してきたわけだが

### 定理

任意のルベーグ積分可能関数 $f: \mathbb{R}^d \to \mathbb R$ と
任意の正数 $\epsilon > 0$ に対して、
ある ResNet $R$ が存在して
$$\int_{\mathbb R^d} \left| f(x) - R(x) \right| dx \leq \epsilon$$
とできる.

## ResNet の構成

彼らの構成するResNetはFigure1に示したようなブロック (residual block) を縦に積み重ねる.
一つのブロックは次のように定式化される:
$$T : \mathbb R^d \to \mathbb R^d$$
$$T(x; V,U,u) = V ~ \mathrm{relu}(Ux+u)$$
ただし、 $V \in \mathbb R^{d \times 1}$, $U \in \mathbb R^{1 \times d}$, $u \in \mathbb R$.
$\mathrm{relu}$ は $x \mapsto \max \{0,x \}$ なる関数.

各々がパラメータを伴った関数 $N$ 個のブロック $T_0, T_1, \ldots, T_N$ を用いて、
ResNet 全体は次のようなものとして定める.
$$R(x) = L \circ (1 + T_N) \circ \cdots (1 + T_2) \circ \cdots (1 + T_1)$$
ただし $1$ は恒等写像.
また最後の $L$ は $\mathbb R^d \to \mathbb R$ なる線形関数.

(Figure.2 は、普通のNNが、1層あたりのノードを増やさない限りいくら深くしても表現力を増さないことを示している.)

## 証明の概要 (理解する自信ない)

まず用いる事実として次の定理がある.

<div class=thm>
ルベーグ積分可能な関数のクラス $\ell_1(\mathbb R^d)$ は、
piecewise constant function (区分的定数関数?) で稠密である.
</div>

簡単のために (理解できないので) $d=1$ の場合に限って読む.

piecewise constant function とは、
有限個の点 $a_0 < a_1 < \cdots < a_M$ と、それぞれに対応する実数 $h_i$ を以て
$$h(x) = \sum_{i=1}^M h_i 1[a_{i-1} \leq x < a_i]$$
で表現される関数 $h$ のこと.
ただしここで $1[P(x)]$ は $P(x)$ が成立するときだけ $1$ を取るようなインディケータ.

> いわゆる [階段関数](https://en.wikipedia.org/wiki/Step_function) のことか.
> ただし台は有界.

これで稠密だというので、近似したい関数は piecewise constant function によっていくらでも近似できる.
そしてその piecewise constant function を ResNet によって近似できることを示す.

ただし piecewise constant function は有限箇所 $(x=a_i)$ で値が飛ぶような不連続であるが、
trapezoid (台形のこと) に変形することで、少しだけ連続に変形させたものを使う.

> いかにも relu が役立ちそうな形だ

![](https://i.imgur.com/YNZPqoa.png)

この幅 $\delta$ の極限を取ることで、もとの piecewise constant function を得る.

1. ResNet で trapezoid function を近似
1. $\delta \to 0$
1. piecewise constant function を近似
1. もとの関数を近似

という流れ.

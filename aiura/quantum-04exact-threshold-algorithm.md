% EXACT, THRESHOLD アルゴリズム
% 2019-09-08 (Sun.)
% 量子計算

$$\newcommand{\ket}[1]{\left|#1\right\rangle}
\newcommand{\true}{\mathrm{true}}
\newcommand{\false}{\mathrm{false}}
\newcommand{\exact}{\mathrm{EXACT}}
\newcommand{\threshold}{\mathrm{THRESHOLD}}
\newcommand{\concat}{+\!\!\!+}$$

## 紹介する論文

- "Exact quantum query complexity of EXACT and THRESHOLD"
 - Andris Ambainis, Jānis Iraids, Juris Smotrovs
- [arxiv.org/abs/1302.1235](https://arxiv.org/abs/1302.1235)

与えられた $n$ bit (qbit ではない) について立ってる ($1$ である) ビットの数を数えるアルゴリズム.
正確に述べると,
立ってるビットの数がちょうど $k$ であるか判定する $\exact^n_k$ と,
$k$ 以上であるか判定する $\threshold^n_k$ の2つのアルゴリズムを与える.

> もちろん量子計算を用いない古典コンピュータなら全てのビットをチェックする必要がある.

## notation

$n$ qbit の基底の内, $i$ 番目 ($0$-indexed) の qbit だけが立ってるもの
$\ket{0\cdots 0 1 0 \cdots 0}$
を
$$\ket{i}$$
と書くことにする ($i=0,1,\ldots,n-1$).

2つの $n$ qbit $\ket{i}$ と $\ket{j}$ とを並べたものを
$$\ket{i, j} := \ket{i} \otimes \ket{j}$$
と書く.

更にそれが $2n$ qbit であることが紛らわしく無ければ,
$$\ket{i} := \ket{i, i}$$
と書く.

> **補足**: 実際には, 中身の表現はどうでもよくて, 要するに区別できる状態であればよい.
> つまり $\ket{\cdot}$ の中に書く数字は単なるラベルだとしか思ってない.

1 qbit $\ket{x}$ ($x=0,1$) に対して
$(-1)^x$ を $\hat{x}$ と書く ($\hat{x}=1,-1$).

## Query (量子クエリ)

これから EXACT と THRESHOLD という2つのアルゴリズムを説明するが,
共に $Q$ という操作が登場する.
これは入力 $x_1, x_2,\ldots , x_n$ に依存する写像であって,

- $Q \ket{i} = \hat{x}_i \ket{i}$

で定めるものである.
このように入力に依存する操作をクエリと呼ぶ.

1回のクエリの処理 ($Q$ の適用) のたびに, 入力 $x_i$ を一回読む必要がある.
アルゴリズムの複雑性として, クエリを処理する回数を指標とする.
これを量子クエリ計算量という.

## EXACT

$n$ qbit
$$x=(x_0 x_1 \cdots x_{n-1})$$
の内, ちょうど $k$ 個が立ってるか判定するアルゴリズムを
$\exact^n_k$
とする.

$$\exact^n_k : \{0,1\}^n \to \{\true, \false\}$$

今から述べる彼らのアルゴリズムでは $2n$ qbit を用意する.
取り得る状態は
$\ket{i}$ と $\ket{i,j}$ $(0 \leq i,j \lt n; i \lt j)$
の $n(n+1)/2$ 個だけとし, 初め $\ket{0}$ であるとする.
従って, 長さ $n(n+1)/2$ の複素ベクトルで状態は表現される.

さていきなり一般の $\exact^n_k$ を考えるのは難しいので,
まずは $\exact^{2k}_k$ の場合を考える.

### $\exact^{2k}_k$

全体が偶数ビットで, 内のちょうど半分のビットが立ってるかを判定する.
このことは,
ビットそれぞれを $x \mapsto \hat{x}$ としたときのその和 $\sum_i \hat{x}_i$ がゼロになることと等しいことを利用する.
$$\exact^{2k}_k(x) = \true \iff \sum_i \hat{x}_i = 0$$

次の3つの操作を用いる:

1. $U_1 \ket{0} = \frac{1}{\sqrt{2k}} \sum_{i=0}^{2k-1} \ket{i}$
1. クエリ $Q$
1. $U_2 \ket{i} = \frac{1}{\sqrt{2k}} \left( \sum_{i \lt j} \ket{i,j} - \sum_{i \gt j} \ket{j,i} + \ket{0} \right)$

ここで未定義な値 (e.g. $U_1\ket{1}$) はどう定義してもいいので $U_1, U_2$ をユニタリー行列になるようにする.

$\ket{0}$ にこれらを順に通す:

1. 初期状態
    - $\ket{0}$
1. $U_1$
    - $\frac{1}{\sqrt{2k}} \sum_{i=0}^{2k-1} \ket{i}$
1. $Q$
    - $\frac{1}{\sqrt{2k}} \sum_{i=0}^{2k-1} \hat{x}_i \ket{i}$
1. $U_2$
    - $\frac{1}{2k} \left( (\hat{x}_i - \hat{x}_j) \ket{i,j} + \sum_{i=0}^{2k-1} \hat{x}_i \ket{0} \right)$

で, 最後の量子を観測したときに得られうる状態は

1. $\ket{i,j}$ (ただし $i \lt j$ )
1. $\ket{0}$

の2種類がある.

もし $\ket{0}$ を観測したならば, $\sum_i \hat{x}_i$ がゼロでないことがわかる.
なぜなら, $\ket{0}$ を観測する確率は $(\frac{1}{2k}\sum\hat{x}_i)^2)$ であるから.
従って,
$$\exact^{2k}_k(x) = \false$$
であることがわかる.

次に $\ket{i,j}$ を観測したときを考えると,
この係数について
$\hat{x}_i - \hat{x}_j \ne 0$
であることがわかる.
即ち, ビット $x_i$ とビット $x_j$ とが異なることを示してる.
今, $\exact^{2k}_k$ はビットが立っているものの数と立っていないものの数が **等しい** かどうかにだけ興味があるので, 次が言える.

$$\exact^{2k}_{k}(\{ x_0, x_1, \ldots , x_{n-1} \}) =
\exact^{2k-2}_{k-1}(\{ x_0, x_1, \ldots , x_{n-1}\} \setminus \{x_i, x_j\}).$$
(ビットの列を集合に書き換えているので註意.)

このことはビットに関する帰納法を示唆している.
その基底状態として,
$$\exact^0_0~\{\} = \true$$
がある.

帰納部分は, ($\false$ であれば) 運が良ければさっさと終わるが, 最悪 ($\true$ なら必ずそうで) $\frac{2k}{2}$ 回繰り返す必要がある.

### $\exact^n_k$

入力 $x = (x_0 \cdots x_{n-1})$ に余計にビットを付け足せば $\exact^{2k}_k$ に出来る.
具体的に, $\exact^n_k(x)$ は次に等しい:

- case $n = 2k$
    - $\exact^{2k}_k(x)$
- case $n \gt 2k$
    - $\exact^{2n-2k}_{n-k}(x \concat (1 \ldots 1))$
    - $n-2k$ 個の 1 bit 列を連結
- case $n \lt 2k$
    - $\exact^{2k}_{k}(x \concat (0 \ldots 0))$
    - $2k-n$ 個の 0 bit 列を連結

### クエリ計算量

$\exact^{2k}_k$ のクエリ計算量は, 再帰の回数なので, 最悪 $k$.
したがって, $\exact^{n}_k$ のクエリ計算量は, 最悪

$$\max\{k, n-k\}$$

となる.

## THRESHOLD

$n$ bit
$$x = (x_0 x_1 \cdots x_{n-1})$$
の内, $k$ 個 **以上** が立ってるか判定するアルゴリズムを
$$\threshold^n_k \colon \{0,1\}^n \to \{\true, \false\}$$
とする.

### $\threshold^{2k+1}_{k+1}$

まず初めに
$\threshold^{2k+1}_{k+1}$
を考える.
これは即ち過半数ビットが立ってるかを判定する手続きである.

入力は $x_0, x_1, \ldots , x_{2k}$ の $2k+1$ ビット.
これに関して

- $S_0 = \{ i \mid 0 \leq i \lt 2k+1, x_i = 0 \}$
- $S_1 = \{ i \mid 0 \leq i \lt 2k+1, x_i = 1 \}$

とする.
それぞれのサイズ (要素数) を $\#S_0, \#S_1$ と書くことにして,
全体は奇数ビットなので, 必ず $\#S_0 \ne \#S_1$.
今 $\#S_0 \gt \#S_1$ とする.
逆の場合も同様であるので省略する.

次のことが言える:

- when $i \in S_0$,
    - when $\#S_0 = \#S_1 + 1$
        - $\sum_{j \ne i} \hat{x}_j = 0$
    - when $\#S_0 \gt \#S_1 + 1$
         - $\threshold^{2k+1}_{k+1}(x) = \threshold^{2k-1}_{k-1}(x \setminus \{x_i, x_j\})$ ($\forall j \ne i$)
 - when $i \in S_1$
     - $\threshold^{2k+1}_{k+1}(x) = \threshold^{2k-1}_{k-1}(x \setminus \{x_i, x_j\})$ ($\forall j \ne i$)

THRESHOLD では次の3つの操作を用いる:

1. $U_1$
    - $\exact$ のときと同様
1. $Q$
    - $\exact$ のときと同様
1. $U_3$
    - $U_3 \ket{i} = \frac{\sqrt{2k+1}}{2k} \left( \sum_{i \lt j} \ket{i,j} - \sum_{i>j} \ket{j,i} + \frac{1}{2k} \ket{j} \right)$
    - ユニタリ変換になるように

EXACT と同様に $\ket{0}$ から初めてこれらに順に通す.

- 初期状態
    - $\ket{0}$
- $U_1$
    - $\frac{1}{\sqrt{2k}} \sum_{i=0}^{2k-1} \ket{i}$
- $Q$
    - $\frac{1}{\sqrt{2k}} \sum_{i=0}^{2k-1} \hat{x}_i \ket{i}$
- $U_3$
    - $\frac{\sqrt{2k-1}}{2k \sqrt{2k+1}} \sum_{i \lt j} (\hat{x}_i - \hat{x}_j) \ket{i,j} + \frac{1}{2k\sqrt{2k+1}} \sum_{i=0}^{2k} \sum_{i \ne j} \hat{x}_i \ket{j}$

これを測定すると

1. $\ket{i,j}$ または
2. $\ket{j}$

のいずれかを得る.

#### 1. $\ket{i,j}$ を得た時,

$\hat{x}_i - \hat{x}_j \ne 0$
であるから, $x_i \ne x_j$.
従って
$$\threshold^{2k+1}_{k+1}(x) = \threshold^{2k+1}_{k+1}(x \setminus \{x_i, x_j\}).$$

#### 2. $\ket{j}$ を得た時,

$\sum_{i \ne j} \hat{x}_i \ne 0$.
先ほどの性質を思い出せば,
$$\threshold^{2k+1}_{k+1}(x) = \threshold^{2k+1}_{k+1}(x \setminus \{x_i, x_j\}).$$

以上から, ちょうど $k$ 回, 再帰的に $U_1, Q, U_2$ を適用することで

$$\threshold^1_0(x_0) = x_0$$

というわけで
$\threshold^{2k+1}_{k+1}$
はクエリ計算量 $k+1$ で解ける.

### $\threshold^n_k$

一般の場合はやはり EXACT と同様に余分にビットを付け足してやれば結局
$\threshold^{2k+1}_{k+1}$
に帰着でき, クエリ計算量は,
$$\max \{k+1, n-k+1\}.$$

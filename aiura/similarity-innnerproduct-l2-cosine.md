% 近傍探索におけるユークリッド距離, cosine類似度, 内積は互いに変換可能
% 2019-06-01 (Sat.)
% 最適化

$\DeclareMathOperator*{\argmax}{arg\,max}\DeclareMathOperator*{\argmin}{arg\,min}$

## 概要

ユークリッド空間の点同士の類似度を図る指標として,
ユークリッド距離 (L2距離) 以外に cosine 類似度や内積を用いる（用いたい）ことがある.
そして, いくつかの近傍探索手法はユークリッド距離のみを対象にしていたりすることがあるが, 実はこれらの指標は変換可能であるのでユークリッド距離の最小化によって cosine の最大化や内積の最大化を解かせることができる.
この記事ではこの3つの指標の内のどの指標も任意の別の指標に変換可能であることを示す
（最適化問題の帰着）.

## 参考文献

高速な近傍探索ライブラリとして
[faiss](https://github.com/facebookresearch/faiss/)
があるのだが,
この中のいくつかは制約上, L2 距離しか使えない.
そこで FAQ の中で変換する方法として次の論文を参照するよう言及されていた.

- [Speeding Up the Xbox Recommender System Using a Euclidean Transformation for Inner-Product Spaces](http://ulrichpaquet.com/Papers/SpeedUp.pdf)

この記事ではこの論文の Section 3 の定理とその証明を紹介する.
のだが, たぶんだけど, ちょいちょい間違えてるので勝手に訂正していく.

## 準備

### notation

ユークリッド空間の中の点 $x$ に対してその L2 ノルムを $\|x\|$ と書く.
2つの点 $x,y$ の内積を普通の掛け算のように $xy$ と書く.
$$\|x\| = \sqrt{x x}$$

### 近傍探索

ユークリッド空間の中の点の有限集合
$X = \{x_1,x_2,\ldots,x_N\} \subset \mathbb R^m$
と, ある点 $q \in \mathbb R^m$ が与えられたときに,
何かしらの指標で最も $q$ と近い点を $X$ から探してくるものをここでは単に近傍探索と呼ぶことにする.

主要な指標として次の3つがある.
指標によって小さいほうが近いのか大きいほうが近いのかが違うので注意.

#### ユークリッド距離 (L2距離) の最小化 (Nearest Neighbors; NN)
ユークリッド距離
$$\argmin_i \|q - x_i\|$$
またはL2距離
$$\argmin_i \|q - x_i\|^2$$
もちろんノルムは$0$以上なので2乗してもしなくても変わらない.

#### cosine 類似度の最大化 (Maximum Cosine Similarity; MCS)
$$\argmax_i \cos(q,x_i) = \argmax \frac{q x_i}{\|q\| \|x_i\|}$$

ここでは $\cos$ という関数を上の意味で使う.

#### 内積の最大化 (Maximum Inner Product; MIP)
$$\argmax_i q x_i$$

> 世の中で普通「近傍探索」というと1つ目のユークリッド距離 (L2距離) の指標を用いて小さくなるベクトルを探すものを指す.
> また, ここでは $\argmax, \argmin$ としてしまって最大/最小の値を取るベクトルだけを探すことにしているが, トップ $N$ まで取ってくる, としたとしても問題は変わらない（トップ1を見つけたらそれを除外してまたトップ1を探すことをすればいいので）（変わらないというのは解けるか解けないかであって効率の話ではない）.

## 変換方法

### MIP $\to$ NN

ベクトル $q, x_i$ に次のような修正を加える.
これらは頭に一つ余計な成分を付け足している（したがってベクトルの長さが 1 増えている）.

- $\tilde{q} = \left[0, q\right]$
- $\tilde{x_i} = \left[ \sqrt{ \phi^2 - \|x_i\|^2 }, x_i \right]$
    - where $\phi = \max_i \|x_i\|$

これらのL2距離を見ると

$$\begin{align*}
\|\tilde{q} - \tilde{x_i}\|^2
& = (0 - \sqrt{ \phi^2 - \|x_i\|^2 })^2 + \|q - x_i\|^2 \\
& = (\phi^2 - \|x_i\|^2) + (\|q\|^2 + \|x_i\|^2 - 2qx_i) \\
& = \phi^2 + \|q\|^2 - 2qx_i
\end{align*}$$

したがって,
$(\tilde{q}, \{\tilde{x_i} \mid x_i \in X \})$
について NN を解くと, 上の値が最も小さいものが返ってくる.
その中で $\phi$ と $\|q\|$ は変わらないので, 結局 $-2qx_i$ が最小な $i$ が返ってくる.
すなわち内積 $qx_i$ が最大なものが返ってくる.

$$\argmax_i q x_i = \argmin_i \|\tilde{q} - \tilde{x_i}\|$$

とすることで MIP な NN に帰着できた.

### MCS $\to$ NN

全てのベクトルを正規化するとよい.

- $\tilde{q} = \frac{q}{\|q\|}$
- $\tilde{x_i} = \frac{x_i}{\|x_i\|}$

とすれば

$$\begin{align*}
\|\tilde{q} - \tilde{x_i}\|^2
& = \|\tilde{q}\|^2 + \|\tilde{x_i}\|^2 - 2\tilde{q} \tilde{x_i} \\
& = 2 - 2\tilde{q} \tilde{x_i} \\
& = 2 - 2\frac{qx_i}{\|q\| \|x_i\|} \\
& = 2 - 2\cos(q, x_i) \\
\end{align*}$$

となるので $\tilde{q}, \tilde{x_i}$ 間のL2距離の大小が,
$q,x_i$ の cosine 類似度の大小とちょうど逆転している.

というわけで,
$$\argmax_i \cos(q, x_i) = \argmin_i \|\tilde{q} - \tilde{x_i}\|$$
となって MCS が NN に帰着された.

### NN $\to$ MIP

同じノリで頭に一つ値を付け足す方針でやる.
ただし論文の方法だとちょうど大小が逆転すると思うので勝手にマイナスを付けて修正した.

- $\tilde{q} = \left[-1, 2q\right]$
- $\tilde{x_i} = \left[ \|x_i\|^2, x_i \right]$

これらの内積は
$$\begin{align*}
\tilde{q} \tilde{x_i}
& = -\|x_i\|^2 + 2qx_i \\
& = -\|q-x_i\|^2 + \|q\|^2
\end{align*}$$

$\|q\|^2$ は定数なので内積の最大化は L2 距離の最小化になっていて,
$$\argmin_i \|q-x_i\|^2 = \argmax_i \tilde{q} \tilde{x_i}.$$

### MCS $\to$ MIP

これはベクトルを正規化すればよい.
そもそも cosine 類似度とは正規化したベクトルの内積のことだから.

$$\argmax_i \cos(q, x_i) = \argmax_i \frac{q}{\|q\|} \frac{x_i}{\|x_i\|}$$

### MIP $\to$ MCS

MIP $\to$ NN と全く同じ変換で良い!!

- $\tilde{q} = \left[0, q\right]$
- $\tilde{x_i} = \left[ \sqrt{ \phi^2 - \|x_i\|^2 }, x_i \right]$
    - where $\phi = \max_i \|x_i\|$

$$\begin{align*}
\cos(\tilde{q}, \tilde{x_i})
& = \frac{ 0 + q x_i }{\|\tilde{q}\| \|\tilde{x_i}\|} \\
& = \frac{ q x_i }{\|q\| \phi} \\
\end{align*}$$

なので
$$\argmax_i qx_i = \argmax_i \cos(\tilde{q}, \tilde{x_i}).$$

### NN $\to$ MCS

論文の方法は出来てなくない??
しかし NN $\to$ MIP と MIP $\to$ MCS の方法をすでに示したので, 二回変換すればよい.

- $\tilde{q} = \left[0, -1, 2q\right]$
- $\tilde{x_i} = \left[ \sqrt{ \phi^2 - \|x_i\|^2 - \|x_i\|^4 }, \|x_i\|^2, x_i \right]$
    - where $\phi^2 = \max_i \|x_i\|^4 + \|x_i\|^2$

これらの cosine 類似度は

$$\begin{align*}
\cos(\tilde{q}, \tilde{x_i})
& = \frac{ 0 - \|x_i\|^2 + 2qx_i }{\|\tilde{q}\| \|\tilde{x_i}\|} \\
& = \frac{ -\|x_i\|^2 + 2q x_i }{\|\tilde{q}\| \phi } \\
& = \frac{ -\|x_i - q\|^2 + \|q\|^2 }{\|\tilde{q}\| \phi } \\
\end{align*}$$

分母も分子の $\|q\|^2$ も定数なので,
$$\argmin_i \|x_i - q\|^2 = \argmax_i \cos(\tilde{q}, \tilde{x_i})$$


以上で全ての組み合わせの変換方法を示した.

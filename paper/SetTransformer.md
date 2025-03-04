% Set Transformer
% https://arxiv.org/abs/1810.00825
% 深層学習 集合学習

$$
\def\pool{\mathrm{pool}}
\def\net{\mathrm{net}}
\def\Att{\mathrm{Att}}
\def\Multihead{\mathrm{Multihead}}
\def\MAB{\mathop{\mathrm{MAB}}}
\def\SAB{\mathrm{SAB}}
\def\ISAB{\mathrm{ISAB}}
\def\Norm{\mathrm{Norm}}
\def\rFF{\mathrm{rFF}}
\def\PMA{\mathrm{PMA}}
$$

## 概要

入力が集合であるようなニューラルネットを構成したい.
このための方法として set pooling があったが, これに attention つけたら最高になった.

## 集合の学習

事例に対してラベルを学習するような機械を考える.
インスタンスの集合 $\mathcal X$ とラベルの集合 $\mathcal Y$ について通常は
$$\mathcal X \to \mathcal Y$$
を扱うが, 場合によっては入力が事例の集合であることがある.
つまり
$$\mathcal P \mathcal X \to \mathcal Y$$
を考える ($\mathcal P \mathcal X$ は $\mathcal X$ のべき集合).

入力が事例の列なんかの場合, 台集合を取ればこれが適用できる.

集合であるということは次が成り立たなければならない.

1. 順序不変性 (permutation invariant)
    - $\{a,b\}$ と $\{b,a\}$ は同じものである
2. サイズ可変性
    - 入力は一般に $X \in \mathcal P \mathcal X$ (i.e. $X \subset \mathcal X$) であることを要請する
    - $X$ の大きさはどんなであっても良いようにしてほしい

NNs で機械を構成する場合, ややもすれば入力のサイズは固定になり, また RNN などを使えば順序が考慮されてしまう.

## 背景

### Set Pooling

[Zaheer et al., 2017] による方式では集合に対する pooling を行って
$$\{x_1,\ldots,x_n\} \mapsto \rho(\pool \{ \phi(x_1),\ldots, \phi(x_n) \})$$
とする方法.
ここで $\phi$ は embeggin とか Encoder と呼ばれるもの.
また $\pool$ は例えば max や average などなど集合から特徴量を取り出すような操作.
これは順序不変性やサイズ可変性を満たしている.
$\rho \circ \pool$ の部分を合わせて Decoder と呼ぶ.

この論文の手法もこの方式でやる.

### Attention

$n$ 個のクエリがあって各クエリは $d_q$ 次元ベクトルで表現されてるとき, クエリは
$Q \in \mathbb R^{n \times d_q}$
で表現される.
キーバリュー
$(K, V) \in (\mathbb R^{n_v \times d_q}, \mathbb R^{n_v \times d_v})$
なるものを用いて,
このとき attention function (注視関数?) $\Att$ とは次のようなもの:
$$\Att(Q,K,V;\omega) = \omega(QK^T) V$$
$\omega : \mathbb R \to \mathbb R$ は活性化関数でここでは要素ごとに適用することで
$\mathbb R^{n \times n_v} \to \mathbb R^{n \times n_v}$
として使ってる.

#### Multi-head attention

[Vaswani et al., 2017] による拡張.
$h$ 個に増やして結果を結合して使う.
そのために $Q,K,V$ に右からそれぞれ $W_j$ を掛けて違う行列にして, また活性化関数 $\omega_j$ も $h$ 個用意する.
$$\Multihead(Q,K,V; \lambda, \omega) = concat(O_1, \ldots, O_h) W^O$$
ただし

- $\lambda = \{W_j^Q, W_j^K, W_j^V\}_{j=1}^h$
- $O_j = \Att(QW_j^Q, KW_j^K, VW_j^V; \omega_j)$ ($j=1,2,\ldots,h$)

$\lambda$ も学習可能なパラメータであることに注意.
また彼らは $\omega$ として scaled softmax を用いたそう.

型を書いておくと
$$\Multihead \colon \mathbb R^{n \times d_q} \times \mathbb R^{n_v \times d_q} \times \mathbb R^{n_v \times d_v} \to \mathbb R^{n \times d_v}$$

## Set Transformer

Attention ベースで集合を処理する機械 Set Transformer を構成する.
これは Encoder と Decoder の二つの合成として表現される.
まずは必要な部品を定義したあと, Encoder と Decoder をそれぞれ定義する.

### Multihead Attention Block (MAB)

次を定義する:
$$\MAB \colon \mathbb R^{n \times d} \times \mathbb R^{m \times d} \to \mathbb R^{n \times d}$$
$$\begin{align*}
\MAB(X, Y; \lambda) & = \Norm(H + \rFF(H)) \\
\text{ where } H & = \Norm(X + \Multihead(X, Y, Y; \lambda, \omega)
\end{align*}$$

$X, Y$ の行は一つの $d$ 次元ベクトルであって, それが行数分だけある集合を表している.
ここで $\Norm$ は layer normalization で $\rFF$ は行ごとの feed forward.

("Attention is All You Need" の Position-wise Feed-Forward Network を参考にすると
$\rFF$ は relu を入れるだけの二層NNで
$(\max(0, W_1x+b_1)W_2+b_2$
というもの)

### Set Attention Block (SAB)

$X=Y$ としたときの MAB を SAB と定める.
$$\SAB \colon \mathbb R^{n \times d} \to \mathbb R^{n \times d}$$
$$\SAB(X; \lambda) = \MAB(X, X; \lambda)$$

### Induced Set Attention Block (ISAB)

SAB の計算には計算コストがかかり過ぎる.
どこの部分のことか言っていないが, 行列の掛け算の話だと思う.
つまり $\mathbb R^{a \times b}$ と $\mathbb R^{b \times c}$ の掛け算には $O(abc)$ の計算量が係る.
$X \in \mathbb R^{n \times d}$ について $\SAB(X)$ を計算するには $O(n^2d)$ が係る.
論文に書いてあるのは $d$ を定数として無視して単に $O(n^2)$ だと言っている.

この計算量を削減したバージョンを作る.

$$\ISAB \colon \mathbb R^{n \times d} \to \mathbb R^{n \times d}$$
$$\begin{align*}
\ISAB_m(X; \lambda) & = \MAB(X, H) \\
\text{ where } H & = \MAB(I_m, X)
\end{align*}$$
ここで $I_m$ は $\mathbb R^{m \times d}$ であって彼らはこれを inducing point と呼んでいる.
$H$ は $\mathbb R^{m \times d}$ であるので全体の計算コストは $O(mnd)$ になる.
つまり $m$ を適当に小さくすることで計算量を抑えられる.

注意. $I$ 自体も訓練可能なパラメータである.

#### 性質

$S_n$ 上の任意の置換 $\pi$ について
$f(\pi x) = \pi(fx)$ となる $f$ を順序を保つと呼ぶことにする.

$\SAB$ と $\ISAB$ は順序を保つ.

### Encoder

SAB または ISAB を複数縦に重ねたものを Encoder とする.
例えば2つ重ねて
$$\SAB(\SAB(X))$$
$$\ISAB(\ISAB(X))$$
これを Encoder とする.
Encoder は一つの行列を受け取って, それと同じ大きさの行列を返す.

### Decoder

Encoder によって得た $Z \in \mathbb R^{n \times d}$ を受け取って行に関して集約する操作を行う.
集約の操作は Set Pooling を用いる.
つまり行に関して平均を取ったり max を取るなどをして $k$ 種の特徴量をとるとする.
これによって $Z$ から $S \in \mathbb R^{k \times d}$ が得られる.

$$\begin{align*}
Decoder(Z; \lambda) & = \rFF(\SAB(\PMA_k(Z))) \\
\text{ where } \PMA_k(Z) & = \MAB(S, \rFF(Z)) \\
S & \leftarrow \text{ set-pooling } Z
\end{align*}$$

ただし彼らが言うには多くの場合, $k=1$ で十分であり, また $\SAB$ も省いてしまって十分であったらしい.
simple pooling として 平均を取ることをした.

#### Prop 1

Set Transformer は順序不変性を持つ.

#### Prop 2

Set Transformer は順序不変性を持つ関数の万能近似である.

### 実験

データの集合を与えて何かを解くようなタスクを行った.

1. max value regression
    - 実数の集合を与えて $\max$ を学習させる
        - 損失は MAE
    - 当たり前だけど pooling に max を使うのが最強だった
        - `rFF+pooling(max)`
1. counting unique characters
    - Omniglot データベースを用いる
    - 手書き文字画像から20種類の文字を選ぶ
    - ウニークなものが何種類か数えるタスク
    - なんでも解けるけど Set Transformer が良かった
1. 混合分布の最尤推定
    - 点の集合からそれを最尤する $k$ 個のガウス分布のパラメータを推定させる
        - 予測は $k$ 個の $(\mu, \sigma)$
    - 普通にはEMアルゴリズムで解く問題である
    - これで画像分類をさせる (meta-clustering)
        - Synthetic 2D: 二次元データであって $k=4$ つのガウス分布に分けさせる
        - CIFAR-100: VGG で一つの画像を 512 次元ベクトルに落としておく. 4つのクラスだけ選んで使う. $k=4$

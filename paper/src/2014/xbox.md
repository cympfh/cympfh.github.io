% Speeding Up the Xbox Recommender System Using a Euclidean Transformation for Inner-Product Spaces
% https://ulrichpaquet.com/Papers/SpeedUp.pdf
% 近傍探索におけるユークリッド距離, コサイン類似度, 内積は互いに変換可能
% 推薦 近傍探索

$$
\def\N{\mathbb{N}}
\def\Pr{\mathop{\mathrm{Pr}}}
\def\R#1{\mathbb{R}^{#1}}
\def\argmin{\mathop{\rm{argmin}}\limits}\def\argmax{\mathop{\rm{argmax}}\limits}
$$

## INDEX

<div id=toc></div>

## 概要

推薦システムにおいて多くの手法で最後に近傍探索を使う.

よくあるケースは大きな次元のベクトルがあってベクトル同士の内積をスコアとして使いたいから,
スコアが大きくなるアイテム効率よく探索するというものだ.
ただし内積をスコアにすると言ったが, それはユークリッド距離であったりコサイン類似度であったりする.

この論文では実はその３つは全てユークリッド空間における近傍探索に帰着できることを示す.
このことは効率の良い推薦システムを構築するための便利なテクニックとして使える.

最後にこのテクニックを用いて近似的に内積を最大化する点を効率よく探索する手法を示す.

## 記法

ベクトル $x,y$ について, $xy$ と書いたらこれは内積を表す.
$\|x\|$ と書いたらこれはノルム, つまり $\sqrt{xx}$ を表す.
２つのベクトル $x,y$ についてコサイン類似度 $\cos(x,y)$ とは $\frac{xy}{\|x\| \|y\|}$ のことを言う.

## 問題設定

$d$ を次元数とする.
ユーザーのベクトル $x \in \R{d}$ と, $n$ 個のアイテム ($1,2,\ldots,n$) に対応するベクトル $y_i \in \R{d}$ ($y_1,y_2,\ldots,y_n$) がある.
このときに

- 内積 $xy_i$ を最大化する $i$
- ユークリッド距離 $\| x - y_i \|$ を最小化する $i$
- コサイン類似度 $\cos(x,y_i)$ を最大化する $i$

それぞれを見つけたい.

この３つをそれぞれ MIP (Maximum Inner Product), NN (Nearest Neighborhood), MCS (Maximum Cosine Similarity) と呼ぶ.

## 定理: MIP, NN, MCS は同値

以下に示していくようにそれぞれの間で問題を変換出来るので同値.

### 基本方針

予め $x, y_i$ それぞれにある変換を施して $\bar x, \bar y_i$ を構成する.
この変換は単純なものだが, 全ての $y_i$ に適用する必要があるのでここで $O(n)$ 掛かる.
この変換は実は距離を保存する写像になっていて,
$\bar x, \bar y_i$ についてどれかの距離尺度で argmin, argmax を取ると,
$x, y_i$ に関してどれかの距離尺度での argmin, argmax になる, という風に設計している.

### MIP から NN への変換 ($O(n)$)

$O(n)$ の前処理をすることで, MIP を NN へ帰着できる.
すなわち NN が解ければ MIP も解けることを示す.

十分大きな数 $\phi$ を用意する.
例えば $\phi = \max \| y_i \|$ とすればよい.

$x,y_i$ を次のベクトルに変換する.

- $\bar{x} = [0, x]$
    - $x$ の先頭に $0$ を付け足したベクトル ($\in \R{d+1}$)
- $\bar{y}_i = [\sqrt{\phi^2 - \|y_i\|^2}, y_i]$
    - $y_i$ の先頭に $\sqrt{\cdots}$ を付け足したベクトル ($\in \R{d+1}$)

この2つのベクトルについて性質を調べてみる.

- $\| \bar{x} \| = \|x\|$
- $\| \bar{y}_i \| = \sqrt{ (\phi^2 - \|y_i\|^2) + \|y_i\|^2 } = \phi$
- $\bar{x} \bar{y}_i = x y_i$

ではユークリッド距離は

- $\| \bar x - \bar y_i \|^2 = \|\bar x\|^2 + \|\bar y_i\|^2 - 2 \bar x \bar y_i = \|x\|^2 + \| \phi^2 \| - 2 x y_i$
MIP において, この $\|x\|$ と, もちろん $\phi$ は定数であることに注意すると,

- $\argmin_i \| \bar x - \bar y_i \| = \argmax_i ~ x y_i$

が言える.
というわけで, $x, y_i$ についての MIP を解くための手順として,

- 前処理: $\bar x, \bar y_i$ を作る
- $\bar x, \bar y_i$ に関する NN を解く
- その答えを MIP の答えとして終了

というアルゴリズムが手に入った.

### NN から MIP への変換 ($O(n)$)

先程と同じようにベクトルを少し変更する前処理を行う.
論文のやり方では下記 $\bar x$ の正負が逆だがおそらく論文の誤り.

- $\bar x = [-1, 2x]$
- $\bar y_i = [\|y_i\|^2 , y_i]$

内積を取ると,

- $\bar x \bar y_i = - \|y_i\|^2 + 2x y_i = - \| x - y_i \|^2 + \|x\|^2$

やはり $\|x\|^2$ が定数であることに注意すれば,

- $\argmax_i ~ \bar x \bar y_i = \argmin_i \| x - y_i \|$

を得る.

### MIP から MCS への変換 ($O(n)$)

MIP $\to$ NN のときと同じく

- $\bar{x} = [0, x]$
- $\bar{y}_i = [\sqrt{\phi^2 - \|y_i\|^2}, y_i]$

を使う.
内積は $\bar{x} \bar{y}_i = x y_i$ だったので,

- $\cos(\bar x, \bar y_i) = \frac{x y_i}{\|x\| \|y_i\|} = \frac{x y_i}{ \|x\| \phi }$

やはり分母の $\|x\| \phi$ は定数なので

- $\argmax_i \cos(\bar x, \bar y_i) = \argmax_i ~ x y_i$

を得る.

### MCS から MIP への変換

- $\bar x = x$
- $\bar y_i = y_i / \|y_i\|$
    - 正規化したものを使う

とすれば $\bar x \cdot \bar y_i = \cos(\bar x, \bar y_i) \| \bar x \|$ なので,
自明に

- $\argmax_i ~ \bar x \cdot \bar y_i = \argmax_i \cos(x, y_i)$

を得る.

### NN から MCS への変換

論文の方法は意味不明.
しかし NN $\to$ MIP と MIP $\to$ MCS の変換はすでに示しているのでこれを合成すると次が得られる.

- $\bar x = [0, -1, 2x]$
- $\bar y_i = [\sqrt{\phi^2 - \|y_i\|^2 - \|y_i\|^4}, \|y_i\|^2, y_i]$
    - where $\phi^2 = \max_i \|y_i\|^4 + \|y_i\|^2$

これらのコサイン類似度は

- $\cos(\bar x, \bar y_i) = \frac{-\|y_i - x\|^2 + \|x\|^2}{\|\bar x\| \phi}$

というわけで

- $\argmin_i \| x - y_i \| = \argmax_i \cos(\bar x, \bar y_i)$

を得る.

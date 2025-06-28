% Factorization Machines
% https://www.ismll.uni-hildesheim.de/pub/pdfs/Rendle2010FM.pdf
% 線形 SVM と行列分解を組み合わせた予測器
% スパース 推薦 FMs

$$
\def\N{\mathbb{N}}
\def\R{\mathbb{R}}
\def\Normal{\mathcal{N}}
\def\ip#1#2{\langle #1, #2 \rangle}
\def\Pr{\mathop{\mathrm{Pr}}}
$$

## Intro

新しい予測器モデル FM を提案する.
線形 SVM と行列分解を組み合わせて両方の良さを持った形をしている.
データはスパースを前提にしている.

## FM Model

データ $x \in \R^{n}$ について, モデル $\R^{n} \to \R$ を次で定める.

$$w_0 + \ip{w}{x} + \sum_{i \lt j} \ip{v_i}{v_j} x_i x_j$$

ここで

- $w_0 \in \R$
- $w \in \R^n$
- $V \in \R^{n \times k}$
    - $v_i \in \R^k$ は行ベクトル
- $x_i \in \R$ は $x$ の第 $i$ 成分
- $\ip{-}{-}$ は内積

> この形式を 2-way FM と呼ぶ.
> 後で一般化する.

第二項までは通常の線形モデル.
第三項は $x$ の (2-way) interaction を表す.
つまり $i$ と $j$ の相互作用を予測している.
その作用の重さを $\ip{v_i}{v_j}$ で決めている.

> 相互作用の重さを $W \in \R^{n \times n}$ と陽に持ってしまわないのは,
> 単純に空間量が $O(n^2)$ から $O(nk)$ に減らせることと,
> 適切な $k$ を選んで減らしたほうが汎化性能が上がるから.
> このあたりは行列分解を知っていれば当然に思える.


### 使い方

特徴量 $x$ がスパースであることを大前提にしている.
計算コストは値が入っている箇所にしか効かないので,
見た目上でどれだけ次元数が膨大であっても構わない.
どんな特徴量でも横に結合していけばよい.
Fig.1 はこのことを言っている.
例えば User ID を one-hot encoding している.

### 第三項の計算コスト

$\sum_{i \lt j} \ip{v_i}{v_j} x_i x_j$ の計算だが,
これはナイーブに計算すると $O(n^2 k)$ 掛かる.

```python
def naiive(v, x) -> float:
    value = 0.0
    for i in range(n):
        for j in range(i + 1, n):
            value += (v[i, :] @ v[j, :]) * x[i] * x[j]
    return value
```

よく展開して計算すると次が成り立つ.

$$\sum_{i \lt j} \ip{v_i}{v_j} x_i x_j
= \frac{1}{2} \sum_{j=1}^k \left( \ip{v^j}{x}^2 - \ip{(v^j)^{\odot 2}}{x^{\odot 2}} \right)$$

ここで $v^j$ は第 $j$ 列ベクトル.
また $(v^j)^{\odot 2}, x^{\odot 2}$ はそれぞれ要素ごとの二乗.
この計算式で素直に計算すると $O(nk)$ で済む.

```python
def fast(v, x) -> float:
    value = 0.0
    for j in range(k):
        value += (v[:, j] @ x) ** 2
        value -= ((v[:, j] * x) ** 2).sum()
    return value / 2.0
```

### 最適化

素直に SGD するなら次を使う.

- $\frac{\partial}{\partial w_0} \hat{y} = 1$
- $\frac{\partial}{\partial w_i} \hat{y} = x_i$
- $\frac{\partial}{\partial v_{i,k}} \hat{y} = x_i \sum_j v_{j,k} x_j - v_{i,k} x_i^2$

### d-way FM への拡張

相互作用がちょうど2つから成っていたのを $d$ 個に拡張することが考えられる.

$$\hat{y} = w_0 + \langle w, x \rangle + \sum_d \sum_{i_1 \lt i_2 \lt \cdots \lt i_d} \left( \prod_i x_i \right) \langle v_{i_1}, v_{i_2}, \ldots v_{i_d} \rangle$$

ここで
$\langle v_1,v_2,\ldots,v_d \rangle$ は
成分間の積の和で
$\sum_i \sum_k v_{i,k}$
と定める.

## SVM との比較

FMs は線形 SVMs の拡張だと思える.
特に $d=1$ の 1-way FM は線形 SVM そのもの.

さて SVM はカーネルを取り替えてその自由度を上げることができた.
$K(x,z) = (\ip{x}{z} + 1)^2$
という多項式カーネルを使うとこれは相互作用を持つことが出来る.

SVM のモデルをこのカーネルを使って書き下すと次を得る.

$$w_0 + \sqrt{2} \ip{w}{x}
+ \sum_i v_{ii} x_i^2
+ \sqrt{2} \sum_{i \lt j} v_{ij} x_i x_j$$

ここで $w_0, w$ は FM 同様だが $V = (v_{ij})$ という行列が重みとして追加されている.
FM の $V$ を陽に持った場合とよく似た形になっていることが分かる.
$V$ の対角成分をゼロにして適切に行列分解して潰せば同値だ.

## 行列分解との比較

行列分解は次のようなものを考える.
2つの異なるカテゴリ集合 $U,I$ (典型的には Users, Items だ) があって,
$U$ と $I$ の組で決まる値が行列 $X = \R^{U \times I}$ として記述されている.
このとき, この行列成分を予測するモデル $U \times I \to \R$ を
で構築しようというのが行列分解である.

典型的な行列分解はこのモデルを
$X_{ui} = \ip{w_u}{v_i}$
で定める.
ここで行列 $X$ が $(w_u)_u$ と $(v_i)_i$ という2つの行列に分解されている.

FM では次のように考える.

$(u, i) \in U \times I$ に対して, 次のベクトル $x$ を割り当てる.
ここでベクトルの添字は $\mathcal J = U + I$ という直和からなる.

$$
x_j = \begin{cases}
    1 & j = u ~ (u \in U) \\
    1 & j = i ~ (i \in I) \\
    0 & \text{otherwise}
\end{cases}
$$

上記で定まるベクトル $x$ のことを $x^{(ui)}$ と書くことにしよう.
行列分解が $(u, i)$ から $X_{ui}$ を予測することは
FM では $x^{(ui)}$ から $X_{ui}$ を予測することに相当する.

さてこれを FM の式に実際に代入する.
値があるのは $j=u$ と $j=i$ の二箇所だけであるので結局

$$w_0 + w_u + w_i + \ip{v_u}{v_i}$$

バイアス項を無視すればこれは行列分解そのものに他ならない.

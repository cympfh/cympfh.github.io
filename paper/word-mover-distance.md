% From Word Embeddings to Document Distances (Word Mover's Distance; WMD)
% http://proceedings.mlr.press/v37/kusnerb15.pdf
% 距離学習 単語分散表現

## WMD

$n$ 個の単語の各々は word2vec などによって $d$ 次元実ベクトルとして表現されているとする.
単語 $i$ のベクトルを $x^i$ と書く.

ドキュメントを normalized bag-of-words (nBOW) で表現することにする.
すなわち一つのドキュメントは $n$ 次元ベクトル $d$ で表され,
その $i$ 番目の要素は, 単語 $i$ が出現した回数をドキュメントの総単語数で割った数
$$d_i = \frac{c_i}{ \sum_i c_i }$$
で定められる
$(d \in [0,1]_n; \sum_i d_i = 1)$.

### 輸送コスト

ここで単語間の類似度を $x$ を使って計算する.
類似度の代わりに輸送コストという概念を使う.

単語 $i$ と $j$ との間の輸送コストとは
$c^{ij} := \| x^i - x^j \|^2$
であると定めておく.

### 輸送距離

輸送コストを使って, ドキュメント間の距離を定義する.
ドキュメント $d$ から $d'$ への距離を, $d$ の各単語 $d_i$ を $d'$ のどれかの単語 $d'_j$ に流すための総コストだと思うことにする.

$T_{ij}$ は $d$ の中の単語 $i$ から $d'$ の中の単語 $j$ に流す量とする.
従って, 次の制約をもたせる

- $T_{ij} \geq 0$
- $\sum_j T_{ij} = d_i$
- $\sum_i T_{ij} = d'_j$

$i$ から $j$ に $T_{ij}$ だけ流すのに掛かるコストは,
単位あたりのコストをさっきの輸送コスト $c^{ij}$ だとして,
$$\sum_i \sum_j T_{ij} c^{ij}$$
が全体の総コスト.
これを最小化することが, 類似した単語どうしを対応付けることに相当するから,
そのときの総コストをドキュメント間の距離とする.
これを Word Mover's Distance (WMD) という.

$$D(d, d') := \min_T \sum_i \sum_j T_{ij} c^{ij}$$

- such that
    - $T_{ij} \geq 0$
    - $\sum_j T_{ij} = d_i$
    - $\sum_i T_{ij} = d'_j$

## 計算の高速化

ここからは WMD の効率的な計算方法について考える.

### Word Centroid Distance

単語間コストに関する三角不等式を使って WMD の下限を調べる.
アインシュタインの規約を使って $\sum$ は省略する.

$$\begin{align*}
T_{ij} c^{ij}
& = T_{ij} \| x^i - x^j \|^2 \\
& \geq \| T_{ij} (x^i - x^j) \|^2 \\
& = \| T_{ij} x^i - T_{ij} x^j \|^2 \\
& = \| d_i x^i - d_j x^j \|^2 \\
\end{align*}$$

ここで $d_i x^i$ とは結局, ドキュメント $d$ の各単語についてその単語が出現する回数で重みを付けた単語ベクトルの平均を意味する.
$$d_i x^i = \frac{ c_i x^i }{ \sum_i c_i }$$

従って, 最後の値は単語ベクトルの平均同士の L2 距離に他ならない.
これが WMD の一つの下限.

### Relaxed WMD

制約を一つ外す.

$$D(d, d') := \min_T T_{ij} c^{ij}$$

- such that
    - $T_{ij} \geq 0$
    - $\sum_j T_{ij} = d_i$

行き先に関する制約を無くしちゃう.

$d$ の単語 $i$ ごとに貪欲に最適な $j$ を選び $j^*$ と呼ぶことにする:
$$j^* = \mathop{\mathrm{argmin}}_j c^{ij}$$
$i$ からは $j^*$ に全量流すのを $T^*$ とする:
$$T_{ij}^* = \begin{cases}
d_i & \text{ if } j = j^* \\
0   & \text{ otherwise }
\end{cases}$$

これは元の WMD では制約を守っていないが Relaxed バージョンの制約は守っている.
そしてこの $T^*$ で与えられる総コストはまた元の WMD の下限を与えている.


% [2307.08621] Retentive Network: A Successor to Transformer for Large Language Models
% https://arxiv.org/abs/2307.08621
% 深層学習

## 概要

Transformer に代わる Retentive Network (RetNet) を提案する.

## 良さ

- 推論の計算効率
- 訓練の並列性
    - 各時刻に関するデータが並列に扱えること
- 性能
    - 系列データ学習の性能

## Transformer との性能比較

性能面ではモデルサイズ 2.7B 程度を境界に Transformer を超える (Figure 5).

推論時間について.
使用メモリとスループットで常に Transformer より良い (Table 4).
特にシーケンス長に対するスケールに優れてるとされてるので,
実験ではシーケンス長 8192 で実験してる.

予測時間について.
系列の長さに依存せず $O(1)$ で完了する.
これはある時刻において次を予測する計算の話.

そもそも Transformer は長さ $N$ の系列に関して $N^2$ のアテンション行列を作るので,
自乗の計算時間が推論にも予測にも掛かる.
潜在ベクトルが $d$ 次元だとすると $O(N^2d)$.

## Retentive Network (RetNet)

Multi-scale Retention (MSR) module と Feed-forward Network (FFN) module で
RetNet block と呼ぶブロックを構成する.
このブロックを $L$ 個並べたものを RetNet とする.

$d$ 次元長さ $N$ の系列データ

$$X = [x_1, x_2, \ldots, x_N] \in \mathbb R^{N \times d}$$

を扱う.
ここで $d$ は潜在ベクトル (hidden state) の次元数だとして扱う.

一つの RetNet block は系列データを系列データに写す.

$$\mathrm{RetNet block} \colon \mathbb R^{N \times d} \to \mathbb R^{N \times d}$$

RetNet は $L$ 個の RetNet block で逐次実行する.

$$X^0 \in \mathbb R^{N \times d}$$
$$X^{t+1} = \mathrm{RetNet}_t(X^t)$$

### Retention

基本的には Recurrent Network のノリと同じで,
hidden state $s$ を作って, output state $o$ を作る.
その前に入力 $X$ を一次元の系列 $v$ に射影する.

$$X = [x_1, x_2, \ldots, x_N] \in \mathbb R^{N \times d}$$
$$v_n = x_n \cdot w_V ~;~ w_v \in \mathbb R^d, v_n \in \mathbb R$$

この $v$ に関して Recurrent Network のように,

$$s_n = A s_{n-1} + K_n \cdot v_n ~;~ A \in \mathbb R^{d \times d}, K_n \in \mathbb R^d$$
$$o_n = Q_n s_n$$

2つ目に1つ目を代入してすべて展開すると,

$$o_n = Q_n \sum_{m=1}^n A^{n-m} K_m v_m$$

そして $Q,K$ はアテンションのノリで次のように定める.

$$Q = X W_Q ~;~ W_Q \in \mathbb R^{d \times d}$$
$$K = X W_K ~;~ W_K \in \mathbb R^{d \times d}$$

ここで $W_Q, W_K$ が学習されるパラメータ.

さて $A$ の累乗という計算が重たいので, これを対角化する.
次のような対角化をしている.

$$A = \Lambda (\gamma \exp(i\theta)) \Lambda^{-1}$$

（たぶんだが） $\exp$ のところは次のような対角行列のことだろう.

$$\gamma \exp(i\theta) = \left[\begin{array}{cccc}
\gamma_1 \exp(i\theta_1) & & & \\
& \gamma_2 \exp(i\theta_2) & & \\
& & \ddots & \\
& & & \gamma_d \exp(i\theta_d) \\
\end{array}\right]$$

こうすると $A$ の累乗は

$$A^{n-m} = \Lambda (\gamma \exp(i\theta))^{n-m} \Lambda^{-1}$$

と書ける.
これを代入して,

$$o_n =
\left( Q_n (\gamma \exp(i\theta))^n \right)
\sum_{m=1}^n
\left( (\gamma \exp(i\theta)^{-m}) K_m \right) v_m$$

エルミート転置の $\dagger$ を使うと

$$o_n =
\left( Q_n (\gamma \exp(i\theta))^n \right)
\sum_{m=1}^n
\left( K_m^t (\gamma \exp(i\theta)^m) \right)^\dagger v_m$$

曰く,
$\left( Q_n (\gamma \exp(i\theta))^n \right)$ と $\left( K_m^t (\gamma \exp(i\theta)^m) \right)$
が xPos, すなわち Transformer における位置埋め込みになってるという.

### Parallel Representation

より簡潔な行列表記していこう.
これをやると並列計算が可能になる.

$$\Theta \in \mathbb C^{N \times d} ~;~ \Theta_{nd} = \exp(in \theta_d)$$

を用意する.
またこれの共役を取ったものを $\bar{\Theta}$ とする.

また上三角行列

$$D_{nm} = \begin{cases}
\gamma^{n-m} & \text{ if } n \geq m \\
0 & \text{ otherwise } \\
\end{cases}$$

を用意する.
すると,

$$V = XW_V$$
$$Q = (XW_Q) \odot {\Theta}$$
$$K = (XW_K) \odot \bar{\Theta}$$

これが RetNet の一つの形式化である.

### Recurrent Representation

Recurrent Network のようにステップを逐次的に書くと次のようになる.

$$S_n = \gamma S_{n-1} + K_n V_n$$
$$\mathrm{Retention}(X_n) = Q_n S_n$$

これもまた別な形式化になってる.

### Multi-scale Retention

潜在ベクトル $d$ 次元を, $h$ 個に分ける.
一個当たり $d/h$ 次元である.
そのそれぞれに関して Retention する.
アテンションでもあった Multi-head のこと.

ところで形式化で出てきた $\gamma$ をこの head ごとに固定して使う.
だから Multi-scale.

- $\mathrm{head}_i = \mathrm{Retention}(X; \gamma_i)$
    - $\gamma_i$ は適切に決め打ちする
- $Y = \mathrm{GroupNorm}(\mathrm{Concat}( \mathrm{head}_1, \ldots, \mathrm{head}_h ))$
- $\mathrm{MSR}(X) = (\mathrm{swish}(XW_G) \odot Y) W_O$


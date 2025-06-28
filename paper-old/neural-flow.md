% [2003.08063] Stable Neural Flows
% https://arxiv.org/abs/2003.08063
% 深層学習

## Python ライブラリ

- [TorchDyn](https://torchdyn.readthedocs.io/en/latest/index.html)

## 関連

- [ [arxiv:1806.07366] Neural Ordinary Differential Equations](https://arxiv.org/abs/1806.07366)

## 概要

十分たくさんの層を重ねる代わりに, 常微分方程式 (ODE) 一つを置くことでより細やかなDNNが再現できる.
学習は微分方程式を解くことで, 推論はそれを積分することに相当させる.

## DNN -> Flow

### DNN

DNN は結局（一個一個は単純な）関数を直列に合成したもの:
$$F(x) = f_N ( \cdots ( f_2 ( f_1 (x) ) ) \cdots )$$

ここで $f_i$ という関数は重み $w_i$ を用いた $i$ 番目の方法で計算をするものだから,
その処理系を
$f(i, w_i, x) = f_i(x)$
と書くことができるはず.
これを使うと,

- $x_1 = x$
- $x_{i+1} = f(i, w_i, x_i)$
- $F(x) = x_{N+1}$

と書ける.

### Residual

経験的に $f_i(x)$ を使うより $x + f_i(x)$ をするほうが学習上手く行くことがわかってる.
これは逆伝播が直接前の層に伝えられるから.
これと同じことを今さっきのに適用しよう.

- $x_1 = x$
- $x_{i+1} = f(i, w_i, x_i) + x_i$
    - $\iff x_{i+1} - x_i = f(i, w_i, x_i)$
- $F(x) = x_{N+1}$

### Flow へ

この $x_1, x_2, \ldots, x_{N+1}$ というのを同じ多様体 $X$ の上の点のフローだと思ってみる.
すなわち, $x_i$ を $X$ 上の時刻 $i$ 時点の点だと言うことにする.
すると $x_{i+1} - x_i$ というのは $\Delta x$ に見えてくる.

時刻も離散的な $1,2,\ldots, N+1$ から, 実数区間 $0 \to 1$ にした方がきれい.

- $x_0 = x$
- $\frac{dx}{dt} = f(t, w_t, x_t)$
- $F(x) = x_1$

ここで $x_t$ は時刻 $t$ 時点の点 $x$.
従って入力 $x$ が $x_0$.
最後の値 $x_1$ が元のDNNの出力.

<figure>
<img src="https://i.imgur.com/nd2HXln.png" />
<figcaption>
関連 arxiv:1806.07366 より引用.<br>
左の depth は第何層を表している.
離散的に値を少しずつずらしている.<br>
一方右では depth は時刻を表している.
</figcaption>
</figure>

## Neural Flows

微分方程式部分にはいくつかバリエーションが考えられる.

### Depth Variant

これはさっきみせたもの.
各層は異なる計算をさせたいから depth $t$ を入力に入れる.

- $\frac{dx}{dt} = f(t, w(t), x_t)$

### Depth Invariant

時刻パラメータに依存しないパターン.
状態を持たない RNN みたいな感じかな.

- $\frac{dx}{dt} = f(w(t), x_t)$

## 機械学習への適用

ODE 部分は同じ空間 $X$ から $X$ への写像として使われる.
実際に学習させたいものはそういう形式ではないだろうから適当な空間へのエンコードとデコードを行う.

- Input: $x$
- Encode: $z_0 = E(x) \in Z$
- ODE: $Z \to Z$
    - $dz/dt = f(z, \cdots)$
- Decode: $y = D(z_1)$
- Output: $y$

ここで出てくる $E, f, D$ を DNN で構成する.

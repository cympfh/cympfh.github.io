% Variational Autoencoders (VAEs)
% https://arxiv.org/abs/1606.05908
% 深層学習 オートエンコーダ

## 概要

VAEs (Variational Autoencoders; 変分自己符号化器) とは生成モデルの枠組みで自己符号化器 (Autoencoders) を解釈したもので、
生成モデルで言う潜在変数を観測データの符号と見做す.
すなわち、観測データから潜在変数を推定する手続きが符号化であり、その逆が復号化である.

## (Standard) VAEs

次のような単純な生成モデルを考える.

観測されるデータ $x$ はある潜在変数 $z$ があって生成されるものだというモデルを考える.

<center>
<img width="240px" src="img/vae/model.png" />
</center>

ここで、次を仮定する

- $z \sim \mathcal{N}(0, 1)$ を仮定
- $z|x \sim \mathcal{N}(\mu(x), \Sigma(x))$ を仮定

### Standard VAEs の確率予測

生成モデルなので確率分布がエンコーダー・デコーダーとなる:

- エンコーダー
    - $Pr(z|x)$
- デコーダー
    - $Pr(x|z)$

これら2つをそれぞれ NNs で構成した

- エンコーダー
    - $Q(z|x)$
- デコーダー
    - $R(x|z)$

で近似する.

エンコーダー $Q$ の学習を考える.
$Q$ は $Pr(z|x)$ を近似するためのものだから、これら2つの KL 距離を最小化すればよい.

$$\begin{eqnarray}
\text{KL}(Q(z|x) \| Pr(z|x))
  & = & \mathbb{E}_{z \sim Q(z|x)} \left[ \log Q(z|x) - \log Pr(z|x) \right] \\
  & = & \mathbb{E}_{z \sim Q(z|x)} \left[ \log Q(z|x) - \log Pr(x|z) - \log Pr(z) \right] + \log Pr(x) \\
  & = & \text{KL}(Q(z|x) \| Pr(z)) - \mathbb{E}_{z \sim Q(z|x)} \left[ \log Pr(x|z) \right] + \log Pr(x) \\
\iff \text{KL}(Q(z|x) \| Pr(z|x)) - \log Pr(x)
  & = & \text{KL}(Q(z|x) \| Pr(z)) - \mathbb{E}_{z \sim Q(z|x)} \left[ \log Pr(x|z) \right]
\end{eqnarray}$$

左辺の
$\text{KL}(Q(z|x) \| Pr(z|x)) (\geq 0)$
を最小化することは $Q$ を学習すること.
左辺に移行した
$- \log Pr(x) \geq 0$
は、観測データ $x$ を観測する対数尤度のマイナスであるので、これを最小化することは、
自己符号化器全体 (すなわち $Q, R$) を訓練すること.

そういうわけで、最後の式を最小化することを目指せばよい.

> 註意すべき点として、左辺は未知の確率分布 $Pr(z|x)$ との KL 距離だったものが、
> 右辺では $Pr(z)$ との KL 距離になっていて、
> 今 $Pr(z) = \mathcal{N}(0,1)$ と仮定しているので、既知の確率分布との KL 距離になっている.

そういうわけで右辺値を目的関数とする.

$$\begin{eqnarray}
\mathcal{L}(x; Q,R)
 & = \text{KL}(Q(z|x) \| Pr(z|x)) - \mathbb{E}_{z \sim Q(z|x)} \left[ \log Pr(x|z) \right] \\
 & = \text{KL}(Q(z|x) \| \mathcal{N}(0, 1)) - \mathbb{E}_{z \sim Q(z|x)} \left[ \log Pr(x|z) \right]
\end{eqnarray}$$

<center style="margin:20px">
<img width="800px" src="img/vae/ae.png" />
</center>

### 計算のトリック

#### $Q(z|x)$ の構成法

$Q$ を適当な NNs で実現するわけだが、出力は確率分布で、しかも $\mathcal{N}$ と仮定している.
従って直接的には、その平均 $\mu(x)$ と分散 $\Sigma(x)$ とを予測する.

<img width="500px" src="img/vae/q.png" />

$\text{KL}(Q(z|x) \| \mathcal{N}(0, 1))$ の計算も、正規分布同士の計算なのでまあ頑張れば出来る.

$R$ も、まあ大体同様にして学習すればよい.

#### サンプリング (reparametarization trick)

$\mathbb{E}_{z \sim Q(z|x)} \left[ \log Pr(x|z) \right]$
をどうやって計算するか.
ある確率分布に沿った期待値を本当に計算したいのだが、
簡単な近似法としては、
適当回数 $Q(z|x)$ から $z$ をサンプリングし、
$\log R(x|z)$
の平均を取れば良い.

ただし一度の順伝播・逆伝播で $Q$ も $R$ も学習出来るのが本当は理想.
そのためにサンプリングの回数は一度だけとする.
そして、$\mathcal{N}(\mu, \Sigma)$ からサンプリングという手続きは一般には逆伝播が出来ない計算である.
次のように言い換えることで逆伝播が出来る.

1. $e \leftarrow \mathcal{N}(0, 1)$ をランダムサンプリング
1. $z = \mu(x) + e \Sigma(x)$ (ここで $e$ は定数)

#### まとめ

以上をまとめると VAE の学習は以下の通り

- 事例 $x$ について
    1. $Q$ の順伝播から $\mu(x), \Sigma(x)$ を求める
    1. $e \leftarrow \mathcal{N}(0, 1)$ をランダムサンプリング
    1. $z = \mu(x) + e \Sigma(x)$
        - これは $\mathcal{N}(\mu, \Sigma)$ からのサンプリングと等しい
    1. $\log R(x|z)$ を計算
    1. $\text{KL}(Q(z|x) \| \mathcal{N}(0, 1)) - \log R(x|z)$ を損失だとして逆伝播する

<center style="margin:20px">
<img width="800px" src="img/vae/ae.png" />
</center>

### 古典的 Autoencoders との比較

特に何の制約もないただの Autoencoders が何をするかと言うと、
出来るだけ同じ変数名を用いて説明すると

- 事例 $x$ について
    1. $Q$ の順伝播から $z$ を求める
    1. $R$ の順伝播から $x$ を求める
    1. $- \log R(x|z)$ を損失だとして逆伝播する

大きく違う点としては、エンコードして出来た $z$ に
$\text{KL}(Q(z|x) \| \mathcal{N}(0, 1))$
という正則化項を加えるかどうかだけである.

### Testing

訓練した VAE をテストするには
適当なノイズ $z \sim \mathcal{N}(0, 1)$ を
Decoder $R$ に入れるだけで良い.

とは言え、適当なノイズを入れただけではやはり平均的な、
例えば MNIST ならボヤケた画像が、出て来るだけになる.

## Conditional Variational Autoencoders (CVAEs)

データ $x$ にラベル $y$ があるとしてそれを活用したい.
先の VAE で $x$ としていたのを $y$ にして、代わりにエンコーダーにもデコーダーにも $x$ を入れることにする.

次のモデルを用いる.

<figure>
<img width="300px" src="img/vae/cmodel.png" />
<img width="400px" src="img/vae/cvae.png" />
</figure>

このようにすると、この testing は

- 入力 $x$ に対して
- ノイズ $z \sim \mathcal{N}(0, 1)$ を用いて
    - $y = R(x, z)$

として、「$x$ から $y$ を予測するモデル」として使うことが出来て楽しい.

損失関数は

$$\begin{eqnarray}
\mathcal{L}(x; Q,R)
 & = \text{KL}(Q(z|x,y) \| Pr(z|x,y)) - \log Pr(y|x)
 & = \text{KL}(Q(z|x,y) \| Pr(z|x)) - \mathbb{E}_{z \sim Q(z|x,y)} \left[ \log Pr(y|z,x) \right]
\end{eqnarray}$$

となる.
註意すべき点として $x$ と $z$ は独立だとしているので相変わらず

$$Pr(z|x) = Pr(z) = \mathcal{N}(0,1)$$

のまま. 損失関数は改めて書くと

$$\mathcal{L}(x; Q,R)
  = \text{KL}(Q(z|x,y) \| \mathcal{N}(0, 1)) - \mathbb{E}_{z \sim Q(z|x,y)} \left[ \log Pr(y|z,x) \right]$$

としてこれを最適化する.

## MNIST 実験

このチュートリアルでは MNIST で VAE 及び CVAE を訓練した実験結果を述べている.

ゼロから学習させずにどっかに落ちているという MNIST で訓練したプレーンな自己符号化器の重みを流用したらしい.

興味深いテクニックを一つ使っている.
MNIST なので、入力は 28x28 の行列で各成分は整数値 $[0, 255]$.
これを普通はまず 255 で割り算して $[0,1]$ 範囲の実数値だと見なしてから使うだろう.
そこまでは同じだが、この実験ではその値を確率だと見なして、$\{0,1\}$ に二値化する.
つまり、各ピクセルについて独立に、その確率で $1$ さもなくば $0$ にする.
これは画像を NNs に流すタイミングで毎回サンプリングするので、データ水増し的な意味合いもある.

    (Figure 7)

まず VAE の結果.
$x$ は先のテクニックで二値化した $\{0,1\}^{28 \times 28}$.
ただし VAE の出力 (デコード) $x'$ は $[0,1]^{28 \times 28}$.
テストではデコード部分だけを動かす.
ランダムなノイズをデコーダーに入力して、それらしい手書き文字がランダムに出力される.
"7" と "9" の中間っぽい文字が出力されており、入力ノイズの空間が連続であることが示唆される.

    (Figure 8a)

次に CVAE の結果.
こちらは、画像の右半分 (左半分?) を $x$ としている.
$y$ は VAE での $x$ (すなわち $\{0,1\}^{28 \times 28}$).
テストではやはりデコード部分だけを動かすのだが、
今度はランダムなノイズと、画像の半分をデコーダーに入れると、画像の全体が出力される.
まあ、それらしいのが動いてるなあという感じ.


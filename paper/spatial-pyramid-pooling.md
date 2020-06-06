% [1406.4729] Spatial Pyramid Pooling in Deep Convolutional Networks for Visual Recognition
% https://arxiv.org/abs/1406.4729
% 深層学習 画像認識

## 概要

畳み込み層 (Convolutional layers) への入力 (画像) は、他の層と同様に通常固定サイズである.
現実の画像は様々なサイズの画像であるので、そのサイズになるように crop (切り取り) や warp (アスペクト比を保持しない拡大縮小) を行うことになる.
それにはもちろん、大事な部分が取り除かれるだとか、アスペクト比が強引になるなど危惧がある.
Spatial Pyramid Pooling (SPP) はこれらを解決する.

## SPP-layer

元論文 [^1] の Figure 3 がメインでこれを SPP-layer と呼んでいる.
これを適当に Convolution の最後の方、Dense 等の固定サイズが欲しくなる直前に入れれば良いらしい.
しかしこいつらの説明は、結局全然分からなくて (図で説明した気になるのはダメ)
参考文献 [^2] これでわかった.

二次元畳み込み層は本来、そのままでも入力画像サイズは (カーネルサイズ以上ありさえすれば) 何でもよいが出力サイズもそれによって変化する.
畳み込み層いくつかによってサイズ $h \times w \times c$ の行列を得たとする.
ここで $c$ はチャンネル数 (またはフィルタ数) である.

### feature map の分割

予め
$$B = (b_0, b_1, b_2, \ldots, b_m)$$
を定めておく.
これは分割のレベル及び個数を定めるもので、例えばレベル $i$ では $b_i$ 個に行列を分割する.

ちなみに元論文では $B = (1, 4, 16)$ を使っている.
これは $b_i = k^2$ とすることで $k \times k$ 個にキレイに分割できるという話でしかなく、どうでもいい.
分割されて得た $b_i$ 個の行列はそれぞれ同じサイズである必要は無いから.

任意サイズの二次元行列 $a$ を $b (=b_i)$ 個に分割する操作を
$$\mathbb{R}^{- \times -} \to \bigoplus^b \mathbb{R}^{- \times -}$$
$$\mathrm{Split}^b : a \mapsto (a_1, a_2, \ldots, a_b)$$
と書く.

#### 例

次の分割はあくまでも一例

$$\mathrm{Split}^2 \left(\begin{array}{cc}a&b\\c&d\end{array}\right) = \left( \left(\begin{array}{c}a\\c\end{array}\right) \left(\begin{array}{c}b\\d\end{array}\right) \right)$$

### プーリング

任意サイズを固定サイズに移す肝は結局プーリングで、いわゆる max pooling はカーネルというものを持つが、
カーネルを定めずに入力全体の max を取ることが出来るはずである.
$$\mathrm{MaxPooling} : \mathbb{R}^{h \times w} \to \mathbb{R}$$

これを分割後の各行列に適用することを考える.
$$\mathrm{MaxPooling}(\mathrm{Split}^b(a)) : \mathbb{R}^b$$
これの出力は長さ $b$ の実ベクトルとみなせる.

以上を $c$ チャンネル全てに適用すれば、結局 $cb=cb_i$ サイズのベクトルを得る (結合するだけ).

以上を全ての $i$ ($b_i$) について適用すれば結局 $c \sum_i b_i$ サイズのベクトルを得る (結合するだけ).

というわけで間違いなく可変サイズの入力全ての情報を使って固定長のベクトルを得ることに成功した.

## 参考

- [^1]: [[1406.4729] https://arxiv.org/abs/1406.4729](https://arxiv.org/abs/1406.4729)
- [^2]: [Summary of Spatial Pyramid Pooling in Deep Convolutional Networks for Visual Recognition on ShortScience.org](http://www.shortscience.org/paper?bibtexKey=journals/corr/1406.4729#martinthoma)

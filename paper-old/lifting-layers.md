% Lifting Layers: Analysis and Applications
% https://arxiv.org/abs/1803.08660
% 深層学習 活性化関数

## 概要

画像認識分野では低次元のものでは使われないような非線形関数 (relu) が使われる.
提案する lifting という非線形関数は、入力を分割することで高次元にし、このギャップを埋める.
この関数は凸最適化から来ていて、lifting という操作は非凸だったり flag (傾きがゼロ) な損失関数も扱えるようになる.

## 提案

関数 relu
$$\sigma(x) = \mathrm{max}(x, 0)$$
をさらに強くすることを考える.
この関数は $x \lt 0$ の部分では完全に「死んで」いるといえる.
そこで $\mathrm{min}(x,0)$ という値も付け足せば、死ぬ部分が消える.

$$\sigma(x) = \left(\begin{array}{cc}
\mathrm{max}(x, 0) \\
\mathrm{min}(x, 0)
\end{array}\right)$$

次元は倍になる.
さらにこれを一般化する方向として、$x$ の区間を細分化する.
$x$ が取りうる領域を $U \subset \mathbb R$ とし、$U$ を $L-1$ 個の領域に分割する.

$$t^1  \lt  t^2  \lt  \cdots  \lt  t^L$$
$$U = [t^1, t^L)$$

各領域で値を取る関数 $f_i, g_i$ を定める:
$$f_i(x) = \frac{t^{i+1} - x}{t^{i+1} - t^i}$$
$$g_i(x) = \frac{x - t^i}{t^{i+1} - t^i}$$
$f_i$ が relu, $g_i$ が relu の min 版に相当する.

特に $\lambda_i(x) = \frac{x - t^i}{t^{i+1}-t^i}$ と置くと
$$f_i(x) = 1 - \lambda_i(x)$$
$$g_i(x) = \lambda_i(x)$$
である.

このとき次の関数を lifting 関数として定義する:
$$\ell : \mathbb R \to \mathbb R^L$$
$$\ell(x)_i = f_i(x)     ~~\text{when } x \in [t^i, t^{i+1})$$
$$\ell(x)_{i+1} = g_i(x) ~~\text{when } x \in [t^i, t^{i+1})$$

<center>

```@gnuplot
set xrange [0:2]
f(x, t0, t1) = t0 <= x && x <= t1 ? ((t1 - x) / (t1 - t0)) : 0
g(x, t0, t1) = t0 <= x && x <= t1 ? ((x - t0) / (t1 - t0)) : 0
plot f(x, 0, 1), g(x, 0, 1), f(x, 1, 2), g(x, 1, 2)
```

</center>

> これは点 $x$ の領域を離散化していることに他ならない.
> $\ell(x)_i$ は $x$ の $t_i$ への近さを $[0,1]$ のなかの値で表現している.

ところで $\ell(x)$ は情報を失っておらず逆関数が存在する
$$\ell^{-1}(z) = \sum_{i=1}^L z_i t^i.$$

> これはいわゆる全結合層に他ならないので、要するに $\ell$ を挟むことで悪くなることはない、と言える.

### scaled lifting

lifting では $x$ のスケールを殺して $[0,1]$ に規格化していた.
スケールをわざと残すということも考えられて,
$$f_i(x) = t^i (1 - \lambda_i(x))$$
$$g_i(x) = t^{i+1} \lambda_i(x)$$
としたものを scaled lifting 関数と呼ぶことにする.

## Examples

一次元関数のフィッティングをやってみる.
ほとんど予想通りであるが、領域を分割する点をつなげた曲線ができあがる.

![](https://i.imgur.com/0rCZK1P.png)

画像にもちゃんと使える

![](https://i.imgur.com/no3Nmjx.png)

ちなみにこの ME-Model ってのは [Tensorflowのチュートリアル](https://www.tensorflow.org/tutorials/) で使われてる MNIST 用モデルらしい.

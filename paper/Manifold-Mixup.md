% [1806.05236] Manifold Mixup: Encouraging Meaningful On-Manifold Interpolation as a Regularizer
% https://arxiv.org/abs/1806.05236
% 深層学習 データ水増し

## 概要

より少ないデータ数、ラベル数で CIFAR-10 をやる.
2点の内点を取って
$((x_i, x_j) \mapsto \lambda x_i + (1-\lambda) x_j)$
データ水増しするというのがあるが、これをNN内部の値に対しても行う.

## 手法

NNの内部の層から適切な複数の層を予め選んでおき、バッチ学習のたびにランダムに層を選ぶ.
(選ぶ候補には入力層自体も入れる.)
NNの全体の計算を $y=f(x)$ と置くと、この選んだ層の前後で計算 $f$ は $y=g_k(h_k(x))$ と分解できる.
(入力層が選ばれたならば $h_k=1, g_k=f$.)
2つの入力データ $x_i, x_j$ に対して $h_k$ までは通常通り演算して $h_k(x_i), h_k(x_j)$ を得るが、それ移行は mixup (つまり内点を取る) する:
$$\hat{y} = g_k( \lambda h_k(x_i) + (1-\lambda) h_k(x_j))$$
ここで $\lambda$ は $0 \leq \lambda \leq 1$ なパラメータであるが、適当なベータ分布から、特に彼らは $Beta(\alpha,\alpha)$ という形の分布からランダムに選んできたという.
下図は $\alpha=2$ のときのベータ分布.
$\alpha=1$ のときは完全に一様分布で、$\alpha$ が大きくなるとこれが細長くなってく.

![](https://i.imgur.com/706hvgs.png)

この予測値 $\hat{y}$ に対して教師を $\tilde{y} = \lambda y_i + (1-\lambda) y_j$ だとして学習させる.

## 実験

### 教師あり学習の正則化として

CIFAR-10 で教師あり学習の性能が mixup しない場合に比べて向上した.
モデルは PreActResNet{18,152}.

### 半教師あり学習への適用

Appendix-Bを見よ.

ラベル付きのデータとラベルなしのデータを1つずつ持ってきて学習を行う.
ラベルなしのデータにはその時点の学習済みモデルで予測したラベルを擬似ラベルとして用いる.
ラベル付きによるロスを $L_l$, なしによるロスを $L_u$ とすると、この和として $L_l + \pi L_u$ をロスにしてからパラメータの更新を行う.
ここで $\pi$ は consistency coefficient と呼ばれるもので、 0 からスタートして徐々に上がる値.
[Oliver et al., 2018] による方法らしいのでそっちを読んだほうが良さそう.

CIFAR-10 では VAT に勝ってる. SVHN では VAT-EM がさいつよ. 大差はないが.

### Adversarial Examples

略

### GAN

普通の GAN の判別機は、入力が real か fake かの2値分類だが、この入力を混ぜて、その混合率を当てるように改造する.
つまり
$$\max_G \min_D \ell( D(\lambda x + (1-\lambda) G(z)), \lambda )$$
ただし $\lambda$ はやはり $\mathrm{Beta}(\alpha, \alpha)$ からランダムサンプリングしてきた値.

しかしこのままでは上手く行かなかったそう (non-crisp looking).
以下の変更を加えた.

1. 純粋に real なものだけを $1$ にして、少しでも mix したものはすべて $0$ (fake) とした
1. generator に discriminator を騙させるのはやめた

そして最初の mixup 同様に、 D からランダムに層 $k$ を選んで次のように分解する:
$$D = d_k \circ h_k$$
混ぜるのは入力とは限らず中間層でも混ぜる.
$$d_k ( \lambda h_k(x) + (1-\lambda) h_k(G(z)))$$
目的関数には純 real と純 fake のロスも足して
$$\min_D \ell(D(x), 1) + \ell(D(G(z)), 0) + \ell(d_k( \lambda h_k(x) + (1-\lambda) h_k(G(z))), 0)$$

> 論文だと最初の2項の $D$ (っていうか $d$) が $d_k$ になってるけど誤植だと思う

> 感想 : $G$ はもはや何の学習もしないのでノイズ発生器にしかなってない？


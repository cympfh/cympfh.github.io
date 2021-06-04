% [2010.01412] Sharpness-Aware Minimization for Efficiently Improving Generalization
% https://arxiv.org/abs/2010.01412
% 深層学習 最適化

## 概要

損失関数をいい感じにいじってより学習に易しい損失関数を作る.

## 復習

損失関数に基づく機械学習というのは次のようなものである.

- モデルのパラメータ $w \in W$
- 入力信号 $x \in X$
- 出力信号 $y \in Y$
- 損失関数 $\ell \colon W \times X \times Y \to \mathbb R_+$

真のデータ分布 $D$ の上で観測される $(X,Y)$ の分布について $L$ の期待値
$$L_D(w) := \mathbb E \left[ \ell(w,x,y) \right]$$
を最小化するような $w$ を探索することを学習と呼ぶ.

さて真のデータ分布 $D$ は分からないので実際にはサンプリング
$$S = \{ (x_i, y_i) \}_{i=1,\ldots,N}$$
の上で推定した
$$L_S(w) := \frac{1}{N} \sum_S \ell(w,x,y)$$
を変わりの近似値として使う.

ここで最急降下法によって最適な $w$ を得る場合には勾配が重要になる.
特に最適解付近では勾配が緩やかな方が良いとされている.
SAM は損失関数自体を少しいじることで, そんな良い勾配を持った関数にすることを目指す.

## Theorem 1

任意の正数 $\rho > 0$ に対して, ある狭義単調増加関数
$h \colon \mathbb R_+ \to \mathbb R_+$
によって次が成り立つ (with highly probability):
$$L_D(w) \leq \max_{\|\epsilon\|_2 \leq \rho} L_S(w + \epsilon) + h(\|w\|_2^2 / \rho^2).$$

## SAM

Theorem 1 の右辺の $L_D$ に対する上限を参考に, 損失関数とする.
$$L_S^{\mathrm{SAM}}(w) := \max_{\| \epsilon \| \leq \rho} L(w + \epsilon) + \lambda \|w\|_2^2$$

さてこの max を効率的に近似的に計算する.
$L(w + \epsilon)$ を $\epsilon \sim 0$ の周辺で一次までテイラー展開して
$$L(w) + \epsilon^\top \nabla_w L(w) + \lambda \|w\|_2^2$$
を代わりに考えることにすると, $\epsilon$ に関わる
$$\max_\epsilon ~~ \epsilon^\top \nabla_w L(w)$$
だけすればいいことになる.

で、謎の理屈を使うと, 次の値を $\epsilon$ として使えば良い.

$$\hat{\epsilon} = \rho ~
\mathrm{sign}(\nabla_w L_S(w))
\frac{
\left| \nabla_w L_S(w) \right|
}{
\sqrt{ \| \nabla_w L_S(w) \|_2^2 }
}$$

ここで分子にある $\left| a \right|$ は要素ごとに絶対値をとったもの.



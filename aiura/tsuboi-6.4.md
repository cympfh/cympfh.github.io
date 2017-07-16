% 坪井 多様体 6.4 - コンパクト多様体上のフロー
% 2017-07-16 (Sun.)
% 数学 幾何学

## コンパクト多様体の上のベクトル場

### 定理

<div class=thm>
コンパクト多様体 $M$ の上のベクトル場 $X$ に就いてフロー $F_t$ が存在して
$$\frac{dF}{dt}(t, x) = X(F(t, x))$$
が成立する.
</div>

### 定理

<div class=thm>
連結なコンパクト1次元多様体 $M$ は $\mathbb{R}/\mathbb{Z}$ と微分同相.
</div>

#### 証明

連結な一次元なので、向きを定めることが出来る.
即ち、$M$ の有限個の被覆
$\{ (U_i, \phi_i) \}_{i=1,\ldots,k}$
であって、
座標変換 $\gamma_{ji} = \phi_j \circ \phi_i^{-1}$ についてその微分が
$D \gamma_{ji} > 0$
(i.e. $\forall x, (D\gamma)(x)>0$)
である.

$\phi_i$ が与える (一次元) 座標を $t^i$ とする.
$\{U_i\}$ による 1 の分割を $\lambda_i$ とする.

$M$ の上のベクトル場
$$X = \sum_i \lambda_i \frac{\partial}{\partial t^i}$$
は、どの点でもゼロにならない.
なぜなら、座標変換を考えると
$$\frac{\partial}{\partial t^i} = (D \gamma_{ji} \circ \phi_i)(x) \frac{\partial}{\partial t^j}$$
なんで、
$$X(x)
= \sum_i \lambda_i(x) \frac{\partial}{\partial t^i}
= \sum_i \lambda_i(x) (D \gamma_{ji} \circ \phi_i)(x) \frac{\partial}{\partial t^j}$$

$\lambda_i(x) \leq 0, (D \gamma_{ji} \cdots)(x) > 0$
でかつ、1の分割はある $i$ で $\lambda_i(x) > 0$ なので、安心して
$$X(x) = \alpha \frac{\partial}{\partial t^j} ~~(\alpha > 0)$$
となる.

さて、この $X$ が生成するフロー $F_t$ を考える.
ベクトル場は常に非ゼロなので、フローの軌道が点になることはない.
実は軌道は $M$ と一致する.
軌道を $A = \{ F_t(x_0) : t \}$ とする.
$M \ne A$ とすると、$M \setminus A$ の元であって、近傍が $A$ と交わるような点がある.
その点を通る軌道を書くと $A$ に交わって (一次元だから) 結局、その点も $A$ に含まれることになる.
なので $M=A$.

$A$ は前の定理から、$t$ についてある周期 $T$ があるので
$A=M$ は $\mathbb{R}/T\mathbb{Z}$ と微分同相.
従って $\mathbb{R}/\mathbb{Z}$ とも微分同相.


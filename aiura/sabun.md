% 差分法による拡散方程式の数値計算
% 2013-07-21 (Sun.)
% 数学 数値計算
% 前進オイラー法とか後退オイラー法とかです

## 拡散方程式

初期値を適当な $u_0(x) = u(x, 0)$ とするような 2変数関数 $u(x, t)$ に関する拡散方程式
$$u_t = \kappa u_{xx}$$

について、
数値計算的に $t > 0$ の範囲で適当の $x$ に関する $u(x, t)$ の値を計算したい.

## 前進オイラー法

適当に小さな定数 $\Delta t$ を以って $u_t$ を

$$\frac{u(x, t + \Delta t) - u(x, t)}{\Delta t}$$

で置き換える.
これはテイラー展開の1次近似 (つまりオイラー法) だと考えると解釈できる.
すなわち、

$$\begin{align}
& f(t + \Delta t) = f(t) + f'(t) \Delta t + O(\Delta t^2) \\
\Rightarrow
& f'(t) \approx \frac{1}{\Delta t} \Big( f(t + \Delta t) - f(t) \Big)
\end{align}$$

同様にして二階微分もテイラー展開の二次近似で求まる.
ただし一階微分を打ち消すために
$f(x + \Delta x)$ と $f(x - \Delta x)$ の2つの和を考える.

$$\begin{align}
& f(x + \Delta x) = f(x) + f'(x) \Delta x + \frac{1}{2}f''(x) \Delta x^2 + O(\Delta x^3) \\
& f(x - \Delta x) = f(x) - f'(x) \Delta x + \frac{1}{2}f''(x) \Delta x^2 + O(\Delta x^3) \\
\Rightarrow
& f(x + \Delta x) + f(x - \Delta x) = 2 f(x) + f''(x) \Delta x^2 + O(\Delta x^3) \\
\Rightarrow
& f''(x) \approx \frac{1}{\Delta x^2} \Big( f(x + \Delta x) - 2 f(x) + f(x - \Delta x) \Big)
\end{align}$$

というわけで $u_{xx}$ を

$$\frac{f(x + \Delta x) - 2 f(x) + f(x - \Delta x)}{\Delta x^2}$$

で置き換えれば良さそう.

以上から

$$u(x, t + \Delta t) = u(x, t) + \frac{\kappa \Delta t}{\Delta x^2} \Big( u(x + \Delta x, t) - 2 u(x, t) + u(x - \Delta x, t) \Big)$$

を組み立てられる.
初期値として $x$ に関する $u_0(x)$ が既知なのでこの右辺を用いることで $u(x, \Delta t)$ が求まる.
さらに繰り返し適用することで $u(x, 2\Delta x)$ が求まる...
このように、時刻変数 $t$ に関して $0$ から初めて前方 (数が増える方向) に進むから、これを前進法という.

## 後退オイラー法

$u_t$ を
$$\frac{u(x, t) - u(x, t - \Delta t)}{\Delta t}$$
と置き換えても何も問題は無さそう.
これを使って先の前進法を適用すると、

$$u(x, t) = u(x, t - \Delta t) + \frac{\kappa \Delta t}{\Delta x^2} \Big( u(x + \Delta x, t) - 2 u(x, t) + u(x - \Delta x, t) \Big)$$

求めたいのは $t>0$ の範囲であるから、
この式を用いて $u(x, t - \Delta t$ から $u(x, t)$ を求めることを考える.

- ベクトル $u$
    - $u_i = u(x_i, t - \Delta t)$
- ベクトル $v$
    - $u_i = u(x_i, t)$

とすると、先の式は

$$\begin{align}
     & v_i = u_i + \frac{\kappa \Delta t}{\Delta x^2} \Big( v_{i+1} - 2 v_i + v_{i-1} \Big) \\
\iff & u_i = - r v_{i+1} + (2r+1) v_i - v_{i-1}
\end{align}$$

と書き改められる.
ここで $r = \frac{\kappa \Delta t}{\Delta x^2}$ と置いた.
つまり、十分長いベクトルに関する一次方程式に他ならない.
行列で書き直すと、

$$\left[\begin{array}\\
2r+1 & -r \\
-r   & 2r+1 & -r \\
     & -r   & 2r+1 & -r \\
     &      & -r   & \ddots & \ddots \\
     &      &      & \ddots & \ddots \\
\end{array}\right] v = u$$

これを繰り返す解くことで、$u(x, \Delta t), u(x, 2\Delta t), \ldots$ が求まる.

## クランク・ニコルソン法

前進と後退との違いは、$u_{xx}$ の項を $u(x, t)$ に入れるか $u(x, t + \Delta t)$ に入れるかである.
両方に入れれば式が綺麗になる.
つまり、前進の

$$u(x, t + \Delta t) = u(x, t) + \frac{\kappa \Delta t}{\Delta x^2} u_{xx}$$

で、 $u_{xx}$ を

$$\frac{1}{2}\Big[
u(x + \Delta x, t) - 2 u(x, t) + u(x - \Delta x, t)
+
u(x + \Delta x, t + \Delta t) - 2 u(x, t + \Delta t) + u(x - \Delta x, t + \Delta t)
\Big]$$

で置き換えた式を整理すると、

$$-\frac{r}{2} v_{i-1} (r+1) v_i -\frac{r}{2} v_{i+1} = -\frac{r}{2} u_{i-1} (r+1) u_i -\frac{r}{2} u_{i+1}$$

$$\left[\begin{array}\\
 r+1 & -r/2 \\
-r/2 &  r+1 & -r/2 \\
     & -r/2 &   r+1  & \ddots \\
     &      & \ddots & \ddots \\
\end{array}\right] v
=
\left[\begin{array}\\
 r+1 & -r/2 \\
-r/2 &  r+1 & -r/2 \\
     & -r/2 & r+1    & \ddots \\
     &      & \ddots & \ddots \\
\end{array}\right] u$$



# 二次元ユークリッド幾何 - 直線と点との接触 (CCW)

## 概要

CCW (Counter Clock Wise; 反時計回判定) とは,
$A \to B$ に向かう直線に対して点 $P$ が右にあるか左にあるか, または直線上にあるかを判定する方法の一つ.
二つのベクトル $(B - A)$ と $(P - A)$ の外積の符号を見ればよい.

次を CCW 関数と定義する.

$$\mathrm{ccw}(A, B, P) = \begin{cases}
1 & \text{if } (B - A) \times (P - A) \gt 0 \\
0 & \text{if } (B - A) \times (P - A) \lt 0 \\
-1 & \text{if } (B - A) \times (P - A) = 0 \\
\end{cases}$$

そこで直線 $(A \to B)$ と点 $P$ との接触判定は次のように行う.

$$\mathrm{ccw}^{\text{line}}(A \to B, P) = \begin{cases}
\text{ Left } & \text{if } \mathrm{ccw}(A, B, P) = 1 \\
\text{ Right } & \text{if } \mathrm{ccw}(A, B, P) = -1 \\
\text{ Online } & \text{if } \mathrm{ccw}(A, B, P) = 0 \\
\end{cases}$$

## 実装

@[rust](procon-rs/src/geometry2d/ccw_line.rs)

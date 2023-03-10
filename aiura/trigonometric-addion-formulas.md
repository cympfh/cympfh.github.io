% 三角関数の加法定理
% 2023-03-10 (Fri.)
% 三角関数 高校数学

## 前提知識

- $\cos$ は偶関数
- $\sin$ は奇関数
- $\tan = \sin / \cos$
- オイラーの公式
    - $\exp(ix) = \cos x + i \sin x$
        - ここで $\exp(z)$ は $e^z$ のこと
        - $i$ は虚数単位
- 複素数の同値性
    - $a + ib = u + iv \implies a=u \land b=v$
        - ただしここで $a,b,u,v$ は実数とする


## 三角関数の加法定理

$$\begin{align}
\exp(i (\alpha + \beta))
& = \cos (\alpha+\beta) + i \sin (\alpha+\beta) & \text{オイラーの公式を直接適用した} \\
\exp(i (\alpha + \beta))
& = \exp(i\alpha) \times \exp(i\beta) & \text{指数の展開} \\
& = (\cos \alpha + i \sin \alpha) \times (\cos \beta + i \sin \beta) \\
& = (\cos \alpha \cos \beta - \sin \alpha \sin \beta) + i (\cos \alpha \sin \beta + \sin \alpha \cos \beta) \\ \\
\end{align}$$

ここでこの2つが複素数として等しいから, 次の2つを得る.

$$\cos (\alpha + \beta) = \cos \alpha \cos \beta - \sin \alpha \sin \beta$$
$$\sin (\alpha + \beta) = \cos \alpha \sin \beta + \sin \alpha \cos \beta$$

$\tan = \sin/\cos$ なので,

$$\begin{align}
\tan (\alpha + \beta)
& = \frac{ \sin (\alpha + \beta) }{ \cos (\alpha + \beta) } & \text{ tan の定義} \\
& = \frac{ \cos \alpha \sin \beta + \sin \alpha \cos \beta }{ \cos \alpha \cos \beta - \sin \alpha \sin \beta } \\
& = \frac{ \sin \beta/\cos \beta + \sin \alpha/\cos \alpha }{ 1 - \sin \alpha/\cos \alpha \cdot \sin \beta/\cos \beta } & \text{分母と分子を}\cos\alpha\cos\beta\text{で割った} \\
& = \frac{ \tan\alpha + \tan\beta}{1 - \tan\alpha\tan\beta} \\
\end{align}$$

> 最後の tan についての式は厳密にはゼロ除算や無限大のことを考える必要があるが, 一旦目をつむってることに注意.

## 加法定理の系

バリエーションとして余弦の加法定理から次のようなことも導かれる.

- $\cos (\alpha + \beta) = \cos \alpha \cos \beta - \sin \alpha \sin \beta$

の $\beta$ を $-\beta$ で置き換える. このとき $\cos, \sin$ の偶奇性に注意すると次を得る.

- $\cos (\alpha - \beta) = \cos \alpha \cos \beta + \sin \alpha \sin \beta$

この2つの和差を取ることで次を得る.

$$\cos \alpha \cos \beta = \frac{ \cos(\alpha+\beta) + \cos(\alpha-\beta) }{2}$$
$$\sin \alpha \sin \beta = \frac{ \cos(\alpha+\beta) - \cos(\alpha-\beta) }{2}$$

同様のことを正弦の加法定理にもする.

- $\sin (\alpha + \beta) = \cos \alpha \sin \beta + \sin \alpha \cos \beta$
- $\sin (\alpha - \beta) = - \cos \alpha \sin \beta + \sin \alpha \cos \beta$

これらの和を取ってみると次を得る.

$$\sin\alpha \cos\beta = \frac{ \sin(\alpha+\beta) + \sin(\alpha-\beta) }{2}$$

## 参考

- [[https://mathworld.wolfram.com/TrigonometricAdditionFormulas.html]]

% メビウス関数の反転公式
% 2021-02-09 (Tue.)
% 組合せ数学

## INDEX

<div id="toc"></div>

## 仮定する知識

半順序集合, 束

## 局所有限な半順序集合

半順序集合 $(E, \preceq)$ について **区間** とは,
$x \preceq y$ に対して,
$$[x,y] = \{ z \in E \mid x \preceq z \preceq y \}$$
のこと.

すべての区間が有限集合であることを **局所有限** だという.

元の $\preceq$ を使って $[x,y]$ は尚, 半順序集合であるし, しかも $x,y$ をそれぞれ最小元と最大元とする束である.
$E$ が局所有限なら $[x,y]$ は有限の束である.

## メビウス関数

局所有限な半順序集合 $E$ の上にメビウス関数
$$\mu \colon E \times E \to \mathbb Z$$
を定める.
メビウス関数は次を満たすものとして定義される.

$x \preceq y$ のとき,
$$\sum_{z \in [x,y]} \mu(x, z) = \delta(x, y),$$
$x \not\preceq y$ のとき,
$$\mu(x,y) = 0.$$

ここで $\delta$ はクロネッカーのデルタなどと呼ばれるものであって,
$$\delta(x, y) = \begin{cases}
1 & \text{ if } x = y\\
0 & \text{ else }
\end{cases}$$
という関数.

さて上に書いた $\mu$ がメビウス関数だが, 陽な定義にはなっていなくて,
次のように書き直した方が帰納的定義として計算しやすい.

$$\mu(x, y) = \begin{cases}
1 & \text{ if } x = y \\
- \sum_{x \preceq z \prec y} \mu(x,z) & \text{ if } x \preceq y \\
0 & \text{ else } \\
\end{cases}$$

### 性質

$x \preceq y$ のとき,
$$\sum_{z \in [x,y]} \mu(z, y) = \delta(x, y)$$

#### 証明

元の定義
$$\sum_{z \in [x,y]} \mu(x, z) = \delta(x, y)$$
を書き換えていくことで与えられた式の左辺を作ることを考える.

$$
\begin{align*}
& \sum_{z \in [x,y]} \mu(x, z) = \delta(x, y) & \text{ 定義}\\
\iff & \sum_{z \in [z',y]} \mu(z', z) = \delta(z', y) & \text{ 変数の置き換え} \\
\iff & \sum_{x \preceq z' \preceq y} \sum_{z \in [z',y]} \mu(z', z) = \sum_{z'} \delta(z', y) & z' \text{を動かす} \\
\iff & \sum_{x \preceq z' \preceq y} \sum_{z \in [z',y]} \mu(z', z) = 1 & \text{ 右辺は簡単に計算できる} \\
\iff & \sum_{x \preceq z \preceq y} \sum_{x \preceq z' \preceq z} \mu(z', z) = 1 & \text{ 気をつけて2つの Sum を交換する} \\
\iff & \sum_{x \preceq z \preceq y} k(x,z) = 1 & k(x,z) = \sum_{x \preceq z' \preceq z} \mu(z', z) \text{と置いた} \\
\end{align*}
$$

証明したいのはこの最後の $k$ について $k(x,z) = \delta(x,z)$ が成り立つということだった.
$x=z$ のときには明らか.

$$\begin{align*}
& \sum_{x \preceq z \preceq y} k(x,z) = 1 & \text{ さっきの最後の式 } \\
\iff & k(x,x) + \sum_{x \prec z \preceq y} k(x,z) = 1 \\
\iff & 1 + \sum_{x \prec z \preceq y} k(x,z) = 1 \\
\iff & \sum_{x \prec z \preceq y} k(x,z) = 0 \\
\end{align*}$$

これが一般に成り立つので, $[x, y]$ に対して,
$$\forall y' \in [x,y] ,~ y' \ne x \implies \sum_{z \in [x,y']} k(x,z) = 0$$
が言える.

この $[x,y]$ は有限の束なので $y'$ を小さいものから順に舐めていくことで
$$k(x,z) = 0$$
が言える.

以上から $k=\delta$.

## リーマン関数（ゼータ関数）

局所有限半順序集合 $E$ に対して,

$$
\zeta(x, y) = \begin{cases}
1 & \text{ if } x \preceq y \\
0 & \text{ else }
\end{cases}
$$

## 反転公式

メビウス関数とリーマン関数は次のような関係にある.
2つの関数 $f,g \colon E \to \mathbb R$ について,

$$\begin{align*}
& g(x) = \sum_{y \in E} \zeta(y,x) f(y) \\
\iff & f(x) = \sum_{y \in E} \mu(y,x) g(y) \\
\end{align*}$$

### 証明 ($\implies$)

$g(x)=$ を仮定したときに2つ目にこれを代入することで等式を確認する.

$$\begin{align*}
\sum_y \mu(y,x) g(y)
& = \sum_y \mu(y,x) \sum_z \zeta(z, y) f(z) & \text{ 仮定を代入した } \\
& = \sum_{y \preceq x} \mu(y,x) \sum_{z \preceq y} f(z) & \mu \text{ が値を持つ範囲に限定した }\\
& = \sum_{z \preceq x} f(z) \sum_{y \in [z,x]} \mu(y, x) & \text{ Sum を交換した }\\
& = \sum_{z \preceq x} f(z) \delta(y, x) & \text{ 上で述べた「性質」}\\
& = f(x) \\
\end{align*}$$

### 証明 ($\impliedby$)

全く同様に代入して確かめる.

$$\begin{align*}
\sum_y \zeta(y, x) f(y)
& = \sum_y \zeta(y,x) \sum_z \mu(z, y) g(z) & \text{ 仮定を代入した } \\
& = \sum_{y \preceq x} \sum_{z \preceq y} \mu(z, y) g(z) & \text{ それぞれ値が持つ範囲 }\\
& = \sum_{z \preceq x} g(z) \sum_{y \in [z,x]} \mu(z, y) & \text{ Sum の交換 }\\
& = \sum_{z \preceq x} g(z) \delta(z, y) & \mu \text{ の定義 }\\
& = g(x) \\
\end{align*}$$

## 例. 整除関係のメビウス関数

$1$ 以上の正整数 $\mathbb Z_{+}$ の上に
$$x \preceq y \iff x \text{ は } y \text{ を割り切る}$$
という半順序を入れる事ができる.

整数論の文脈で単にメビウス関数と言った場合はこの半順序の上のメビウス関数のこと.
ただし
$$\mu(x) = \mu(1, x)$$
と書く.

### 性質

これまでに述べてきたことにそのまま適用することで次が言える.

$$\sum_{d \preceq n} \mu(d, n) = \delta(1, n),$$
$$g(n) = \sum_{d \preceq n} f(d) \iff f(n) = \mu(d, n) g(d).$$

さて $d \preceq n$ のときに, $[d, n]$ は $[1, n/d]$ と同型なので $\mu(d,n) = \mu(1,n/d)=\mu(n/d)$ である.
というわけで,

$$\sum_{d \preceq n} \mu(n/d) = \delta(1, n),$$
$$g(n) = \sum_{d \preceq n} f(d) \iff f(n) = \mu(n/d) g(d)$$

と言い直せる.

### 定理

$1$ 以上の自然数 $n$ が相異なる $p$ 個の素数の積で表される時
$$\mu(n) = (-1)^p$$
であって, さもなくば
$$\mu(n) = 0.$$

特に $n=1$ は相異なるゼロ個の合成数だとみなす.
例えば

- $\mu(1)= 1$
- $\mu(2)= -1$
- $\mu(4)= 0$
- $\mu(5)= -1$
- $\mu(6)= 1$

これが成り立つことは次の直積を考えると楽なので後述する.

## 直積

## 直積順序

2つの半順序集合 $E_1, E_2$ について,
$$(x_1, y_1) \preceq (x_2, y_2) \iff x_1 \preceq x_2 \land y_1 \preceq y_2$$
と定めることで, 直積
$$E_1 \times E_2 := \{ (x, y) \mid x \in E_1, y \in E_2 \}$$
が定義される.

### 直積のメビウス関数

$E_1, E_2$ 及び $E_1 \times E_2$ の上に定まるメビウス関数をそれぞれ
$\mu_1, \mu_2, \mu_{1,2}$
としておくと次が成り立つ.
$$\mu_{1,2} = \mu_1 \times \mu_2,$$
すなわち
$$\mu_{1,2}((x_1, y_1), (x_2, y_2)) = \mu_1(x_1, x_2) \times \mu_2(y_1, y_2).$$

### 例. 有限集合の包含関係

有限集合 $E$ の部分集合とその $\subseteq$ は半順序の関係にあるのでメビウス関数を定める事ができる.
この包含関係は各要素についてそれを含むかどうかという順序の直積になっている.
例えば $e \in E$ について, $e$ を含まないことを $0$, 含むことを $1$ で表せば
$$(\{0,1\}, 0 \preceq 1)$$
という半順序で $e$ に関する包含関係が表される. これを $|E|$ 個だけ並べて直積を取ったのが
$\subseteq$ だと言える.

各要素 $e \in E$ に関するメビウス関数は
$$\mu(x, x) = 1,$$
$$\mu(0, 1) = -1,$$
$$\mu(1, 0) = 0.$$

直積のメビウス関数はこれの積なので,
$$\mu(X, Y) = \begin{cases}
(-1)^{|Y \setminus X|} & \text{ if } A \subseteq B \\
0 & \text{ else. }\\
\end{cases}$$

### 例. 整除関係

正整数は素因数分解をすることで, 素数の多重集合だと思うことが出来る.
例えば,

- $1 = \{\}$
- $2 = \{ 2\}$
- $3 = \{ 3\}$
- $4 = \{ 2,2\}$

とすると, $\mathbb Z_{+}$ 上の整除関係 $\preceq$ は多重集合の包含関係とみなす事が出来る.

仮に一つの素数 $p$ による合成数 $1,p,p^2,\ldots$ の上の整除関係を考える場合,
$n=p^a$ が $m=p^b$ を割り切るとは,
$$n \preceq m \iff a \leq b$$
というただの自然数の大小関係で言い換えることが出来る.

自然数の上の大小関係のメビウス関数は,

$$\mu \colon \mathbb N \times \mathbb N \to \mathbb Z$$
$$\mu(a,b) = \begin{cases}
1 & \text{ if } a = b \\
-1 & \text{ if } a + 1 = b \\
0 & \text{ else } \\
\end{cases}$$

で表される.

一般の自然数に今の話を拡張するには, 自然数を並べて直積を取ればよく,
結局 各素数の指数を見て, それが $a+1=b$ であるようなものの個数だけ $(-1)$ の累乗を取ったものになる.

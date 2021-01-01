% アダマール変換, 高速 Walsh-Hadamard 変換, xor-畳み込み
% 2020-12-05 (Sat.)
% 線形代数 競技プログラミング

$\def\ket#1{|#1\rangle}$

## アダマール変換

次で定められる $2^k \times 2^k$ 行列をアダマール行列という.

- $H_0 = \left[ \begin{array}{c} 1 \\ \end{array} \right]$
- $H_1 = \frac{1}{\sqrt{2}} \left[ \begin{array}{cc} 1 & 1 \\ 1 & -1 \\ \end{array} \right]$
- $H_{n+1} = \frac{1}{\sqrt{2^{n+1}}} \left[ \begin{array}{cc} H_n & H_n \\ H_n & -H_n \\ \end{array} \right]$

この行列が定める線形変換を **アダマール変換** という.

すなわちアダマール変換は長さ $n=2^k$ の実ベクトル（整数または複素数の上のベクトルでもよい）について
$x \mapsto H_n x$
と写す.

### 逆変換

$$H_n H_n = I_n$$
が成り立つので, $H_n$ 自身が逆行列になっている.

### 定数倍のテクニック

変換するベクトルが整数の場合であっても,
上の行列は $\sqrt{2}$ のせいで実数に写してしまう.
計算機なんかで誤差のない計算をしたい場合にはせっかくなので整数の上で計算を閉じさせたい.

- アダマール変換
    - $H_n^{\rightarrow} = \sqrt{2^{n+1}} H_n$
- 逆変換
    - $H_n^{\leftarrow} = \frac{1}{\sqrt{2^{n+1}}} H_n$

としておくことで整数の範囲で全て計算が出来る.
またこれは単に定数倍をしているだけなので, これから言うようなアダマール変換に関する性質は尚保っている.

## 高速 Walsh-Hadamard 変換

愚直に行列演算としてアダマール変換を計算するとその計算時間は $O(n^2)$ 掛かる.
一方でアダマール行列の再帰的な定義に沿って計算をすると $O(n \log n) = O(nk)$ に節約される.
その方法は
[wikipedia/Fast_Walsh-Hadamard_transform](https://en.wikipedia.org/wiki/Fast_Walsh%E2%80%93Hadamard_transform)
の図が詳しい.
また Python による実装例そのものもそこにある.

簡単に説明すれば, まず行列を 2x2 ブロックに区切って $H_1$ だと思って適用する.
次に 2x2 をひとかたまりだと思ってさらにその 2x2 ブロックを作って（全体としては 4x4）にやはり $H_1$ を適用する.
ここまでで $H_2$ を適用したことになる.
というのを最後まで繰り返していくだけ.

## xor-畳み込み

2つの, 長さ $n=2^k$ のベクトル $u,v$ について,
$$X(u,v) = H_n (H_n u \ast H_n v)$$
とする. または
$$X(u,v) = H_n^{\leftarrow} (H_n^{\rightarrow} u \ast H_n^{\rightarrow} v)$$
でも同じである.
ただしここで $\ast$ はベクトルの要素ごとの積のこととする
($a \ast b = \sum_i a_i \times b_i \ket{i}$).

このとき, 次が成り立つ:
$$X(u,v) = \sum_{i,j} u_i \times v_j \ket{i \oplus j}$$
ここで $\oplus$ は2進数の桁ごとの xor のこと.
また添字の $i,j$ は $0$ から始まって $n$ 未満までの自然数.

$n=1,2$ の場合だけ例を見る.

### $n=1$
$u=u_0 \ket{0}, v = v_0 \ket{0}$ について,
$$X(u,v) = H_0 (H_0 u \ast H_0 v) = H_0 (u \ast v) = (u \times v) \ket{0}$$
ここで $0 \oplus 0 = 0$ なので確かにそうなっている.

### $n=2$
$u=\left[ u_0, u_1 \right]^T$,
$v=\left[ v_0, v_1 \right]^T$ について,
$$\begin{align*}
X(u,v)
& = H_1^{\leftarrow} (H_1^{\rightarrow} u \ast H_1^{\rightarrow} v) \\
& =
H_1^{\leftarrow}
\left[ \begin{array}{c}
(u_0 + u_1) (v_0 + v_1) \\
(u_0 - u_1) (v_0 - v_1) \\
\end{array} \right] \\
& =
\left[ \begin{array}{c}
u_0 v_0 + u_1 v_1 \\
u_0 v_1 + u_1 v_0 \\
\end{array} \right]
\end{align*}$$

### $n > 2$

帰納法によって示すことは出来るが書くのは大変にダルいので省く.

### 補足

[how to calculate XOR (dyadic) convolution with time complexity O(n log n)](https://stackoverflow.com/questions/53591757/how-to-calculate-xor-dyadic-convolution-with-time-complexity-on-log-n)

Karatsuba 法の $+$ を $\oplus$ に置き換えたものだと思うことが出来る.

### 補足

$$H_n X(u,v) = H_n u \ast H_n v$$
と書くと, $H_n$ は畳み込みから積への準同型を与えるものだと思える.

### 補足

[/kopricky.github.io/code/FFTs/fwht.html](https://kopricky.github.io/code/FFTs/fwht.html)

によれば同じノリで or や and に関する畳み込みも可能らしい.

% トポス - 定義
% 2019-10-17 (Thu.)
% 圏論 トポス

$\def\singleton{\{\ast\}}$

## 定義

以下の性質を満たす圏を **トポス** という.

1. 終対象 $1$ があり, 積対象 $(A \times B)$ があり, 冪対象 $(A^B)$ があること
2. 始対象 $0$ があり, 余積があること
3. 後述する subobject classifier があること

2 は実は 1 と 3 から導かれるので無くても良いがあるとラク.

### subobject classifier

対象 $\Omega$ と $1$ からの射 $t \colon 1 \to \Omega$ が以下を満たす時, これを subobject classifier という.

任意の射 $f \colon A \to \Omega$ について, ちょうどただ一つの射 $g \colon B \to A$ によって,

$\require{AMScd}$
$$\begin{CD}
B @>!>> 1 \\
@VgVV   @VtVV \\
A @>f>> \Omega
\end{CD}$$

が pullback になる.
ところでこれは圏論から導かれる事実であるが, 終対象からの射 $t$ は常に mono であり,
pullback において mono の向かい側にある $g$ もまた必ず mono である.

逆に, mono 射 $g \colon B \to A$ があるとき, ちょうどただ一つの射 $f \colon A \to B$ によって,
やはり先の可換図を pullback にする.

すなわち, mono 射 $B \to A$ と射 $A \to \Omega$ の間に一対一対応がある.
ここで $g$ から $f$ への対応付を $cl$ と書く ($f = cl(g)$).

## イコール射

恒等射の積
$\Delta_A = \langle 1_A, 1_A \rangle \colon A \to A \times A$
に対して
$$cl(\Delta_A) \colon A \times A \to \Omega$$
を $(=)_A$ と定める.

## singleton 射

冪対象の定義を思い出すとそれは,
$f \colon A \times B \to C$
という射に対して
$\hat{f} \colon B \to C^A$
が自然に一対一対応するものであった.

先のイコール射をこの $f$ に代入して
$\hat{(=)_A} \colon A \to \Omega^A$
を singleton 射 $\singleton_A$ と定める.

## Set での例

トポスやイコール射, singleton 射が何を表すかは Set を考えると一番自明で分かる.

### Set はトポス

集合と写像からなる圏 Set はトポスの要件 1, 2 は明らかに満たす.
subobject classifier としては

- $\Omega = \{0,1\}$
- $t \colon 1 \to \Omega; t(\ast) = 1$

がある.
直感的には $\Omega$ は Boolean 集合, $t$ は true のことだと思えば良い.

対応 $cl$ は次のように定まる.

$f \colon A \to \Omega$ について,
$B = \{ a \in A \mid f(a) = 1 \}; g = cl^{-1}(f); g(a) = a$ （包含写像）.

mono 射（ここでは単写像）$g \colon B \to A$ について,
$f = cl(g); f(a) = \begin{cases}1 & \text{ when } \exists b \in B, g(b) = a\\ 0 & \text{ otherwise }\end{cases}$.

これは結局, 単写像とは本質的に包含写像であることを利用している.
すなわち, mono $g \colon B \to A$ について, $b \sim a \iff g(b) = a$ とすれば $B \subset A$ だと思える.
そして $cl(g)$ は $a \in A$ について, $a \in B$ かどうかを判定する述語だと見做すことが出来る.

### Set のイコール射

イコール射はどんなものになるか.
$(=)_A$ は $\Delta_A(a) = (a, a)$ の $cl$ であるから,

$$(=)_A \colon A \times A \to \Omega$$
$$(=)_A (a, b) = \begin{cases} 1 & \text{ when } \exists c \in A, (c, c) = (a, b)\\ 0 & \text{ otherwise }\end{cases}.$$

$\exists c, (c, c) = (a, b)$ ってのは結局 $a = b$ という意味だから
$$(=)_A (a, b) = \begin{cases} 1 & \text{ when } a = b\\ 0 & \text{ otherwise }\end{cases}.$$
と書いたほうがいい.
そしてこれは要するに２つの引数 $a$ と $b$ を受け取ってそれがイコールかどうかを判定する述語になっている.

### Set の singleton 射

singleton 射はイコール射の transpose.
すなわちカリー化したもののことで,

- $\singleton_A (a) = f_a \colon A \to \Omega$
- $f_a(b) = (=)_A(a, b)$

ここで $f_a$ を $\{a\}$ と書こう.
これは一つ引数を受け取ってそれが $a$ とイコールかどうかを判定する述語だと思える.

集合とは, 数を受け取って, それが所属するかどうかを判定する関数だと思うことが出来る.
今定めた
$\{a\}$
はまさにそれの要素が一つだけのバージョンに相当している.

% フーリエ級数展開, フーリエ変換, ラプラス変換
% 2026-01-06 (Tue.)
% 三角関数 積分変換 微分方程式

## index

<div id=toc-level-2></div>

$$
\require{amscd}
\def\F{\mathcal F}
\def\L{\mathcal L}
$$

## 関数空間

適当に定めた区間 $[a, b]$ の上で定められた実関数の系列

$$\left( \phi_0(t), \phi_1(t), \phi_2(t), \ldots \right)$$

を基底とする空間を考える.
この空間に属する実関数 $f(t)$ は次のように表される.
$$f(t) = \sum_{n=0}^{\infty} a_n \phi_n(t)$$
ここで $a_n$ は実係数.

さらに **直交基底** であるとは, 次の直交性条件を満たすとする.

$$i \ne j \iff \int_{a}^{b} \phi_i(t) \phi_j(t) dt = 0$$

この積分のことを $(\phi_i, \phi_j)$ と書いて **内積** と呼ぶ.

$$(\phi_i, \phi_j) := \int_{a}^{b} \phi_i(t) \phi_j(t) dt$$

このような場合 $f(t)$ の係数 $a_n$ は次で与えられる.

$$\int_a^b f(t) \phi_n(t) dt = \int_a^b \left( \sum_{m=0}^{\infty} a_m \phi_m(t) \right) \phi_n(t) dt = \sum_{m=0}^{\infty} a_m \int_a^b \phi_m(t) \phi_n(t) dt = a_n \int_a^b \phi_n(t)^2 dt$$

従って

$$a_n = \frac{(f, \phi_n)}{(\phi_n, \phi_n)}$$

## フーリエ級数展開

区間 $[-\pi, \pi]$ で

$$\left( 1, \cos t, \sin t, \cos 2t, \sin 2t, \cos 3t, \sin 3t, \ldots \right)$$

は直交系である. これを基底とする関数空間を考える.

周期 $2\pi$ の実関数 $f(t)$ は次で表される.

$$f(t) = \frac{a_0}{2} + \sum_{n=1}^{\infty} \left( a_n \cos (nt) + b_n \sin (nt) \right)$$

これを **フーリエ級数展開** と呼ぶ.

> 計算のしやすさのために定数項だけ $\frac{a_0}{2}$ としている.

係数 $a_n, b_n$ は関数の直交性から次で与えられる.

- $a_n = \frac{1}{\pi} \int_{-\pi}^{\pi} f(t) \cos (nt) dt$
    - 特に $a_0 = \frac{1}{\pi} \int_{-\pi}^{\pi} f(t) dt$
- $b_n = \frac{1}{\pi} \int_{-\pi}^{\pi} f(t) \sin (nt) dt$

### 収束条件

ただし収束条件がある.

**Dirichlet 条件**

- 区間内で絶対可積分である
    - $\int_{-\pi}^{\pi} |f(t)| dt \lt \infty$
- 区間内で高々有限個の極値・不連続点を持つ

### 例: 矩形波のフーリエ級数展開

$$f(t) = \begin{cases}
0 & -\pi \leq t \lt 0 \\
1 & 0 \leq t \lt \pi \\
\end{cases}$$

の周期関数のフーリエ級数展開を求める.

- $a_0 = \frac{1}{\pi} \int_{-\pi}^{\pi} f(t) dt = \frac{1}{\pi} \int_{0}^{\pi} 1 dt = 1$
- $a_n = \frac{1}{\pi} \int_{-\pi}^{\pi} f(t) \cos (nt) dt = \frac{1}{\pi} \int_{0}^{\pi} \cos (nt) dt = 0$ ($n \geq 1$)
- $b_n = \frac{1}{\pi} \int_{-\pi}^{\pi} f(t) \sin (nt) dt = \frac{1}{\pi} \int_{0}^{\pi} \sin (nt) dt = \begin{cases}
\frac{2}{n \pi} & n: \text{奇数} \\
0 & n: \text{偶数} \\
\end{cases}$

したがって

$$\begin{align*}
f(t)
& = \sum_{k=0}^{\infty} \frac{2}{(2k+1)\pi} \sin((2k+1)t) \\
& = \frac{1}{2} + \frac{2}{\pi} \sin(\pi) + \frac{2}{3\pi} \sin(3\pi) + \frac{2}{5\pi} \sin(5\pi) + \cdots \\
\end{align*}$$

がフーリエ級数展開として得られる.

以下は $k$ を有限に打ち切った場合に $f$ に近づく様子を示すグラフである.

```@gnuplot
set xrange [-pi:pi]
set key bottom right
set grid

f1(x) = 0.5 + sin(x) * 2 / pi
f2(x) = f1(x) + sin(3*x) * 2 / 3.0 / pi
f3(x) = f2(x) + sin(5*x) * 2 / 5.0 / pi
f4(x) = f3(x) + sin(7*x) * 2 / 7.0 / pi
f5(x) = f4(x) + sin(9*x) * 2 / 9.0 / pi
f6(x) = f5(x) + sin(11*x) * 2 / 11.0 / pi

plot f2(x) title 'k=0,1', \
     f4(x) title 'k=0,1,2,3', \
     f6(x) title 'k=0,1,2,3,4,5'

```

#### ギブス現象

フーリエ級数展開は不連続点の近傍で振動を伴いながら収束する. これを **ギブス現象** と呼ぶ.
有限項で打ち切った場合, 不連続点での関数値から約 $9\%$ 大きい値を取る
([[https://ja.wikipedia.org/wiki/%E3%82%AE%E3%83%96%E3%82%BA%E7%8F%BE%E8%B1%A1]]).

## 複素フーリエ級数展開

ここから $i$ とは虚数単位を表すものとする.

オイラーの公式

$$e^{i\theta} = \cos \theta + i \sin \theta$$

を用いると

$$\cos (nt) = \frac{e^{int} + e^{-int}}{2}$$
$$\sin (nt) = \frac{e^{int} - e^{-int}}{2i}$$

これをフーリエ級数展開に代入すると

$$f(t) = \frac{a_0}{2} e^{0} + \sum_{n=1}^{\infty} \left( \frac{a_n - ib_n}{2} e^{int} + \frac{a_n + ib_n}{2} e^{-int} \right)$$

これらの係数を複素係数 $c_n$ と名前を付け替えることで

$$f(t) = \sum_{n=-\infty}^{\infty} c_n e^{int}$$

と簡潔に表せる.
$n$ の範囲が負及び $0$ まで拡張されたことに注意.
これを **複素フーリエ級数展開** と呼ぶ.

これは
$\left( 1, e^{it}, e^{-it}, e^{2it}, e^{-2it}, e^{3it}, e^{-3it}, \ldots \right)$
を基底とする関数空間と思えるが,
直交性は **満たしていない**.
代わりに次の性質がある.

$$j = -k \iff (e^{ijt}, e^{ikt}) = \int_{-\pi}^{\pi} e^{ijt} e^{-ikt} dt = 2\pi$$
$$j \ne -k \iff (e^{ijt}, e^{ikt}) = \int_{-\pi}^{\pi} e^{ijt} e^{-ikt} dt = 0$$

したがって $c_n$ を求めたかったら $e^{-int}$ と内積を取ればよい.

$$c_n = \frac{1}{2\pi} \int_{-\pi}^{\pi} f(t) e^{-int} dt$$

## フーリエ変換

周期の区間 $[\pi, \pi]$ を $[-L, L]$ に拡張するのは容易で $t$ 軸を $L / \pi$ 倍すればよい.

$$f(t) = \sum_{n=-\infty}^{\infty} c_n e^{i n \pi t / L}$$
$$c_n = \frac{1}{2L} \int_{-L}^{L} f(t) e^{-i n \pi t / L} dt$$

ここで $L \to \infty$ という極限を考えることで, 周期関数ではない関数も表したい.
非周期関数とは区間 $(-\infty, \infty)$ で定義された周期関数のことと言えるから.

まず（大きな）$L$ に対して $\omega_n = n \pi / L$ とおくと, $\Delta \omega = \pi / L$ であるから

$$\begin{align*}
f(t)
& = \sum_{n=-\infty}^{\infty} c_n e^{i \omega_n t} \\
& = \sum_{n=-\infty}^{\infty} c_n \Delta \omega \frac{e^{i \omega_n t}}{\Delta \omega} \\
& = \frac{1}{2\pi} \sum_{n=-\infty}^{\infty} \left( \int_{-L}^{L} f(\tau) e^{-i \omega_n \tau} d\tau \right) e^{i \omega_n t} \Delta \omega
\end{align*}$$

極限 $L \to \infty$ を取ると, 右辺はリーマン和の形になるから積分に変わる.

$$f(t) = \frac{1}{2\pi} \int_{-\infty}^{\infty} \left( \int_{-\infty}^{\infty} f(\tau) e^{-i \omega \tau} d\tau \right) e^{i \omega t} d\omega$$

そこで積分の中身を持ってきて

$$\hat{f}(\omega) = \int_{-\infty}^{\infty} f(\tau) e^{-i \omega \tau} d\tau$$

と定義する.
この $f$ から $\hat{f}$ への変換を **フーリエ変換** と呼ぶ.
$\F$ と書いて $\hat{f} = \F(f)$ と言うことにする.
この実数 $\omega$ は角周波数と呼ばれる.

そして

$$f(t) = \frac{1}{2\pi} \int_{-\infty}^{\infty} \hat{f}(\omega) e^{i \omega t} d\omega$$

を **逆フーリエ変換** と呼ぶ.
$\F^{-1}$ と書いて $f = \F^{-1}(\hat{f})$ と言うことにする.

ちなみに係数のつき方には流儀があるようで, 例えばフーリエ変換にも逆フーリエ変換にも $\frac{1}{\sqrt{2\pi}}$ をつける方法もあり, そうするとフーリエ変換と逆フーリエ変換の形が対称になるので, そちらの方が好まれる場合もある.


### Note

$f$ は実関数 $\mathbb{R} \to \mathbb{R}$ であるが, $\hat{f}$ は複素関数 $\mathbb{R} \to \mathbb{C}$ になることに注意.

$$\begin{CD}
\mathbb{R}^{\mathbb R} @>\F>> \mathbb{C}^{\mathbb R} \\
@. @. \\
\mathbb{R}^{\mathbb R} @<\F^{-1}<< \mathbb{C}^{\mathbb R} \\
\end{CD}$$

### 微分則

実関数 $f(t)$ の導関数を $f'(t)$ と書く.

$$\F(f') = \int_{-\infty}^{\infty} f'(t) e^{-i \omega t} dt$$

を部分積分することで

$$\begin{align*}
\F(f')
& = \left[ f(t) e^{-i \omega t} \right]_{-\infty}^{\infty} - (-i \omega) \int_{-\infty}^{\infty} f(t) e^{-i \omega t} dt \\
\end{align*}$$

ここで $\lim_{t \to \pm \infty} f(t) = 0$ と仮定すると, 境界項は $0$ になるから

$$\F(f') = i \omega \F(f)$$

を得る.

$$
\require{amscd}
\begin{CD}
\mathbb{R}^{\mathbb R} @>\F>> \mathbb{C}^{\mathbb C} \\
@V{d/dt}VV               @Vi\omega VV   \\
\mathbb{R}^{\mathbb R} @>\F>> \mathbb{C}^{\mathbb C} \\
\end{CD}
$$

実関数の微分とはフーリエ変換の世界では $i \omega$ 倍すること.

### 畳み込み

2つの実関数 $f(t), g(t)$ に対して, この2つの関数の **畳み込み** を次で定める.

$$(f \ast g)(t) = \int_{-\infty}^{\infty} f(\tau) g(t - \tau) d\tau$$

これのフーリエ変換は次のようになる.

$$\begin{align*}
\F(f \ast g)
& = \int_{-\infty}^{\infty} \left( \int_{-\infty}^{\infty} f(\tau) g(t - \tau) d\tau \right) e^{-i \omega t} dt \\
& = \int_{-\infty}^{\infty} f(\tau) \left( \int_{-\infty}^{\infty} g(t - \tau) e^{-i \omega t} dt \right) d\tau \\
& = \int_{-\infty}^{\infty} f(\tau) \left( \int_{-\infty}^{\infty} g(u) e^{-i \omega (u + \tau)} du \right) d\tau \quad (u = t - \tau) \\
& = \int_{-\infty}^{\infty} f(\tau) e^{-i \omega \tau} d\tau \int_{-\infty}^{\infty} g(u) e^{-i \omega u} du \\
& = \F(f) \cdot \F(g) \\
\end{align*}$$

というわけで

$$
\require{amscd}
\begin{CD}
\mathbb{R}^{\mathbb R} \times \mathbb{R}^{\mathbb R} @>\F>> \mathbb{C}^{\mathbb C} \times \mathbb{C}^{\mathbb C} \\
@V{(\ast)}VV               @V(\cdot) VV   \\
\mathbb{R}^{\mathbb R} @>\F>> \mathbb{C}^{\mathbb C} \\
\end{CD}
$$

を得た.

## ラプラス変換

フーリエ変換は $(-\infty, \infty)$ で絶対可積分でないと扱えなかった.
特に無限大に発散する関数は扱えない.
そこで $e^{-st}$ という減衰因子を導入することで,
任意の有限区間で可積分であれば扱えるようにしたのが **ラプラス変換** である.

> Wikipedia 情報なんだけど,
> 工学的な手法としての発展は 1899 年にオリヴィエ・ヘヴィサイドがフーリエ変換を基にしてヘヴィサイドの演算子法を導入した.
> ただし後から, （フーリエ変換よりも前に）ラプラスによって類似の変換が導入されていたことが指摘され,
> ラプラス変換の名前で理論が整理された.

フーリエ変換は
$$\F(f) = \hat{f}(\omega) = \int_{-\infty}^{\infty} f(t) e^{-i \omega t} dt$$

であった.
ここで $\omega$ は実数であったが, ここを一般化して複素数 $s = \sigma + i \omega$ で置き換えた

$$F(s) = \int_{-\infty}^{\infty} f(t) e^{-st} dt$$

これが **（両側）ラプラス変換** である.
**（片側）ラプラス変換** では定義域を $(0, \infty)$ に制限する.

$$F(s) = \int_{0}^{\infty} f(t) e^{-st} dt$$

> むしろフーリエ変換とはラプラス変換の特別な場合だったのだと見なせる.

ラプラス変換の操作を $\L$ と書いて $F = \L(f)$ と言うことにする.

また, $F$ から $f$ を復元する操作を **逆ラプラス変換** と呼び, $\L^{-1}$ と書いて $f = \L^{-1}(F)$ と言うことにする.

### 収束領域

有限区間で可積分な $(0, \infty)$ 上の実関数 $f$ について $F(s) = \L(f)$ は,
ある $c$ があって

$$\mathrm{Re}(s) \gt c \implies F(s) \text{は定まる}$$

という収束領域を持つ.
従ってある適当な $s_0$ で実際に $F(s_0)$ が定まったなら,

$$\mathrm{Re}(s) \geq \mathrm{Re}(s_0) \implies F(s) \text{は定まる}$$

と言える.

### 例. 定数関数のラプラス変換

$f(t) = a$ ($a$ は実定数) の場合を考える.

$$F(s) = \int_{0}^{\infty} a e^{-st} dt = a \left[ \frac{e^{-st}}{-s} \right]_{0}^{\infty}$$

もし $\mathrm{Re}(s) \gt 0$ ならば, $\lim_{t \to \infty} e^{-st} = 0$ であるから

$$F(s) = \frac{a}{s} \quad (\mathrm{Re}(s) \gt 0)$$

### 例. 指数関数のラプラス変換

$f(t) = e^{a t}$ ($a$ は実定数) の場合を考える.

$$F(s) = \int_{0}^{\infty} e^{a t} e^{-s t} dt = \int_{0}^{\infty} e^{-(s - a) t} dt = \left[ \frac{e^{-(s - a) t}}{-(s - a)} \right]_{0}^{\infty}$$

もし $\mathrm{Re}(s) \gt a$ ならば, $\lim_{t \to \infty} e^{-(s - a) t} = 0$ であるから

$$F(s) = \frac{1}{s - a} \quad (\mathrm{Re}(s) \gt a)$$

### 微分則

$f$ が微分可能で $\lim_{t \to \infty} f(t) e^{-s t} = 0$ と仮定する.

$$\begin{align*}
\L(f')
&= \int_{0}^{\infty} f'(t) e^{-s t} dt \\
&= \left[ f(t) e^{-s t} \right]_{0}^{\infty} + s \int_{0}^{\infty} f(t) e^{-s t} dt \\
&= s \L(f) - f(0) \\
\end{align*}$$

さらに $\lim{t \to \infty} f'(t) e^{-s t} = 0$ と仮定すれば,

$$\L(f'') = s^2 \L(f) - s f(0) - f'(0)$$

一般の $n$ 次導関数についても同様にして

$$\L(f^{(n)}) = s^n \L(f) - s^{n-1} f(0) - s^{n-2} f'(0) - \cdots - f^{(n-1)}(0)$$

### 畳み込み

2つの実関数 $f(t), g(t)$ に対して, 次が畳み込みであった.

$$(f \ast g)(t) = \int_{0}^{t} f(\tau) g(t - \tau) d\tau$$

これのラプラス変換は次のようになる.

$$\begin{align*}
\L(f \ast g)
&= \int_{0}^{\infty} \left( \int_{0}^{t} f(\tau) g(t - \tau) d\tau \right) e^{-s t} dt \\
&= \int_{0}^{\infty} f(\tau) \left( \int_{\tau}^{\infty} g(t - \tau) e^{-s t} dt \right) d\tau \\
&= \int_{0}^{\infty} f(\tau) \left( \int_{0}^{\infty} g(u) e^{-s (u + \tau)} du \right) d\tau \quad (u = t - \tau) \\
&= \int_{0}^{\infty} f(\tau) e^{-s \tau} d\tau \int_{0}^{\infty} g(u) e^{-s u} du \\
&= \L(f) \cdot \L(g) \\
\end{align*}$$

フーリエ変換と同様の結果を得た.

### 基本的な性質

**線形性**
ラプラス変換は線形変換である.
$$\L(af + bg) = a \L(f) + b \L(g)$$

**スケーリング則**
$f(t)$ のラプラス変換を $F(s) = \L(f)$ とする.
すると, 任意の実数 $a \gt 0$ に対して
$$\L(f(at)) = \frac{1}{a} F\left( \frac{s}{a} \right)$$

**周波数シフト則**
$f(t)$ のラプラス変換を $F(s) = \L(f)$ とする.
すると, 任意の実数 $a$ に対して
$$\L\left( e^{a t} f(t) \right) = F(s - a)$$

**積分則**

$$\L\left( \int_0^t f(\tau) d\tau \right) = \frac{1}{s} F(s)$$

### 基本的なラプラス変換表

| $f(t)$               | $F(s) = \L(f)$                | 収束領域               |
|----------------------|-------------------------------|------------------------|
| $1$                  | $\frac{1}{s}$                 | $\mathrm{Re}(s) \gt 0$ |
| $t^n$ ($n$ は非負整数) | $\frac{n!}{s^{n+1}}$          | $\mathrm{Re}(s) \gt 0$ |
| $e^{a t}$            | $\frac{1}{s - a}$             | $\mathrm{Re}(s) \gt a$ |
| $\sin (a t)$         | $\frac{a}{s^2 + a^2}$         | $\mathrm{Re}(s) \gt 0$ |
| $\cos (a t)$         | $\frac{s}{s^2 + a^2}$         | $\mathrm{Re}(s) \gt 0$ |
| $\sinh (a t)$        | $\frac{a}{s^2 - a^2}$         | $\mathrm{Re}(s) \gt |a|$ |
| $\cosh (a t)$        | $\frac{s}{s^2 - a^2}$         | $\mathrm{Re}(s) \gt |a|$ |
| $u(t - a)$           | $\frac{e^{-a s}}{s}$          | $\mathrm{Re}(s) \gt 0$ |
| $\delta(t - a)$      | $e^{-a s}$                    | 全複素平面              |
| $t f(t)$             | $- \frac{d}{ds} F(s)$         | 同左                   |

ここで $u(t - a)$ は単位ステップ関数, $\delta(t - a)$ はデルタ関数を表す.

### 逆フーリエ変換の練習

逆フーリエ変換は上に列挙した性質にしたがって **因数分解** をし,
そして上に書いた基本的なラプラス変換表を **逆にたどる** ことで求められる.

$$\begin{align*}
L^{-1}\left( \frac{1}{s^2 + 25} \right)
&= L^{-1}\left( \frac{1}{5} \frac{5}{s^2 + (5)^2} \right) \\
&= \frac{1}{5} L^{-1}\left( \frac{5}{s^2 + (5)^2} \right) \\
&= \frac{1}{5} \sin(5 t) \\
\end{align*}$$

$$\begin{align*}
L^{-1}\left( \frac{5}{s(s^2 + 25)} \right)
&= L^{-1}\left( \frac{1}{s} \cdot \frac{5}{s^2 + (5)^2} \right) \\
&= 1 \ast \sin(5 t) & \text{ 畳み込み} \\
&= \int_0^t \sin(5 \tau) d\tau \\
&= \frac{1}{5} (1 - \cos(5 t)) \\
\end{align*}$$

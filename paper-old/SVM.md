% Support Vector Machine (SVM)
% http://www.cs.cornell.edu/People/tj/svm_light/#References
% 機械学習 分類器

## INDEX
<div id=toc></div>

## 実装

- [SVM-Light Support Vector Machine](http://svmlight.joachims.org/)
    - SVM 関連の論文をいくつか出してる Joachims さんによる実装
- [LIBSVM -- A Library for Support Vector Machines](https://www.csie.ntu.edu.tw/~cjlin/libsvm/)
    - 稀に良くwebページが落ちてる
    - 同梱された `grid.py` がよく使われる
- [LIBLINEAR -- A Library for Large Linear Classification](https://www.csie.ntu.edu.tw/~cjlin/liblinear/)
    - 線形カーネルに特化した版

## 動機

線形分類器とは次のようなものであった.
$x_i \in \mathbb{R}^n$, $y_i \in \{+1, -1\}$ に対して、
データ $\{(x_i, y_i)\}_{i=1,2,\ldots,N}$ の超平面による線形分離を考える.
すなわち、$\mathbb{R}^n$ 上のある超平面

$$f(x) = w x - b = 0$$

を定め
点 $x$ がこれより上にあるか下にあるか
(これは $f(x)$ の正負を調べることに等しい)
によって
$y$ を予測する.

$$\begin{cases}
f(x_i) > 0 \iff y_i = +1\\
f(x_i) < 0 \iff y_i = -1
\end{cases}$$

さて、一般に線形分離するような超平面は唯ひとつに定まらない.
なぜなら、分離する超平面を得た時に、それを僅かに傾きを変化させてもたいていの場合、線形分離していることを保つから.

超平面と、データ $x_i$ までの距離の最小値をマージンと呼び、
SVM ではマージンを最大化するような超平面を求めることを目標にする.
これが直感的に良い気がするからである.

## notation

先ではさらっとベクトルの内積を $wx$ と書いたが、これからはベクトルの内積を

$$\langle w,x \rangle$$

と書く.

超平面に関してだが、法線ベクトル $w \in \mathbb{R}^n$ とバイアス (スカラー) $b$
を用いて

$$f(x) = \langle w, x \rangle - b$$

と書くが、数式の簡潔さの為に、バイアス項を無視することにする.

$$f(x) = \langle w, x \rangle$$

これは次のように解釈すれば一般性を失っていない.
すなわち、
ベクトル $w$ の最後に $b$ を追加し、
$x$ の最後に $-1$ を追加するのである.
この時点で $w, x \in \mathbb{R}^{n+1}$
である.

- $w \leftarrow \left[ w; b \right]$
- $x \leftarrow \left[ x; -1 \right]$

基本的にバイアス項は無視して書くが、一箇所だけ、一度バイアス項アリの形に変形することがある.
本来そんなことしなくても良いはずだけど、私が上手い導出を思いつかなかったので、ごまかし.

## 目的関数

### 主問題

法線ベクトル $w$ を持つ超平面とデータ $x$ との距離は

$$\frac{|\langle w, x \rangle|}{|w|}$$

$w$ をスカラー倍しても超平面は変わらないので、超変面との距離が最小なデータを $x_i$ とするとき、
適当にスカラー倍することで

$$|\langle w, x_i \rangle| = 1$$

としてよい.
より強い制約として、全てのデータ $x_i$ に関して

$$\forall i, |\langle w, x_i \rangle| \geq 1$$

を要請することにする.
そしてこのときにマージンの最大化とは、$1 / |w|$ の最大化、即ち $|w|$ の最小化に等しい.
計算の都合上、
$\frac{1}{2} |w|^2$ の最小化とする.

$|\langle w, x_i \rangle| \geq 1$ は
ラベルを $y_i = +1, -1$ としたことから次のように書き直せる:

$$y_i \cdot \langle w, x_i \rangle \geq 1$$

以上をまとめると、
不等号な制約付きの最適化問題になる.

- minimize $\frac{1}{2} |w|^2$
- s.t.  $y_i \cdot \langle w, x_i \rangle \geq 1$

これをSVMの主問題という.
実際にはこれを直接解かずに、同値な、双対問題に書きなおしたものを解く.

### 双対表現

双対問題はラグランジュの未定乗数法を用いて導かれる.
すなわち、

- maximize $L(w, \lambda) = \frac{1}{2} |w|^2 - \sum_i \lambda_i \left( y_i \cdot \langle w, x_i \rangle - 1 \right)$
- s.t. $\lambda_i \geq 0$

$\frac{\partial L}{\partial w} = 0$ を解くと
$w = \sum_i \lambda_i y_i x_i$
を得る.
これを $L(w, \lambda)$ に代入すると:

$$\begin{align}
L(\lambda)
& = \sum_i \lambda_i - \frac{1}{2} \sum_i \sum_j \lambda_i \lambda_j y_i y_j \langle x_i, x_j \rangle\\
& = \sum_i \lambda _i - \frac{1}{2} |w|^2
\end{align}$$

ここからちょっと、上手い導出を私が思いつかなかったので、
一度バイアス項アリの形に直すと、
$L(w,\lambda)$
は

$$L(w, b, \lambda) = \frac{1}{2} |w|^2 - \sum_i \lambda_i \left( y_i \cdot (\langle w, x_i \rangle -b) - 1 \right)$$

である.
これについて
$\frac{\partial L(w,\lambda)}{\partial b}=0$
を解けば、

$$\sum_i \lambda_i y_i = 0$$

を得る.

以上をまとめて、次のような最適化問題を得る.
これをSVMの双対問題という.

- maximize $L(\lambda) = \sum_i \lambda _i - \frac{1}{2} |w|^2$
- s.t. $\lambda_i \geq 0$, $\sum_i \lambda_i y_i = 0$

これを解いたとき、
$w = \sum_i \lambda_i y_i x_i$
によって超平面を復元することが出来る.

後述する "カーネル拡張" を用いる場合等、
原理的に、
主問題は解けず、双対問題を解いて
$(\lambda_i, y_i, x_i)$
を、学習結果として保存することになる.

## カーネル拡張

以上説明してきた SVM は所詮、線形分類器の拡張に過ぎない.
これを **線形 SVM** (linear SVM) という.
SVM をより良く知らしめたのは寧ろカーネル拡張が出来ることにある.
"カーネル拡張" という言葉はたぶん SVM で初めて提唱されたもの.

### カーネル拡張とは何か

線形分類をするためには、データが適当な超平面によって線形分離できなければならないが、現実の観測データがいつでもそうあるわけではない.
しかし、適当な関数 $\phi$ によって、
データセット
$D = \{ (x_i, y_i) \}$
を
$D' = \{ (\phi(x_i), y_i) \}$
に写したとする.
$D$ は線形分類不能であったが $D'$ では可能となることがしばしばある.

線形分類器がどんなだったかを改めて思い出すと、
データセット $D = \{x_i\}$ があって、これから導かれた超平面 $w$ によって

$$y(x) = \langle w, x \rangle$$

とする.
双対表現から分かることとして、
$w$ は、ある $\lambda_i$ によって

$$w = \sum_i \lambda_i y_i x_i$$

と書ける.
これを代入すると、

$$y(x) = \sum_i \lambda_i y_i \langle x_i, x \rangle$$

SVMに限らず、線形分類器とは一般にこういうものである.
では、データ点を全て $\phi$ によって写すとする.
即ち、学習データの $x_i$ も、これから予測しようとする $x$ も $\phi$ によって別な空間に写そう.

$$y(x) = \sum_i \lambda_i y_i \langle \phi(x_i), \phi(x) \rangle$$

となる.
更には、

$$\kappa(x_1, x_2) = \langle \phi(x_1), \phi(x_2) \rangle$$

なる関数 $\kappa$ を定義すると

$$y(x) = \sum_i \lambda_i y_i \kappa(x_i, x)$$

と書ける.
この $\kappa$ のことを、カーネルと呼ぶ.
$\phi$ を恒等関数とすれば $\kappa$ はベクトルの内積そのものだから、
カーネルとは内積の拡張だと言えそうだ.

というわけで、
$y(x) = \sum_i \lambda_i y_i \langle x_i, x \rangle$
の代わりに、
$y(x) = \sum_i \lambda_i y_i \kappa(x_i, x)$
をとするのを、
カーネル拡張という.

カーネル拡張の良さは、
まず $\phi$ で写すことで線形分離が可能になるかもしれないこと.
それから、もはや式に $\phi$ は出てきて無くて、$\kappa$ しかないので、
$\phi$ ではなく $\kappa$ を直接定めればよい.
$\phi$ を取ってから内積を取るという計算を省略できる可能性がある.
ベクトルの内積を取るという手続きは、計算量的にコストが高いから.

### rbf カーネル

名高いカーネルとして、rbf カーネル (Gaussian カーネル) がある.

$$\kappa(x_1, x_2) = \exp \left[ -\gamma \| x_1 - x_2 \|^2 \right]$$

実は、この $\kappa$ に対して適切な $\phi$ は存在しない.


# ユニタリー変換

{{#include macro.tex}}

## qbit の数ベクトル表示

\\(n\\) qbit が取り得る状態は \\(2^n\\) つの基底
$$|0\ldots 000\rangle,~
|0\ldots 001\rangle,~
|0\ldots 010\rangle,~
\ldots ,~
|1\ldots 111\rangle$$
の線型結合
$$\sum \alpha_{i_1,i_2,\ldots,i_n} \ket{i_1 i_2 \cdots i_n}$$
で表される.
ここでこの qbit の状態を
$$\left[\begin{array}{c}
\alpha_{0\ldots 000}\\
\alpha_{0\ldots 001}\\
\alpha_{0\ldots 010}\\
\ldots \\
\alpha_{1\ldots 111}
\end{array}\right] \in \mathbb C^{2^n}$$
で表示する.

## ユニタリ変換

複素正方行列 \\(U\\) で
$$U^\dagger U = UU^\dagger = I$$
を満たす行列をユニタリ行列という.
ここで \\(I\\) は単位行列,
\\(U^\dagger\\) は成分の共役を取って転置した行列のこと \\((U^\dagger = (U^*)^T)\\).

### 性質

2つのユニタリ行列 \\(U,V\\) の積 \\(UV\\) もユニタリ行列.

### 定理

任意のユニタリ変換を再現する量子ゲートが存在する.

ここでユニタリ変換とは, qbit を数ベクトル表示したときに右からユニタリ行列を掛ける操作のことを言う.
$$
\left[\begin{array}{c}
\beta_{0\ldots 000}\\\\
\beta_{0\ldots 001}\\\\
\beta_{0\ldots 010}\\\\
\ldots \\\\
\beta_{1\ldots 111}
\end{array}\right] =
U
\left[\begin{array}{c}
\alpha_{0\ldots 000}\\\\
\alpha_{0\ldots 001}\\\\
\alpha_{0\ldots 010}\\\\
\ldots \\\\
\alpha_{1\ldots 111}
\end{array}\right]$$
は qbit \\(\alpha\\) を量子ゲート \\(U\\) に通した結果 qbit \\(\beta\\) を得る操作を表す.
逆に \\(U\\) がユニタリ行列であるならば, 量子ゲートで必ず再現できる.

このような行列 \\(U\\) の大きさは \\(2^n \times 2^n\\) と, 2のべき乗でないといけないが,
実際には気にする必要はない.
一般の \\(m\\) (\\( 2^{n-1} \lt m \leq 2^n \\)) について,
ユニタリー行列 \\(U \in \mathbb{C}^{m\times m}\\) に \\(2^n-m\\) 個, サイズを広げて,
$$U' = \left[\begin{array}{ccccc}
 & & & & \\\\
 & U & & & \\\\
 & & & & \\\\
 & & & 1 & \\\\
 & & & & 1
\end{array}\right]$$

広げた部分は対角に \\(1\\) を置いてできる行列 \\(U'\\) も問題なくユニタリー行列.

\\(n\\) qbit であるが実際には \\(2^n\\) 状態の内 \\(m\\) 状態しか取り得ないようなもの長さ \\(m\\) の列ベクトルで表現でき, \\(m \times m\\) 行列 \\(U\\) で, 操作を記述すればよい.
実際には余白を \\(0\\) で埋めた長さ \\(2^n\\) の列ベクトルを \\(2^n \times 2^n\\) 行列 \\(U'\\) で操作したものだとすれば問題ない.

### 例: 量子 NOT

量子NOTというゲート \\(X\\) は
\\(\alpha |0\rangle + \beta |1\rangle\\) を
\\(\beta |0\rangle + \alpha |1\rangle\\) に写す.

即ち
$$\left[\begin{array}{c}
\beta\\\\
\alpha
\end{array}\right] =
X
\left[\begin{array}{c}
\alpha\\\\
\beta
\end{array}\right]$$
となれば良いが, これは
$$X = \left[\begin{array}{cc} 0 & 1\\\\ 1 & 0 \end{array}\right]$$
であってユニタリ行列になっている.

### 例: 制御 NOT

次のようになっていることがすぐ分かる.
ただし基底として, 順に
\\( \ket{00}, \ket{01}, \ket{10}, \ket{11} \\).

$$\left[\begin{array}{cc}
1 & & & \\\\
& 1 & & \\\\
& & & 1 \\\\
& & 1 &
\end{array}\right]$$
これもやはりユニタリー行列である.

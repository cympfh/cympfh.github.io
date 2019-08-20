# 量子並列性とドイチュのアルゴリズム

{{#include macro.tex}}

## 量子並列性

\\(n\\) qbit の基底の状態 \\(\ket{ij\ldots k}\\) を普通の古典 \\(n\\) bit \\(i,j,\ldots,k\\) と同一視する.
\\(n\\) bit を入力にして 1 bit を出力する古典回路 \\(f\\) について,
同程度の効率で計算できる次のような量子ゲート \\(U_f\\) が存在する:
$$U_f (x \otimes \ket{i}) = x \otimes \ket{i \oplus f(x)}$$
ここで \\(x\\) は \\(n\\) qbit.
\\(i\\) は \\(0\\) または \\(1\\) (もちろん) で, \\(\oplus\\) は排他的論理和.

さて, アダマールゲートを用いれば2つの状態を全く同等に含んだ量子を作れるのだった.
それを \\(U_f\\) に通すことで,
**実質的に** \\(f(0)\\) と \\(f(1)\\) を並列に計算するようなことができる.
具体的には次を実行する.

1. \\(H |0\rangle\\) に \\(|0\rangle\\) を並べる
    - \\((H \ket{0}) \otimes \ket{0} = \frac{1}{\sqrt{2}} \ket{00} + \frac{1}{\sqrt{2}} \ket{10}\\)
1. これを \\(U_f\\) に通す
    - \\(\frac{1}{\sqrt{2}} |0, f(0)\rangle + \frac{1}{\sqrt{2}} |1, f(1)\rangle\\)

一度の \\(U_f\\) の計算で \\(f(0)\\) と \\(f(1)\\) が行われているのが分かる.
この性質を **量子並列性** という.
ただし, これをこのまま観測するだけでは結局そのどちらか
\\(|x, f(x)\rangle\\)
しか得られない.
並列性のメリットを享受するには工夫が必要である.
その古典的な一例であるドイチュのアルゴリズムを次に見る.

## ドイチュのアルゴリズム (Deutsch's algorithm)

1 bit から 1 bit を出力する古典回路 \\(f\\) について,
\\(f(0) \oplus f(1)\\) を一度の \\(U_f\\) (\\(f\\) 相当の計算) で計算することができる.

アルゴリズムは次の通り:

1. \\(|+\rangle = H |0\rangle\\) と \\(|-\rangle = H |1\rangle\\) を得る
    - これを並べたものを \\(\ket{+-} = \ket{+} \otimes \ket{-}\\) とする
1. \\(|\phi_1, \phi_2 \rangle = U_f \ket{+-}\\)
1. \\(H \ket{\phi_1, \phi_2} = H \ket{\phi_1} \otimes H\ket{\phi_2}\\) を計算して 1 qbit 目を観測する

具体的に計算を追う.

1. \\(\ket{+-} = \ket{+} \otimes \ket{-} = \frac{1}{2} (\ket{00} - \ket{01} + \ket{10} - \ket{11})\\)
1. \\(U_f \ket{+-} = \frac{1}{2} (|0,f(0)\rangle -|0,1-f(0)\rangle +|1,f(1)\rangle -|1,1-f(1)\rangle)\\)
1. \\(H(U_f \ket{+-}) = \frac{1}{2} \left[ (\ket{+} \otimes H\ket{f(0)}) - (\ket{+} \otimes H\ket{1 - f(0)}) + (\ket{-} \otimes H\ket{f(1)}) + (\ket{-} \otimes H\ket{1 - f(1)}) \right]\\)

最期の式を更に詳細に計算する.

初めの2項
\\( (\ket{+} \otimes H\ket{f(0)}) - (\ket{+} \otimes H\ket{1 - f(0)}) \\)
を調べる.
\\(f(0), 1-f(0)\\) はちょうど一方が 0 なら他方は 1 である.

\\(f(0) = 0\\) のとき,

$$\begin{align*}
(\ket{+} \otimes H\ket{f(0)}) - (\ket{+} \otimes H\ket{1 - f(0)})
& = \ket{+} \otimes (\ket{+} - \ket{-}) \\\\
& = \ket{+} \otimes (\sqrt{2} \ket{1}) \\\\
& = \sqrt{2} (\ket{+} \otimes \ket{1})
\end{align*}$$

同様に \\(f(0)=1\\) のとき,

$$\begin{align*}
(\ket{+} \otimes H\ket{f(0)}) - (\ket{+} \otimes H\ket{1 - f(0)})
& = - \sqrt{2} (\ket{+} \otimes \ket{1})
\end{align*}$$

である. この2つの場合をまとめて
$$(\ket{+} \otimes H\ket{f(0)}) - (\ket{+} \otimes H\ket{1 - f(0)}) = (-1)^{f(0)} \sqrt{2} \ket{+1}$$
と書ける.
ここで \\(\ket{+} \otimes \ket{1}\\) を \\(\ket{+1}\\) と書いた.

また残りの2項についても同様に
$$(\ket{-} \otimes H\ket{f(1)}) - (\ket{-} \otimes H\ket{1 - f(1)})
= (-1)^{f(1)} \sqrt{2} \ket{-1}$$
となる.

というわけで
$$\begin{align*}
H(U_f\ket{+-})
& = \frac{1}{2} \left[
    (-1)^{f(0)} \sqrt{2} \ket{+1} + (-1)^{f(1)} \sqrt{2} \ket{-1}
\right] \\\\
& = \frac{1}{\sqrt{2}} \left[
    (-1)^{f(0)} \ket{+1} + (-1)^{f(1)} \ket{-1}
\right]
\end{align*}$$

を得る.

2 qbit 目は常に $1$ であることがわかる.
さて 1 qbit 目にだけ注目すると
$$\frac{1}{\sqrt{2}}\left[ (-1)^{f(0)} \ket{+} + (-1)^{f(1)} \ket{-} \right]$$
である.
\\(f(0), f(1)\\) によって4通りに場合分けをすると,

1. case \\(f(0)=0, f(1)=0\\)
    - \\(\frac{1}{\sqrt{2}} (\ket{+} + \ket{-})) = \ket{0}\\)
1. case \\(f(0)=0, f(1)=1\\)
    - \\(\frac{1}{\sqrt{2}} (\ket{+} - \ket{-})) = \ket{1}\\)
1. case \\(f(0)=1, f(1)=0\\)
    - \\(\frac{1}{\sqrt{2}} (- \ket{+} + \ket{-})) = - \ket{1}\\)
1. case \\(f(0)=1, f(1)=1\\)
    - \\(\frac{1}{\sqrt{2}} (- \ket{+} - \ket{-})) = - \ket{0}\\)

観測する場合にはその係数の大きさの自乗の確率で状態を得る.
係数はそれぞれ \\(+1\\) または \\(-1\\) になっているから結局必ず \\(\ket{0}\\) または \\(\ket{1}\\) を得ることになり, それは \\(f(0) \oplus f(1)\\) と一致している.
例えば \\(f(0)=1, f(1)=0\\) の場合は \\(-\ket{1}\\) を得, 観測した結果 \\((-1)^2\\) の確率で \\(\ket{1}\\) を得る.

% Improved Techniques for Training GANs
% https://arxiv.org/abs/1606.03498
% 深層学習 GAN

## 概要

GANのテクニック集

$$\text{GAN}: z \rightarrow^G x \rightarrow^D [0,1]$$

## Feature matching

識別器の中の入力から適当な中間層までの計算を $f$ とするとき

$$\left\lVert f(x_{\text{real}}) - f(G(z_{\text{noise}})) \right\rVert^2$$

の最小化を目的関数に加える.
これは $G$ を強くするのが目的で、普通の画像の基本的な特徴を持った画像は安定して作れるようにする.

## Minibatch discrimination

GAN の大きな問題として縮退 (collapse) が挙げられる.
それはすなわち、GANを訓練していくと生成器 $G$ がいつの間にか入力のノイズを無視して定数を出力するような状態に収束してしまう現象のこと.
$G$ としてはミニバッチごとに異なる画像を出す必要がないので、そうなるのが当然.

ミニバッチの中では異なる入力が与えられるのだから出力も異なることを保証するような制約を設けるのが
minibatch discrimination
で、ミニバッチごとの $G$ の出力における多様性を $D$ にヒントとして入力を与える.
$G$ はこれを騙すには多様な出力をする必要がある.

多様性は次のように表現する.  
$G$ の出力を $x_1, x_2, \ldots, x_k$ とする.
これをそのまま使うとアレなので、やはり識別器の中間層の出力 $f(x_i)$ を使う.
$f(x_i) \in \mathbb{R}^A$ として
適当なテンソル $T \in \mathbb{R}^{A\times B\times C}$ を掛けて

$$M_i = f(x_i) T \in \mathbb{R}^{B\times C}$$

を出力の特徴だとする.
$b$-th 列ベクトル
$M_{ib} \in \mathbb{R}^C$ が $B$ 個あると見做す.

- $c_b(i, j) = \exp \left[ - \| M_{ib} - M_{jb} \|_1 \right]$
- $o_b(i) = \sum_{j=1}^n c_b(i, j)$
- $o(i) = [ o_1(i), o_2(i), \ldots, o_B(i) ]$

この $o(i)$ を $f$ の継続への入力に ( $x_i$ に対応するところに) 追加する.

## One-sided label smoothing

正負ラベルを $1.0$, $0.0$ に対応させる代わりに $0.9$, $0.1$ くらいに対応させるほうが良い結果が得られることは 1980 年から知られていた (!!). このテクニックを Label smoothing という.

なんか分からんけど正データだけ $0.9$ くらいにして負データは $0.0$ にしただけの片側ラベルスムージングが良いらしい.

## Virtual batch normalization

DCGAN においても batch normalization は品質向上に貢献してきたが、
バッチごとに他の値に入力するのは問題なので、
batch normalization が参照するバッチは初めに一個決めてずっと固定して使う.

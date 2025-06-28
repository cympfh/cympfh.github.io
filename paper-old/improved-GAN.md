% Improved Techniques for Training GANs
% https://arxiv.org/abs/1606.03498
% 深層学習 GAN

## 概要

GANのテクニック集、応用例

$$\text{GAN}: z \rightarrow^G x \rightarrow^D [0,1]$$

## テクニック
### Feature matching

識別器の中の入力から適当な中間層までの計算を $f$ とするとき

$$\left\lVert f(x_{\text{real}}) - f(G(z_{\text{noise}})) \right\rVert^2$$

の最小化を目的関数に加える.
これは $G$ を強くするのが目的で、普通の画像の基本的な特徴を持った画像は安定して作れるようにする.

### Minibatch discrimination

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

### One-sided label smoothing

正負ラベルを $1.0$, $0.0$ に対応させる代わりに $0.9$, $0.1$ くらいに対応させるほうが良い結果が得られることは 1980 年から知られていた (!!). このテクニックを Label smoothing という.

なんか分からんけど正データだけ $0.9$ くらいにして負データは $0.0$ にしただけの片側ラベルスムージングが良いらしい.

### Virtual batch normalization

DCGAN においても batch normalization は品質向上に貢献してきたが、
バッチごとに他の値に入力するのは問題なので、
batch normalization が参照するバッチは初めに一個決めてずっと固定して使う.

## 半教師あり学習 (画像の分類問題)

画像の $k$ クラス分類の半教師あり学習を考える.
ラベルありのデータセット $D_L = \{(x,y)\}$ と $D_U=\{x\}$ がある.

$D_L$ からは通常の $k$ クラス分類を行う.
すなわち、適当な NN を組んで出力として $k$ 次元の値
$$l_1,l_2,\ldots,l_k$$
を出して、これの softmax
$$\mathrm{softmax}(l_1,\ldots,l_k) = \frac{\left(\exp l_i\right)_i}{\sum_i \exp l_i} = \left( p_1,\ldots,p_k \right)
~~
0<p_i, \sum_i p_i=1$$
の $p_i$ を $i$ 番目のクラスに属する確率だとして、教師ありで学習する.

これにGANの構造を追加する.
すなわち、画像をノイズから生成するNN $G$ (生成器) を加える.
また出力を $k$ 次元から $k+1$ 次元
$$l_1,l_2,\ldots,l_k, l_{k+1}$$
に増やす.
この $l_i (1\leq i \leq k)$ は今まで通りだが、新しく加えた $l_{k+1}$ は入力が $G$ によって生成されたことを表す.
すなわちこの分類器は、自然画像の何番目のクラスか、または人工画像か、を分類する.

ここで注意として、softmax は定数の加算に対して不変性を持つ.
つまり、
$$\mathrm{softmax}(l_1,\ldots,l_k) = \mathrm{softmax}(l_1+c,\ldots,l_k+c)$$
である.
従って、実は、$l_{k+1}=0$ としておけばよい.
実際に NN に $k+1$ 個目の出力を加える必要はなく、計算の中でゼロがあるものとすればよい.

半教師あり学習としての肝は

1. ラベルありからは通常通り、ラベル $1,2,\ldots,k$ を正しく学習
    - $k+1$ 番目は無視していい
1. ノイズから、
    - ラベルが $k+1$ になるように生成 ($G$ の学習)
    - ラベルが $k+1$ にならないように分類 (分類器の学習)
1. ラベルなしから、ラベルが $k+1$ にならないように分類

以上.
$k+1$ 番目を無視するか含むかで $p$ を $p^k, p^{k+1}$ とかき分けることにする.
右上の数字は次数のつもり.
適当に損失関数の式を写すと、

- $\mathcal{L} = - \mathbb{E}_{(x,y) \sim L} \log p^k(y|x)$
- $\mathcal{U} = - \mathbb{E}_{x \sim U} \log p^{k+1}(y \ne k+1|x)$
- $\mathcal{V} = - \mathbb{E}_{z \sim \mathrm{noise}} \log p^{k+1}(y \ne k+1|G(z))$

に対して、分類器の損失関数は $\mathcal{L}+\mathcal{U}+\mathcal{V}$、生成器側の損失関数は $-\mathcal{V}$.

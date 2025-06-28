% [1811.00995] Invertible Residual Networks
% https://arxiv.org/abs/1811.00995
% 深層学習

$\def\Lip{\mathrm{Lip}}$

生成モデルのことを考えると, それはクラス分類モデルの逆関数なので,
invertible (reversible, 全単射的) である必要がある.
Figure 1 はただの ResNet だと, 詰まる部分があって逆関数が無いことになってしまうことを言っている.
提案する Invertible Residual Networks (i-ResNet) はラベルなし最尤推定で生成モデルを学習することで, 全単射的なモデルを学習する.

![](https://i.imgur.com/itccUeh.png)

## ResNet の形式化

インデックス (時刻) $t$ に対して,
ResNet の各レイヤーは $\Lip(g_t) < 1$ なるブロック $g_t \colon \mathbb R^d \to \mathbb R^d$ によって
$$x_{t+1} \leftarrow x_t + g_t(x_t) = (I + g_t)(x_t)$$
と表される.
$\Lip$ はリプシッツ定数, $I$ は恒等写像.

### Theorem 1

$\Lip(g)<1$ のとき $I+g$ は invertible.

$y=(I+g)(x)$ について, この逆関数を不動点として与えることが出来る.
すなわち,

- $x^0 = y$
- $x^{i+1} = y - g(x^i)$

とすると $x^i$ の収束値が $x$ になっている.
不動点自体の存在は Banach 不動点定理による (らしい).

### Lemma 2

$F(x) = (I+g)(x)$ で $g$ がリプシッツ連続かつ $\Lip(g) < 1$ のとき,
$$\Lip(F) \leq 1 + \Lip(g).$$
また Theorem 1 から $F$ には逆関数があって,
$$\Lip(F^{-1}) \leq \frac{1}{1 - \Lip(g)}.$$

## リプシッツ連続なResNetの構成

各ブロック $g$ は, 線形関数と非線形な関数 $\phi$ を交互に適用するものだとする.
例えば $g = W_3 \phi W_2 \phi W_1$ みたいに.

各行列 $W_i$ が畳み込みだとすると,
$W_i$ のスペクトルノルムが $1$ 未満であれば $\Lip(g)$ も $1$ 未満である.
(本当に???????????????? $\phi$ に依らずに???????????????????)

## 生成モデル

$$p_z(z) \sim z \xrightarrow{\Phi} x$$
を考える.
しかも $\Phi^{-1}$ が存在してそれを $F$ とする.
このとき $p_x$ は
$$\log p_x(x) = \log p_z(z) + \log | \mathrm{det} J_F(x) |$$
で計算できる.
ここで $J_F$ は $F$ のヤコビアン行列.

行列式を真面目に計算するのは3乗の計算量が掛かって大変だが,
なんやかんやあって,

- $| \mathrm{det} J_F(x) | = \mathrm{det} J_F(x)$
- $\log \mathrm{det} J_F(x) = \mathrm{tr} (\log J_F(x))$

となって簡単に計算できる値になる.
というわけで
$$\log p_x(x) = \log p_z(z) + \mathrm{tr} (\log (I + J_g(x)))$$

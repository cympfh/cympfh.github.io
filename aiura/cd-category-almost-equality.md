% CD圏での概同値 (Almost Equality)
% 2020-08-06 (Thu.)
% 確率論 CD圏 マルコフ圏

[前回](discrete-cd-category.html) の続き.

$\def\Hom{\mathrm{Hom}}\def\C{\mathcal C}\def\Coupl{\mathrm{Coupl}}$

## 概同値 (Almost Equality)

> 「概同値」という言葉は今考えた.
> どこかの測度論の教科書でこんな感じに概を頭につけた対訳を与えていたような薄い記憶もあるけどもう分からない.

測度論では「ほとんど至るところで等しい」などと呼ばれる関係.
これはCD圏では次のように定義される.

CD圏 $\C$ と,
$X$ の確率を与える状態 $\sigma \colon I \to X$ と,
二つのチャンネル $f, g \colon X \to Y$ について,
$$f \sim_\sigma g \iff (1 \otimes f) c_X \sigma = (1 \otimes g) c_X \sigma.$$

この $\sim_\sigma$ の関係を, **$\sigma$-概同値 ($\sigma$-almost equal)** という.

これはCD圏では $\Hom(X,Y)$ の上の同値関係として定義される.
この同値で割った商集合を $$\Hom(X,Y)/\sigma$$ と書くことにする.

## 状態の圏

### 定義

CD圏 $\C$ の状態とは $\sigma \colon I \to X$ なる $\sigma$ のことを言うのだった.
これを対象にする圏を考えることが出来る.
これはコンマ圏 $I \downarrow \C$ と呼ばれる.

二つの状態 $\sigma \colon I \to X$ と $\tau \colon I \to Y$ の間の射
$f \colon \sigma \to \tau$
とは, $\C$ で可換性 $f\sigma=\tau$ を与える射 $f \colon X \to Y$ のこと.
というわけで,
この圏でのHomsetはさっき考えていたようなものに可換性の制約を追加したものになる:
$$(I \downarrow \C) (\sigma, \tau) \simeq \{ f \in \C(X, Y) \mid f\sigma=\tau \}.$$

さっき導入した $/\sigma$ を右辺に適用することで次のような集合を定めることができる:
$$(I \downarrow \C) (\sigma, \tau)/\sigma \simeq \{ f \in \C(X, Y) \mid f\sigma=\tau\}/\sigma.$$

### Coupling

二つの状態 $\sigma \colon I \to X$ と $\tau \colon I \to Y$ について,
この二つの coupling とは次を満たすような
$\omega \colon I \to X \otimes Y$
のこと:

- $(1 \otimes d_Y) \omega = \sigma$ かつ
- $(d_X \otimes 1) \omega = \tau$

このような coupling $\omega$ を集めたものを集合 $\Coupl(\sigma, \tau)$ と書くことにする.

### 定理

CD圏 $\C$ が disintegration がいつでも出来るとき,
$$(I \downarrow \C) (\sigma, \tau)/\sigma \simeq \Coupl(\sigma, \tau)$$

#### 証明

$f \in (I \downarrow \C) (\sigma, \tau)/\sigma$
があるとき, $f$ と $\sigma$ の次のような合成を考える:
$$(1 \otimes f) c_X \sigma.$$
これが実は $f$ に対応する coupling になっている.
$d_Y f = d_Y$, $f\sigma=\tau$ に注意するとこれは明らか.

逆に coupling $\omega$ が与えられた時,
これを disintegration することで $f \colon X \to Y$ が手に入って, これが
$f \in (I \downarrow \C) (\sigma, \tau)/\sigma$
に入っている.

さて対称性から明らかに $\Coupl(\sigma, \tau) \simeq Coupl(\tau, \sigma)$ なので,
$$(I \downarrow \C) (\sigma, \tau)/\sigma \simeq (I \downarrow \C) (\tau, \sigma)/\tau$$
である.
これは確率論で言えば $P(y\mid x)$ と $P(x \mid y)$ の間に自然な一対一対応があることを言っており,
この対応のさせ方のことは "Bayesian Inversion" として知られている.

## 強概同値 (Strong Almost Equality)

もっと条件の強い定義の仕方がある.

### 定義

状態 $\sigma \colon I \to X$ に対して,
$f, g \colon X \to Y$ について次の関係を定義する.
$$f \sim_\sigma' g \iff
\Big(~
\forall Z,
\forall \omega \colon I \to X \otimes Z,
\sigma = (1_X \otimes d_Z) \omega \implies (f \otimes 1) \omega = (g \otimes 1) \omega
~\Big).$$

### 性質

強概同値が成り立つとき概同値も成り立つ:
$$f \sim_\sigma' g \implies f \sim_\sigma g.$$
$\omega$ として $c_X \sigma$ を使えばすぐに確認できる.

### 定理

disintegration が出来る affine CD圏の場合, 強概同値とただの概同値は同じ:
$$f \sim_\sigma' g \iff f \sim_\sigma g.$$

#### 証明

$f \sim_\sigma g$ のときに強概同値であることを見ればいい.
$$f \sim_\sigma g \iff (f \otimes 1) c_X \sigma = (g \otimes 1) c_X \sigma$$
次に
$\sigma = (1_X \otimes d_Z) \omega$
であるような任意の $\omega \colon I \to X \otimes Z$ について,
これを disintegration すると次のような $e \colon X \to Z$ が手に入る:
$$\omega = (1 \otimes e) c_X \sigma.$$

以上を使うと
$$\begin{align*}
(f \otimes 1) \omega
& = (f \otimes 1) (1 \otimes e) \sigma \\
& = (f \otimes e) \sigma \\
& = (1 \otimes e) (f \otimes 1) \sigma \\
& = (1 \otimes e) (g \otimes 1) \sigma \\
& = (g \otimes 1) (1 \otimes e) \sigma \\
& = (g \otimes 1) \omega
\end{align*}$$
というわけで $f \sim_\sigma' g$ が成り立つ.

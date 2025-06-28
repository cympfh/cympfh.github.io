% [1704.02304] Adversarial Generator-Encoder Networks
% https://arxiv.org/abs/1704.02304
% GAN

## 概要

GAN の亜種のような生成モデルの提案.
潜在空間を仮定し、具体的な Discriminator の代わりに常にダイバージェンスを気にする辺り、
(言及はされていないが) [VAE](VAE.html) とのハイブリッドという感じがした.

## links

1. [arxiv](https://arxiv.org/abs/1704.02304)
1. [original paper (pdf)](http://sites.skoltech.ru/app/data/uploads/sites/25/2017/04/AGE.pdf)
1. [implementation (github)](https://github.com/DmitryUlyanov/AGE)
1. [reddit](https://www.reddit.com/r/MachineLearning/comments/64j4kk/r_adversarial_generatorencoder_networks/)

## Adversarial Generator-Encoder (AGE)

<blockquote class="twitter-tweet" data-lang="en"><p lang="en" dir="ltr">Released paper: &quot;Adversarial Generator-Encoder Networks&quot; with V. Lempitsky, A. Vedaldi. <a href="https://t.co/APSpRMo0EY">https://t.co/APSpRMo0EY</a> code <a href="https://t.co/ehdPrinzW8">https://t.co/ehdPrinzW8</a> <a href="https://t.co/vcGpsEKzzW">pic.twitter.com/vcGpsEKzzW</a></p>&mdash; Dmitry Ulyanov (@DmitryUlyanovML) <a href="https://twitter.com/DmitryUlyanovML/status/851335919772762112">April 10, 2017</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>

### 生成過程

[VAE](VAE.html) のような生成過程を仮定する.
即ち、ある潜在変数の空間 (単純な確率分布が仮定される) があって、
ある過程に依って実データに写される.

```dot
digraph {
    bgcolor=transparent;
    rankdir=LR;
    Z -> X [label=Generate];
    X -> Z [label=Encode];
}
```

- 実データ空間 $\mathcal{X} (\subseteq \mathbb{R}^m)$
- 潜在空間 $\mathcal{Z} (\subseteq \mathbb{R}^n)$
    - 球面 $S^{n-1}$ 上の一様分布を仮定

これらの間を行き来するための 2 つの関数

- Encoder $e: \mathcal{X} \to \mathcal{Z}$
- Generator $g: \mathcal{Z} \to \mathcal{X}$

を NNs で構成、学習する.

### 註意

本文書において、
$\mathcal{X}, \mathcal{Z}$ は確率分布である.
ただし単に集合と区別なく記述する.
例えば関数の値域/定義域にこれを使ったし、
写像 $f$ で写した先の確率分布 $\{ f(x) ; x \sim \mathcal{X} \}$ のことを $f(\mathcal{X})$ などと略記する.

### 誤植?

論文を見ると潜在空間を 「$M$ 次元 sphere $\mathbb{S}^M$ 」という風に書いてあるが、
おそらくそれは 「球面 $S^{M-1}$」の誤植だと思うのでそのつもりで書きます.
球面じゃなくて球体かとも疑いましたが、実装を見ると最後にベクトルの正規化を行っているので違うことが分かります.

### 註意

Encoder の実装を見ますと、NN で $n$ 次元ベクトルを出力した後に正規化をしたものを出力としています.
従って $e$ の値域は厳密に $S^{n-1}$ です.

Generator $g$ の値域は当然ですが
$\mathcal{X}$ ではなくその superset の $\mathbb{R}^m$ ですので、
それが出来るだけ $\mathcal{X}$ になるのを目指して学習を行うのだと思います.

### Generator $g$ の学習

$e(g(\mathcal{Z}))$ と $\mathcal{Z}$ との間のダイバージェンス ($\Delta$ と書く) の最小化を目指す.

### Encoder $e$ の学習

$e(\mathcal{X})$ と $\mathcal{Z}$ との間の $\Delta$ の最小化を目指す.
同時に $e(g(\mathcal{Z}))$ と $\mathcal{Z}$ との間の $\Delta$ の最大化を目指す.

結局要するにGANだ.
Discriminator の代わりに、Encoder $e$ があって、これが

### Reconstruction loss

おおよそ
$g \circ e = id_\mathcal{X}$,
$e \circ g = id_\mathcal{Z}$
となるように (つまりオートエンコーダーになるような) 損失を加える.

$$L_\mathcal{X}(g, e) = \mathbb{E}_{x \sim \mathcal{X}} \| x - g(e(x)) \|^2$$
$$L_\mathcal{Z}(g, e) = \mathbb{E}_{z \sim \mathcal{Z}} \| z - e(g(z)) \|^2$$

### ダイバージェンスの計算

ダイバージェンス $\Delta$ を定義していなかった.
結局実際に使うのは KL ダイバージェンスである.

$$\Delta(\mathcal{P} \| \mathcal{Z})
:= \rm{KL}(\mathcal{P} \| \mathcal{Z})
\approx \rm{KL}(\mathcal{P} \| \mathcal{N})
- \rm{KL}(\mathcal{Z} \| \mathcal{N})
= \rm{KL}(\mathcal{P} \| \mathcal{N}) - \rm{Const}$$

としてこれを使う.
ここで
$\mathcal{Z}$ が $S^{n-1}$ 上の一様分布であるのに対して
$\mathcal{N}$ を $n$ 次元正規分布とする.
平均をゼロ、分散を $I$ とする.

> 一様分布と正規分布とを比較していて私は初め見た時に (誤植? もあったため余計に) 驚いたが、
> 先に延べたように誤植を訂正してやると、正規分布の原点から等距離なところのみでダイバージェンスを計算してるだけなので、
> 特に問題無さそうに思える.

VAE では具体的にNNの出力を確率分布そのものにしているが、AGE-net ではあくまでもデータをデータに写すだけである.
バッチの中でデータの分布を見て、ダイバージェンスを計算する.

ミニバッチ $Q = \{q_1, q_2, \ldots, q_N : q_i \in \mathbb{R}^m \}$ に就いて、
平均 $m = \frac{1}{N} \sum_i q_i \in \mathbb{R}^m$、
分散 $s = \frac{1}{N} \sum_i (m - q_i)^2 \in \mathbb{R}^m$ (自乗の計算は要素ごと) としたときに、
(これをそういう正規分布に見立てて)

$$\textrm{KL}(Q \| \mathcal{N}) \approx -\frac{M}{2} + \sum_{j=1}^m \left[ \frac{s_j^2 + m_j^2}{2} - \log s_j \right]$$

として計算する.
定数部分を無視すれば

$$\Delta(Q \| \mathcal{N}) \approx \sum_{j=1}^m \left[ \frac{s_j^2 + m_j^2}{2} - \log s_j \right]$$

ということに出来る.

### AGE-net の学習法

以上をまとめる.

ダイバージェンス云々に関する目的関数

$$V(g, e) = \Delta(e(g(\mathcal{Z})) \| \mathcal{Z}) - \Delta(e(\mathcal{X}) \| \mathcal{Z})$$

とする.
GAN なら $\min_g \max_e V$ とか書かれるが、
実用的には一方を固定して、もう一方を SGD (彼らの実験では Adam を使用) によって $V$ を最大化/最小化することを目指すことを繰り返す.
その時に更新する方の reconstruction loss を罰金項的に加える.
ここで $\lambda, \mu$ は適当なパラメータである.

1. $g$ の更新:
    - $\min \left[ V(g, e) + \lambda L_\mathcal{Z}(g, e) \right]$
1. $e$ の更新:
    - $\max \left[ V(g, e) - \mu L_\mathcal{X}(g, e) \right]$

## 半教師アリ学習への適用

全体的にVAEだと見做せば、適切な潜在変数への写像を手に入れたと考えられるので、
そこから分類タスクなどへの適用が考えられる.
ラベル無しのデータでは単に AGE network 部分だけを学習すれば、半教師アリ学習になる.

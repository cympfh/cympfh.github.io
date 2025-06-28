% [1910.06922] Connections between Support Vector Machines, Wasserstein distance and gradient-penalty GANs
% https://arxiv.org/abs/1910.06922
% 深層学習 読みかけ

$$\def\relu#1{\left[ #1 \right]^+}\def\X{\mathcal X}\def\Z{\mathcal Z}\def\R{\mathcal R}\def\D{\mathcal D}\def\E#1#2{\mathbb E_{#1}\left[ #2 \right]}$$

## 概要

SVM と GAN との関連性を考える.

## SVM

SVM は Maximum-Margin Classifiers の一種である.

簡単に二値分類としての線形 SVM を考える.
ラベル $y$ を $\{-1, +1\}$ とし, 超平面 $w$ の上と下で分類するとすると,
$$wx>0 \iff y=+1$$
$$wx<0 \iff y=-1$$
という条件がデータを正しく分離できたことを表す.
$y=+1$ のときと $y=-1$ のときとをまとめるとこの条件はさらに簡単に
$$y(wx) > 0$$
だと書き直せる.

ところでこの $wx$ という量はデータ $x$ と平面との距離という量に関連していて,
その距離は
$\frac{|wx|}{\|w\|_2}$
である.
SVM はこの距離が大きいほどよいとしている.
分子の絶対値はラベルを掛けてしまえばよくて,
すなわち
$$\max_w \frac{y(wx)}{\|w\|_2}$$
を目指すものと言える.

ただしどの点 $x$ からも上記の最大化を目指すのではなくて,
データの中でも最も平面に近いものとの距離だけに注目する（そのような距離をマージンと呼ぶのだった）.
すなわち、$w$ を固定したときに
$$\min_x \frac{y(wx)}{\|w\|_2}$$
を取ってくれるような操作があるとしている.

２つの最大化と最小化を合わせると
$$\max_w \min_x \frac{y(wx)}{\|w\|_2}$$
となる.

> max min の最適化は GAN として解釈できる.
> $\min_x$ の部分は判別器を騙す生成器であって,
> $\max_w$ の部分は騙されないような頑強な分類器を表す.
> GAN の場合はこの２つを交互に学習させるが, SVM では一発で最適化する.

実際には SVM はこの max min の式を直接解くのでは無く,
まず
$$\min_w \frac{1}{N} \relu{y(wx)} \text{ s.t. } \|w\|_2=1$$
という制約付き最適化問題に書き直し（双対を取った）,
さらに KKT 条件を用いて
$$\min_{w,\lambda} \frac{1}{N} \sum_{(x,y)} \relu{y(wx)} + \lambda ( \|w\|_2^2 - 1 )$$
とする.
ここで $\relu{x} = \max(0,x)$ のこと.
この最適化問題を解く.

## GAN

実データの空間 $\X$ とその上の分布があるとする.
また適当な分布を仮定した空間 $\Z$ を用意する.
関数 $G \colon \Z \to \X$ は実データらしいものを生成する.
関数 $C \colon \X \to \R$ はデータが実データ由来か $G$ 由来かを判定する.

そのために $C, G$ に関して次の２つの最適化を解く.

- $\max_C \E{x}{f_1(C(x_1))} + \E{z}{f_2(C(G(z)))}$
- $\min_G \E{z}{f_3(C(G(z)))}$

ただしここで $f_1,f_2,f_3$ は値を補正する関数 $\R \to \R$ で,
いくつものバリエーションが有る.

- Standard GAN
    - $f_1(z) = \log(\sigma(z))$
    - $f_2(z) = \log(\sigma(-z))$
    - $f_3 = -f_1$
- Least-Squares GAN
    - $f_1 = -(1-z)^2$
    - $f_2 = -(1+z)^2$
    - $f_3 = -f_1$
- HingeGAN
    - $f_1(z) = -\relu{1-z}$
    - $f_2(z) = -\relu{1+z}$
    - $f_3(z) = -z$

### IPM-based GAN

違う形式の GAN もある.

Integral Probability Metrics (IPMs) は２つの確率分布どうしの距離を測る指標で
$$\mathrm{IPM}(P \| Q) = \sup_C \E{x}{C(x)} - \E{x}{C(x)}$$
としている（ただし $C$ は実数関数全体から取る）.
ところで GAN の $G$ というのは結局 $G(z)$ が実データの分布に近くなることを目指してるのだから,
IPM の最小化を目的関数にすることが考えられる.
$$\min_G \max_C \sup_C \E{x}{C(x)} - \E{z}{C(G(z))}$$
これが IPM-based GAN と呼ばれる.
IPM based なものも多く亜種があるが, WGAN もその一つ.

WGAN は距離に Wasserstein 距離を使う.
これは $C$ として 1-Lipschitz 連続なものに限定した IPM である.

## 一般化(?) SVM

$f(x) = wx$ とする.
一時近似してやると $\|w\|_2 \approx \nabla_x f(x)$.
このためさっきの
$\frac{y(wx)}{\|w\|_2}$
という量は
$\frac{yf(x)}{\| \nabla_x f(x) \|_2}$
に近似できる.
これの最大化を目的関数にしていい.

> カーネルも一般化して $f(x) = w \phi(x)$ としても $f(x) \approx wx$ である範囲ではこの近似は通用すると言っている.

ここまではデータが線形分離可能であることを仮定していた.
そうでない場合のために SVM には soft-margin という考え方があった.
$\gamma$ の修正する関数 $F \colon \R \to \R$ を用意して
$F(\gamma(x,y;f))$
の最大化を目指すことに置き換える.

先に掲げた SVM の目的関数は
$$\min_{w,\lambda} \frac{1}{N} \sum_{(x,y)} \relu{y(wx)} + \lambda ( \|w\|_2^2 - 1 )$$
であった.
今言った近似と soft-margin をこれに導入する.
また $\frac{1}{N} \sum_{(x,y)}$ の部分は要はデータ上の期待値だと見れるのでそうする.

$$\min_{w,\lambda} \E{(x,y)}{ F(y f(x)) } + \lambda \left( (\nabla_x f(x))^2 - 1 \right)$$

この最後の部分は罰則化項に見える.
すると $g$ で一般化したくなってきて
$$\min_{w,\lambda} \E{(x,y)}{ F(y f(x)) } + \lambda g(\nabla_x f(x))$$
となる.
SVM であれば $g(z) = z^2-1$ である.
しかしまあ実際はもっと緩やかな罰則でいいので $g(z)=(z-1)^2$ とか $g(z)=\relu{z-1}$ がいいそう.

## GAN との関連

SVM の最後の式はだいぶ WGAN っぽい.
$F(z)=z$, $g(z)=\relu{z-1}$
にするとそのもの？




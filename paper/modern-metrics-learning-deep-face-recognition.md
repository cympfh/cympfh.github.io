% [1804.06655] Deep Face Recognition: A Survey
% https://arxiv.org/abs/1804.06655
% 顔認証 距離学習 類似度学習

## 概要

Face Recognition (FR; 顔認証) の手法の近年の遷移をサーベイした論文.

![](https://i.imgur.com/nASiTF2.png)

## リンク

- [モダンな深層距離学習 (deep metric learning) 手法: SphereFace, CosFace, ArcFace - Qiita](https://qiita.com/yu4u/items/078054dfb5592cbb80cc)

<blockquote class="twitter-tweet" data-lang="en"><p lang="ja" dir="ltr">LFW自体がCNN使わずとも98.5%とか出ちゃう簡単なベンチマークなので、この表はほとんど意味ないです…<br>ここ最近の傾向だと、SphereFaceとCosineFaceとArcFaceを合体させて一般化したCombined Margin Lossがファイナルアンサーっぽい感じです。<a href="https://t.co/K9ciQQlqNe">https://t.co/K9ciQQlqNe</a></p>&mdash; Koichi Takahashi (@51Takahashi) <a href="https://twitter.com/51Takahashi/status/1095689245350449152?ref_src=twsrc%5Etfw">February 13, 2019</a></blockquote>
<script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

## 距離学習の概要

(顔写真などの) 2枚の画像 $I_1, I_2 \in \mathrm{Images}$ について,
適当な 前処理 $P \colon \mathrm{Images} \to \mathrm{Images}$,
特徴抽出 $F \colon \mathrm{Images} \to \mathbb R^m$,
そして距離 (マッチング) 関数 $M \colon \mathbb R^m \times \mathbb R^m \to \mathbb R_{\geq 0}$
によって
$$M(F(P(I_1)), F(P(I_2)))$$
で表されるこの値が $I_1$ と $I_2$ の類似度になるようにしたい.

前処理 $I$ は, いわゆる one-to-many augmentation と many-to-one normalization のこと.
前者はランダムにパッチを切り出すとかポーズのバラエティとか.
後者は顔を真正面に向かせるとか.

特徴抽出は NNs で組むところで普通最近の強い CNN などを採用する.

以降では $x_i = FPI_i$ として $M(x_1, x_2)$ について考える.

## ユークリッド距離ベース

2017までの主流.

距離を
$$M(x_1, x_2) = \| x_1 - x_2 \|_2$$
として, 2 アイテムが似てたらこの値が小さく (0 に近く) なるように, さもなくば大きくなるようにする.

損失関数は
$$\mathcal L(x_1, x_2, y_{12}) = y_{12} [M(x_1, x_2) - \epsilon^+]^+ + (1 - y_{12}) [\epsilon^- - M(x_1, x_2)]^+$$
と記述される.
ここで
$[\cdot]^+ = \max \{ 0, \cdot \}$,
$\epsilon^+, \epsilon^-$ は適当なマージン.
また $y_{12}$ は $(x_1, x_2)$ についてのラベルで, 類似してる (マッチングしてる) なら $1$, さもなくば $-1$.

コレ自体は 2003 年には発表されている:
("Distance metriclearning with application to clustering with side-information.  InNIPS,pages 521–528, 2003").
[DeepID](deepid.html), [DeepID2](face-representation.html) なんかはCNNに当時の強いのを特徴抽出に採用してクラス分類と組み合わせることで安定した学習を実現させた.
FaceNet では入力の与え方を工夫（より制限）して,
各アイテム $x$ について類似してるアイテム $x^p$ と類似していないアイテム $x^n$ を与える [Triplet Loss](triplet-network.html) を採用した.
これは
$$M(x, x^p) + \alpha < M(x, x^n)$$
なるように学習をさせる.
ここで $\alpha$ はマージン.

逆に今までの入力が2アイテム (pair-wise) な損失関数は "contrastive loss" と呼ばれる.

問題点としては contrastive / triplet loss はそれだけだと学習が不安定なこと.
(個人的な経験でも, うまくネガティブサンプリング等をしないとすべてのアイテムがある一つの特徴ベクトルに写ってしまう "縮退" とも呼ぶべき現象がしばしば見られた.)
だからこそ DeepID ではクラス分類を補助タスクとして足すことで安定化を図っている.

## 角度/cosine 距離ベース

2017以降の主流.

直接にはクラス分類として解かせて, 結果的に cosine 類似度で距離が学習されるようにする.

クラス $i$ に対応するベクトル $w_i \in \mathbb R^m$ とアイテムの特徴ベクトル $x$ があって
$\|w_i\|_2 = 1, \|x\|_2=1$
のとき,
$$w_i \cdot x = \cos(w_i, x)$$
この値によってクラス分類をすることを考える.
すなわち
$$\max_i \cos(w_i, x)$$
によってクラス $i$ を予測する.

値が大きいものを選ぶというのは softmax と性質が等しい.
従って,
$$W = \left[ w_1, w_2, \ldots, w_k \right]^T$$
として
$$\mathrm{softmax}(W x)$$
を学習/予測するのと等しい ($W$ もパラメータ).

実際にはここにマージンを足してスケーリングをする.

### large-margin softmax (L-softmax)

これは $w_i$ や $x$ を特別に正規化せず
$$\hat{y} = \mathrm{softmax}(W x)$$
として, このマイナス対数を損失関数とする (エントロピー).

ただし,
$x$ の正解ラベル $i$ に対応する
$$\cos(\theta_i) = w_i x$$
については
$$\cos(m \theta_i)$$
にスケーリングして修正する $(m>1)$.
すなわち $\ne i$ のクラスに比べて $1/m$ 倍で角度を小さくしないといけないようにする.

### A-softmax

これは L-softmax で出てくるベクトルを正規化する.
だから内積が cosine に一致するようにする.
$W,x$ をそれぞれ (列ごとに) 正規化したものを $\hat{W}, \hat{x}$ と書くと,
$$\hat{y} = \mathrm{softmax}(W x).$$

L-softmax 同様に, 正解ラベルの角度だけは $m (>1)$ 倍に増やす.

### ArcFace

マージンの取り方を変える.
$\cos(m \theta_i)$
の代わりに
$$\cos(\theta_i + m)$$
とする.

### CosineFace

$$\cos(\theta_i) - m$$
とする.

% [2011.10566] Exploring Simple Siamese Representation Learning
% https://arxiv.org/abs/2011.10566
% 自己教師アリ学習 FAIR

## 概要

Siamese ネットワークの方法は画像認識の分野では常識化した.
これは正例としての2つの画像ペアが同じ（または似てる）というものと,
負例として2つの画像ペアが違うものを表しているというデータセットで学習するものだった.

ここで提案する Simple Siamese (以下 SimSiam) は負例を必要としない.
正例も一つの画像に異なるオーグメントを施すことで自動的に作る.
勾配を切る操作 (detach, stop-grad) を使うが, collapsing を防ぐためにこれがめちゃくちゃ重要だった.

## 手法

![Figure 1](https://i.imgur.com/aSeKX0Y.png)

```python
def aug(x):
    """画像 x をランダムにオーグメントする"""
    return RandomlyAugument(x)

def cosine(x, y):
    """コサイン類似度"""
    x_normalized = x.normalize()
    y_normalized = y.normalize()
    return (x_normalized * y_normalized).sum()

def D(p, z):
    """損失関数としての類似度のマイナス"""
    z = z.detach()  # stop gradient
    return -cosine(p, z)

# 学習可能なエンコーダー層
f = Encoder()

# 学習可能な予測層
h = Predictor()

# 学習ループ
for x in minibatches:
    x1, x2 = aug(x), aug(x)
    z1, z2 = f(x1), f(x2)
    p1, p2 = h(z1), h(z2)
    loss1 = D(p1, z2)
    loss2 = D(p2, z1)
    loss = (loss1 + loss2) / 2
    loss.backward()
    optimizer.update()
```

エンコードで得た `z` と,
そこに更に `h` を挟んで得た `p` とを比較する.
この比較では `p` 側に使った方しかアップデートしない.

上のアルゴリズムでは, 一方に `h` を適用するのを両方実行して両方のロスを使ってる.

両方ともにアップデートすると, collapsing (同じ値に潰れる) 問題が起きるのでこれを少し回避できる.
加えて予測層 `h` を一方にだけ適用する.
これで完全に collapsing が起きなくなる.
`h` は浅い MLP 層で良い

## 実験

### 勾配を切る (detach, stop-grad) の効果

この操作を無くすと損失はあっという間に減って, コサイン類似度が 1 になる.
これは結局一つの値に潰れてることを示している.

ちなみにガウス分布に独立に従う $d$ 次元ベクトル $z$ を標準化したベクトル $z / \|z\|_2$ のその標準偏差は $1/ \sqrt{d}$ になる.
エンコーダ `z` による出力について, その標準偏差を考えると大体そのくらいの値になるのが正しい学習に期待される挙動だ.
これも一緒に調べると, 勾配を切ることで大体この値より少し小さいくらいを推移するが,
切らないとこれもすぐにゼロになる.
分散がゼロということなのでやはり一つの値に潰れてることが確認できた.

### 予測層 (Predictor) の効果

学習可能な予測層を置いておくことはめちゃくちゃ大事.
パラメータ固定の MLP を置いておいても意味はなく, 学習が収束しなかった（しかしこれによって collapsing が起きたわけではない）.
学習において lr decay は不要で, lr 固定でよかった.

### バッチサイズについて

collapsing を防ぐ目的でバッチサイズを大きくするのがこれまでの一般的なテクだった.
今回の実験では精度への影響はややあったが,
どちらにせよ collapsing は他の工夫で防げたのでバッチサイズは重要じゃなかった.

## 仮説: SimSiam は EM アルゴリズムになってる

勾配を止める操作がまさに交互に一方を学習してく EM アルゴリズム的になってそう.

画像 $x$, これをランダムにオーグメンテーションした $T(x)$,
これをエンコードして得る $F(T(x); \theta)$ があって,
$x$ に対して適切な表現ベクトル $\eta_x$ になるように学習する.

$$\mathcal{L}(\theta, \eta) = \mathbb E \left[ \| F(T(x); \theta) - \eta_x \|^2_2 \right]$$

注意点として $F$ のパラメータ $\theta$ だけでなく,
表現ベクトル $\eta_x$ そのものも学習すべきパラメータであるところ.
この2つをアップデートするのに,
一方を固定して他方をアップデートすることを交互にやる.
これが EM アルゴリズム的だといっている.

$\eta_x$ を固定するのは普通に
$F(T(x); \theta)$
に関してだけアップデートすればいい.

$\theta$ を固定して $\eta_x$ を学習することを考えるが,
これは解析的には次が最適解.

$$\eta_x \leftarrow \mathbb{E} \left[ F(T(x); \theta) \right]$$

そうすればいいのだが, 期待値を計算するのが実質無理なので,
直前の $T', \theta'$ を使って
$$\eta_x = F(T'(x); \theta)$$
としておく（$T$ はランダムなので $T'$ と書いて区別しておく）.

とすると,
$$\mathcal{L}(\theta, \eta) = \mathbb E \left[ \| F(T(x); \theta) - F(T'(x); \theta') \|^2_2 \right]$$
だし, パラメータ $\theta$ の更新は
$$\theta \leftarrow \mathop{\mathrm{argmin}}_\theta ~ \mathbb E \left[ \| F(T(x); \theta) - F(T'(x); \theta') \|^2_2 \right]$$
になった.
ここで $T', \theta'$ が定数なわけだが, これがまさに勾配をストップすることに相当している.
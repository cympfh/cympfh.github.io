% MixFeat: Mix Feature in Latent Space Learns Discriminative Space 
% https://openreview.net/forum?id=HygT9oRqFX
% 深層学習 画像認識 データ水増し

## 概要

汎化性能のためのデータ水増しの方法として mixup なんかがあったけどそれを強くした.

## 関連

- mixup [Zhang et al., 2018]
    - 入力データ (画像) を混ぜて (平均など) 学習する
- between-class learning (BCL) [Tokozume et al., 2018]
    - 知らない
- [manifold mixup](./Manifold-Mixup.html) [Verma et al., 2018]
    - mixup の進化系
    - 入力に限らずいろんな層での値を混ぜる (平均など)

## 提案手法

任意のタイミングでの値を, manifold mixup 同様に他のサンプルと混ぜて使ってしまう.
ミニバッチ $X$ について, 関数 $F$ はサンプルをランダムにシャッフルする関数だとする.

とすると mixup は $(X, y)$ で学習する代わりに $(\alpha X + (1-\alpha) F(X), y)$ で学習するものと書ける.
ただしここで $\alpha$ は $[0,1]$ の範囲からランダムに選ばれる値.
manifold mixup はこれを入力に限らずに任意のタイミングで行うもの (適当な層への入力をこれで置き換える).

提案する MixFeat はこの混ぜ方を次のようにする:
$$(1 + r \cos \theta) X + r \sin \theta F(X)$$
$$r \sim \mathcal N(0, \sigma^2), \theta \sim U[-\pi, \pi]$$

逆伝播ではこの $r, \theta$ に従って適切に逆関数を与える.
またこのように混ぜるのは学習時のみで, 推論時には混ぜない.
つまり $r=0$ とする.

### 実験

#### 性能評価

次の組み合わせで Error rate を比較 (Table 1)

- CIFAR-10/100
- ResNet-20/110/164, DenseNet, DenseNet-BN, PyramidNet
- Vanilla, Mixup, MixFeat

Vanilla $<$ Mixup $<$ MixFeat という結論.

#### 汎化性能

過学習を防ぐ役割があるかを, 学習曲線を見比べて比較する.
ただし mixup は比較に入れないで vanilla vs MixFeat だけ.

普通にやった場合は, 全然問題なさそう.

![](https://i.imgur.com/AGzGyk8.png)

> ちょっと test error rate が上がり始めても待ってるとまた落ちる

過学習を防ぐかを見る実験では単に CIFAR-10 じゃなくて,
一部のラベルを嘘のものに入れ替えた場合の学習曲線を眺める.

![](https://i.imgur.com/Coxwr2B.png)

incorrect labels の割合が増えるに従って増える error rate は vanilla に比べて MixFeat はおとなしい.
それは学習曲線を見てても分かる.
真ん中と右の図は incorrect labels が 50% の場合の ResNet-20.

### Ablation Analysis

> 知らなかったけど, Ablation Analysis というのは提案手法から一部の機能を削ぎ落として性能評価なんかをすることを言うらしい.

簡略版 MixFeat (1次元MixFeat) として $\theta=-\pi/4$ として
$$Y = X + \alpha X - \alpha F(X)$$
とできる.
$r$ の分布を適当にすることで, これが mixup や BCL に相当する.


### こいつがどう混ぜてるのか

データ $x_1$ に対して別なデータ $x_2$ を用意して, こいつは適当な $r, \theta$ を持って
$$x = (1+r \cos\theta) x_1 + r \sin \theta x_2$$
とする.
この $x$ は $x_1$ と $x_2$ をつなぐ直線上からサンプリングされる.
$x$ の期待値は $r$ の期待値が $0$ であることから $\mathbb E x = x_1$ である.
$r$ と $\theta$ は, この分布の偏りを決める.

<!-- ![](https://i.imgur.com/0JXHXyV.png) -->
![](https://i.imgur.com/QUWc75Y.png)

この図は一次元データ $x_1=0, x_2=1$ について, 各 $\theta$ (y軸) を取って,
$r$ を $\mathcal N(0,1)$ から 1000 回ずつサンプリングして $x$ を作ってプロットしたもの.
確かに $x_1=0$ を中心に正規分布ぽいものが広がっていて, $\theta$ はその裾の広さを決めている.

![](https://i.imgur.com/qSiNeHi.png)

今度は二次元データ $(x_1=(0, 1), x_2=(2, 0))$ について
$r \sim \mathcal N(0,1), \theta \sim U[0,2\pi]$
でサンプリングしてプロットしたもの.
中心はやはり $x_1$ にあるようで, **原点から見て** $x_2$ の方向に広がった正規分布ぽい分布をなしているように見える.

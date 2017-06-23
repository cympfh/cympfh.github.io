% Deep Learning Face Representation by Joint Identification-Verification (DeepID2)
% https://arxiv.org/abs/1406.4773
% 距離学習 類似度学習 顔認証

- 論文リンク: [https://arxiv.org/abs/1406.4773](https://arxiv.org/abs/1406.4773)
- 関連資料: [Siamese-Network-Architecture-and-Applications-in-Computer-Vision.pdf](http://vision.ia.ac.cn/zh/senimar/reports/Siamese-Network-Architecture-and-Applications-in-Computer-Vision.pdf)

## 概要

- 55x47x3 の顔の画像から、写っている人間を特定するタスク
- 教師アリ学習を行う
    - 通常のマルチクラス分類に加えて、Siamese ネットワークの要領を加えている

## 手法

入力 $x$ から、CNNを 4 つ重ねることで 160 次元の特徴ベクトル $f_x$ を得る.
彼らはこの特徴ベクトルを DeepID2 と呼んでいる.
(version 2 の 2 らしい.)

### Identify

通常の、マルチクラス分類と同様のことを、DeepID2 $f_x$ から行う.
すなわち、
入力 $x$ がクラス $t$ である確率を $f_x$ から求める関数を学習する.

- 確率の予測
    - $(f_x, t) \mapsto \hat{p_t}$
- この予測器に関する目的関数はクロスエントロピー
    - $\text{Ident}(f_x, t) = - \sum_{t'} p_{t'} \log \hat{p_{t'}} = - \log \hat{p_t}$


### Verify

同時に、距離学習 (metrics learning) も、行う.
すなわち、入力 $x_1, x_2$ から DeepID2 $f_1, f_2$ を得、この２つから、$x_1, x_2$ のラベルが同じかどうかを推定する.
この推定は、ほとんど DeepID2 そのものを使う.

#### L2 に基づく Verify

- $(f_1, f_2) \mapsto \| f_1 - f_2 \|^2$
- 目的関数は次の通り

$$\text{Verify}(f_1, f_2) =
\begin{cases}
\frac{1}{2} \| f_1 - f_2 \|^2 & \text{ when labels are same } \\
\frac{1}{2} \max(0, m - \| f_1 - f_2 \|^2) & \text{ when different}
\end{cases}$$

すなわち、ラベルが等しいときは、DeepID2 の L2 距離が近くなるようにし、
等しくない場合は、マージン $m$ より離れるように学習する (ここは "contrastive loss" が使われてる).

別な種類の Verify も提案している.

#### L1 に基づく Verify

- $(f_1, f_2) \mapsto \sigma(b + w \cos(f_1, f_2))$
    - $\sigma$ はシグモイド関数
- 目的関数は次の通り

$$\text{Verify}(f_1, f_2) =
\begin{cases}
\frac{1}{2} (1 - \sigma(b + w \cos(f_1, f_2)))^2 & \text{ when labels are same } \\
\frac{1}{2} (\sigma(b + w \cos(f_1, f_2)))^2 & \text{ when different}
\end{cases}$$

ここで $b, w$ は学習可能なパラメータ.
$\cos$ の出力はスカラーなので、それを線形にちょっと加工するだけの簡素な活性ユニット.

### 学習過程

Identify と Verify という2つの解き方を $1 : \lambda$ の割合で混ぜて学習する.
この $\lambda$ は、初め $0$ からスタートして、学習の過程で徐々に、際限なく増やしていく.

すなわち、初めは単にマルチクラス分類問題として解き、徐々に、 Siamese Network になる.

## 私の感想

既存手法を2つ混ぜたというだけだが、混ぜ方がこの論文の一番のミソだと思う.

本当は初めから単に Siamese Network にしたかったのだろう、と邪推する.
あとから新しいラベル (つまり人物) の顔写真が新しくテストデータに追加されるとき、
マルチクラス分類では、予め用意していたラベルのどれかに振り分けることしかできないが、
Siamese Network では分類することが出来る.

しかし、いきなり Siamese Network を学習するのは難しい.
学習が全然安定しないからである.
私も何度も試したことがあるが、すぐに縮退 (degeneracy) という現象が起きてしまう.
すなわち、ここでいう関数 $x \mapsto f_x$ が定数関数になってしまう.
これを避けるのに事前学習などが有効であるが、強い最適化を掛けると、やはり縮退してしまう.

恐らく、$\lambda$ を徐々に上げるのは、事前学習を混合的に行っているのだと思う.

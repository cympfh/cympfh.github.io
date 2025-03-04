% Poincaré Embeddings for Learning Hierarchical Representations
% https://arxiv.org/abs/1705.08039
% 埋め込み表現

## 概要

階層構造 (Zipf 則が成立するような) を持つデータ、例えば語なんかの埋め込み表現を学習したい.
通常そのような場合、高次元 (300とか500とか) ユークリッド空間への埋め込みを考えるが、
階層構造を持つものはポアンカレ空間に埋め込んだほうが良い.
圧倒的に低次元で表現できる.

## 先行研究: Translational

階層構造 (is-a) を学習するのだから距離を非対称にしてやろうという発想で、
$$d(u,v)=\|u-v+r\|^2$$
としてやろうというもの.
$r$ は $u,v$ に依存しない定数ベクトルで、埋め込み表現と一緒に学習するパラメータ.

## ポアンカレ空間

$\|x\|$ とあるとき、ユークリッド空間の普通のノルムのことを表す.

$d$ 次元ユークリッド空間 $\mathbb{R}^d$ の中の開球
$$\mathcal{B}^d = \{ x \in \mathbb{R}^d : \|x\| < 1 \}$$
に、次のリーマン計量を入れる:
$$g_x = \left( \frac{2}{1 - \|x\|^2} \right)^2 g^E$$
ここで $g^E$ はユークリッド空間のリーマン計量で、普通の基底を入れてれば単位行列.
この $\mathcal{B}^d$ をポアンカレ空間 (円板) と呼ぶ.

この空間における2点 $u,v$ 間の距離は次のように計算される.
$$d(u,v) = \mathrm{arcosh} \left(
1 + 2 \frac{\|u-v\|^2}{(1-\|u\|)^2 (1-\|v\|)^2}
\right)$$

$\mathrm{arcosh}$ は
[逆双曲線関数 - Wikipedia](https://ja.wikipedia.org/wiki/%E9%80%86%E5%8F%8C%E6%9B%B2%E7%B7%9A%E9%96%A2%E6%95%B0)
によると
$$\mathrm{arcosh}(x) = \log\left(x + \sqrt{x+1}\sqrt{x-1}\right)$$
だそうです.

```@gnuplot
set grid
set xrange [1:10]
plot log(x+sqrt(x+1)*sqrt(x-1))
```

### 最適化

勾配法 (e.g. SGD) を使うわけだが、通常そういうのはユークリッド空間を仮定している.
簡単に
$$\theta \leftarrow \theta - \alpha \nabla f(\theta)$$
を考える.
この $\nabla$ はユークリッド空間の上での勾配になるので、ポアンカレ空間の上でのそれに置き換える必要がある.
$$\theta \leftarrow \theta - \alpha g_\theta^{-1} \nabla f(\theta)$$
$g$ は先も定義したポアンカレ空間の計量.
代入すると
$$\theta \leftarrow \theta - \alpha \frac{(1 - \|\theta\|^2)^2}{4} \nabla f(\theta)$$
ただし、これで開球からはみ出ることが有り得るので、最後に
$$\mathrm{proj}(\theta) = \begin{cases}
\theta / \|\theta\| - \epsilon & \text{ if} \|\theta\| \geq 1 \\
\theta
\end{cases}$$
を噛ませて、
$$\theta \leftarrow \mathrm{proj} \left( \theta - \alpha \frac{(1 - \|\theta\|^2)^2}{4} \nabla f(\theta) \right)$$
とする. これで最適化する.

## 実験

語の埋め込み表現について二通りの実験をしている.
一つは語から埋め込み表現を作り再び語に戻せるかという Reconstruction.
コレ以上の詳細は書いてない...
5-200次元で試しているが、どの空間でも次元を増やせば増やすほど結果がよくなっているのは明らかであるが、
200次元のユークリッド空間より5次元の Translational のほうが良く、
200次元の Translational より 5次元のポアンカレ空間のが良い.

## 実装

[facebookresearch/poincare-embeddings](https://github.com/facebookresearch/poincare-embeddings)

見てみると、直接距離を学習するようなモデルを実装してる.

```@dot
digraph {
    rankdir=LR;
    bgcolor=transparent;
    x1 -> z1 [label="embedding"];
    x2 -> z2 [label="embedding"];
    z1 -> u1 [label="injection"]
    z2 -> u2 [label="injection"]
    {u1 u2} -> d;
    x1 [ shape=rect ];
    x2 [ shape=rect ];
    z1 [ shape=rect ];
    z2 [ shape=rect ];
    u1 [ shape=circle ];
    u2 [ shape=circle ];
    d [shape=plaintext ];
}
```

この $x_1$ や $z_1$ までがユークリッド空間の点で、これを埋め込む操作は単なる埋込なので (円板の中にありさえすれば) 座標は変えないが、
空間は歪んでるので偏微分したときの値がここで変わる.
最後の $d$ は2点 $u_1, u_2$ 間の距離だが、ポアンカレ空間上での距離を計算する.

## 感想

途中でポアンカレ空間に埋め込んで教師あり学習をするようなモデルを組みたい…。


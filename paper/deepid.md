% Deep Learning Face Representation from Predicting 10,000 Classes (DeepID)
% http://mmlab.ie.cuhk.edu.hk/pdf/YiSun_CVPR14.pdf
% 距離学習 類似度学習 顔認証

## 概要

顔認証 (Face verification) をする.
すなわち２つの画像が与えられて、同一人物かどうかを判定するタスク.
[Labeled Faces in the Wild (LFW)](http://vis-www.cs.umass.edu/lfw/) というデータセットで 97.45% の Acc を達成.

## 手法

顔画像 1 枚から、彼らが DeepID と呼ぶ特徴ベクトルに写す.
画像のペア (つまり２枚) が与えられた時、それぞれを特徴ベクトルに写し、
特徴ベクトル同士を比較することで顔認証を行う.

```dot
digraph {
rankdir=LR;
bgcolor=transparent;
node [shape=rect];
    FaceImage1 -> DeepID1 [label=ConvNet];
    FaceImage2 -> DeepID2 [label=ConvNet];
    {DeepID1 DeepID2} -> "is-same?";
}
```

### DeepID の学習

一枚の画像を適当な ConvNet によって 160次元の特徴ベクトル (ひとまずこれを DeepID と呼ぶ) に写す.
画像には 10,000 クラス程度のラベルがついているので、これを予測する形で DeepID を鍛える.

```dot
digraph {
rankdir=LR;
bgcolor=transparent;
node [shape=rect];
    FaceImage -> DeepID [label=ConvNet];
    DeepID -> Classes [label=softmax];
}
```

後述するが入力画像のサイズに依らず DeepID は 160 次元に固定している.
これは LFW におけるクラスの予測に適当だという判断だと思う.

### パッチ

一枚の画像を一回読むだけでは限界がある.
というわけで次のような改良を行う.

一枚の画像から複数のパッチを作る.
パッチとは矩形の切り抜きのことであるが、
その切り取る箇所や切り取る大きさに関してバリエーションを持たせる.

ただしパッチの数 $k$ は予め決めておき、
$i$ 番目のパッチの作り方は予め定めておいてそれをずっと使う.

パッチの数だけ ConvNet を用意する.
$i$ 番目のパッチは $i$ 番目の ConvNet で読む.

入力の大きさはパッチによって異なりうるが、出力は全て同じで 160次元である.
これをパッチから生成した DeepID とする.

各 ConvNet 及び DeepID は先述した方法で鍛える.

```dot
digraph {
rankdir=LR;
bgcolor=transparent;
node [shape=rect];
    Patch1 -> DeepID1 [label=ConvNet1];
    Patch2 -> DeepID2 [label=ConvNet2];
    Patch3 -> DeepID3 [label=ConvNet3];
    {DeepID1 DeepID2 DeepID3} -> DeepID [label=concat];
}
```

最終的に得られた $k$ 個の DeepID を結合することで $160k$ 次元の特徴ベクトルを得る.
これを改めて、入力画像から得た DeepID と呼ぶ.

### 細かいこと

一つのパッチは、入力画像を適切にリサイズした後に、39x31 (縦長) または 31x31 (正方形) で切り出す.
とても小さい.
一つの ConvNet 自体も、たった 4層のCNNで出来てる.
畳み込みの直後に relu で活性化し、MaxPooling をする.
BatchNormalization はしてないらしい.

パッチの枚数 $k$ はいくつか実験をしているが、基本的に多ければ多いほどよく $k=60$ での最高性能を報告している.

## Verification

与えられた２つの顔画像から先述した方法で各 DeepID を得る.
2つのID $x_1, x_2$ を見て、同一人物かどうか判定する.
一つは Joint Bayesian でやる方法と、適当な NN を組んで識別器を作る方法を提案していて、
前者のほうが 2% 程度よいということ.

## 感想

DeepID を verification に使う際に予め DeepID から平均を引き算してから使っている.
BatchNormalization を予め仕込んでおいたほうが良かったのではないだろうか.


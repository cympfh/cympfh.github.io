% [1704.07926] From Language to Programs: Bridging Reinforcement Learning and Maximum Marginal Likelihood
% https://arxiv.org/abs/1704.07926
% 強化学習 模擬世界 言語獲得

## タスクの概要

アクションを指示するような自然言語文を (実行可能な) プログラムに翻訳する.
プログラムは彼らがそのために設計した小さい言語セットで、
スタックマシンを操作するプログラミング言語として設計されているので、トークン列として出力し、解釈できるようになっている.

データセットにSCONEを用いる.
これはアクション前の世界の状態 $w_0$ とアクション後の世界の状態 $w_1$ を含む.

学習器は $w_0$ とアクションの指示文 $u$ を入力として実行可能プログラム
$$z = (w_0, u)$$
を予測.
プログラムを実際に実行して遷移後の世界
$$w' = z(w_0)$$
を得る.
これが実際に $w_1$ と一致しているかどうかを教師信号/報酬とすることで学習を行う.

### Spurious programs (偽プログラム)

たまたま その $w_0$ については $w'=w_1$ となっただけで翻訳としては誤ったプログラムを出力する場合がある.
そのようなプログラムはこの論文では spurious programs と呼んでいる.

頑張ってこれを回避しようとしてるが結果を観ると、spurious なものを多く出してる.

## ソースコード

- [kelvinguu/lang2program: Parse natural language into executable programs](https://github.com/kelvinguu/lang2program)

## SCONE dataset

[Sequential CONtext-dependent Execution dataset](https://nlp.stanford.edu/projects/scone/).
状態、操作を指示する自然言語、操作後の状態、操作を支持する自然言語、、、が繰り返しあるもの.
alchemy, scene, tangrams の3つがあり、本論文の例に使われてる scene から1つ引用すると、

```
dev-601
1:__ 2:__ 3:__ 4:__ 5:ry 6:__ 7:__ 8:__ 9:__ 10:__
a man in a yellow shirt appears on the right of the man in a red shirt and yellow hat
1:__ 2:__ 3:__ 4:__ 5:ry 6:y_ 7:__ 8:__ 9:__ 10:__
a second man in a yellow shirt appears on the left end
1:y_ 2:__ 3:__ 4:__ 5:ry 6:y_ 7:__ 8:__ 9:__ 10:__
he leaves
1:__ 2:__ 3:__ 4:__ 5:ry 6:y_ 7:__ 8:__ 9:__ 10:__
the man in the red shirt and yellow hat moves one space to the left
1:__ 2:__ 3:__ 4:ry 5:__ 6:y_ 7:__ 8:__ 9:__ 10:__
a man in a red shirt appears on his right
1:__ 2:__ 3:__ 4:ry 5:r_ 6:y_ 7:__ 8:__ 9:__ 10:__
```

実際は改行はタブ文字.
10 の場所が並んでいて、
`5:ry` は 5 つ目の場所に人が一人いて、赤いシャツ (`r`) を着ていて黄色い帽子 (`y`) を被っている.
`r_` みたいにシャツと帽子の一方についての情報しかないこともある.
`1:__` は誰もいないということ.
たぶん一つの場所に二人以上いることはない.
アクションを指示する文は人を移動させることに関する文らしい.

## モデル

自然言語を biLSTM で読んでプログラム (トークン列) をなんかデコーダーで出力.
なんかデコーダ、よくわからんけど大したことはなさそう.

### 学習

強化学習かMMLで解いてる.


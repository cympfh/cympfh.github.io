% [2402.17764] The Era of 1-bit LLMs: All Large Language Models are in 1.58 Bits
% https://arxiv.org/abs/2402.17764
% 深層学習

## 概要

一つの値を 1bit で表現する LLM を構築する.
1bit なんだけど計算上は `\{-1,0,+1\}` という3つの値を扱う.
$\log_2(3) = 1.58$ なことから, 彼らが提案するアーキテクチャを BitNet b1.58 とか 1.58-bit LLM と呼ぶ.

$0$ なものは値を持たなければいい（疎行列）ので, データの保持の上では $\{-1,1\}$ を 1bit で持つだけ.

これまで一つの値を実数（実際には 32bit, 16bit float）で表現する行列演算では掛け算と足し算の両方を行うので GPU が適していた.
今回の 1.58-bit LLM では係数が $\{-1,1\}$ しか出てこない（$0$ は飛ばせばいいので）ので, 掛け算が必要なく, 足し算だけで事足りる.

## BitNet b1.58

提案するアーキテクチャは, Transformer の中の `nn.Linear` 部分を `BitLinear` に置き換えるというもの.
訓練時は重みが 1.58bit, 活性化部分では 8bit で扱う.

### 量子化関数

*absmean* 関数を採用している.

重み行列 $W$ について,

- $\tilde{W} = \mathrm{RoundClip}(\frac{W}{\gamma + \epsilon}, -1, 1)$
- where
    - $\mathrm{RoundClip}(x, a, b) = \max(a, \min(b, \mathrm{round}(x)))$
    - $\gamma = \frac{1}{nm} \sum_{i,j} |W_{i,j}|$

活性化

BitNet と同じ.
TODO: 後で読む

### その他のコンポーネント

全て LLaMA と同じものを使う. ただしバイアス項は全て削除した

- RMSNorm
- SwiGLU
- rotary embedding

## 結果

LLaMA 16FP と比較してる.
モデルサイズ（必要メモリサイズ）も PPL も下がってるので最高.

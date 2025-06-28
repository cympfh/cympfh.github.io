% Detecting Erroneous Sentences using Automatically Mined Sequential Patterns
% http://citeseerx.ist.psu.edu/viewdoc/summary?doi=10.1.1.129.893
% 自然言語処理 自動翻訳

英語文の erroneous を検出する

- ESL (English as a Second Language) の書いた文章の添削
- 機械翻訳の精度向上

## Erroneous

一般にESLによる共通したミスとは
[Yukio+ 01, Gui and Yang 03]

1. スペル
1. コロケーション
1. 文構造
1. 時制
1. agreement
1. verb formation
1. wrong POS
1. 冠詞

などなど

- ここではスペルミスについてはキニシナイ
- まあ普通に文法のミスのこと

## LSP (Labeled sequential pattern)

語の列 `LHS` と、クラス `c` からなる
`LHS -> c` を `LSP` と呼ぶ  

いわゆるパターンが `LHS` であり  
それにマッチするなら属すると期待されるクラスとの2つ組を持って考える

列 (`LHS`) を $<a_1 ... a_m>$ で表現する

### 包含関係

列 $<a_1 ... a_m>$ が
列 $<b_1 ... b_n>$ に含まれるとは

$a_j = b_{i_j}$ for an $1 \leq i_1 < i_2 < ... < i_m \leq n$

とあること  
即ち、$a_i$が全てもれなくただし順序を保って$b_j$に出現すること

LSP (`p`) の包含関係は  
それのLHS (`p.LHS`)の包含関係かつ、クラス (`p.c`) が等しいこと

### 指示度、確信度

指示度 (support) と 確信度 (confidence) を適当に定義する

LSP `p` について、

- `sup(p)` とは、訓練事例 (Database) 中で `p` が含む文の割合
- `conf(p)` とは、`sup(p) / sup(p.LHS)`

## クラス

今のタスクに於いてクラスとは次の2つ

- `Correct`
- `Error`

## 列 `LHS` の生成

単語も単語クラスとしてのPOSも同列に使う

1. 機能的語 [function words](https://web.archive.org/web/20020828162751/http://www.marlodge.supanet.com/museum/funcword.html)
のkey word list を作る
1. key word list にある語はそのまま
1. 無いものはPOSを使う

これは元の文の長さと同じ長さの `LHS` が出来るだけだ

### example

次のようなものが理想的 (confは100%ではないことに註意)

- `<a, NNS> -> Error`
    - `NNS` は複数形
- `<yesterday, is> -> Error`
- "In the past, John was kind to his sister"
    - In the past, NNP was JJ to his NN

### LSPの抽出 (マイニング)

`sup` と `conf` に下限の閾値を与えた
frequent sequence mining algorithm [Pei+ 01]
を用いて作る

- minimum support = 0.1%
- minimum confidence = 75%


## 参考文献

1. [function words](https://web.archive.org/web/20020828162751/http://www.marlodge.supanet.com/museum/funcword.html)
1. [Pei+ 01] J.Pei, J.Han, B.Mortazavi-Asl, H.Pinto: Prefixspan: Mining sequential patterns efficiently by prefix-projected pattern growth

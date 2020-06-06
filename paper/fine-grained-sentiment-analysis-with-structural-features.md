% Fine-Grained Sentiment Analysis with Structural Features
% http://aclweb.org/anthology/I/I11/I11-1038.pdf
% 自然言語処理 極性分析 MarkovLogic

## 概要

商品のレビューテキストの極性判定を行いたい.
極性判定では結局全体として肯定なのか否定なのか調べるために構造的に調べることは必須である.
この論文は構造を考慮するために
Markov Logic Networks (MLNs) を用いる手法を提案する.
セグメントごとの極性判定で正解率 69% の判定を行った.
全体の極性判定はやってないらしい (そっちが重要やろうが).

## 考察

商品のレビューは一つのレビューの中に肯定と否定が交じることもある:

> "Despite the pretty design I would never recommend it,
> because the sound quality is unacceptable"

だから sub-sentence レベルでの解析が必要.

### discourse segments

関連研究として

- Rhetorical Structure Theory (RST) introduced by Mann and Thompson (1988)

これによると、
discourse セグメントの単位で解析をして、セグメント同士の関係を調べるのが良いらしい.

先ほどの例文は次のように分割されるべきらしい:

1. Despite the pretty design
2. I would never recommend it
3. because the sound quality is unacceptable

そしてこれらはこのような接続関係を持つ

- CONCESSION 1 2
- CAUSE-EXPLATINATION-EVIDENCE 2 3

### 隣接セグメント

多くの場合、隣接したセグメントは同じ極性を持つ

### 対比関係

but で接続された隣接するセグメントの極性が同じかどうかは結構微妙で、
彼らが調査したところ、
40% は反対の極性で、60% は同じ極性を持っていたという.

極性を反転させているかどうかの判定が必要である.

### 辞書的分類

古典的ながら (この論文自体が古典だが) 確実そうなのは、
極性辞書 (語と極性とのペアを集めたもの) を持っておいて、
登場した語が辞書に乗っていたらそれを参照するというものである.

## Markov Logic による極性判定の形式化

セグメント $x$ について、これが positive であるか negative であるかを述語論理

- $P(x)$
- $N(x)$

で書くことにする.
この２つについて次を認める.

- $\lnot P(x) \Rightarrow N(x)$
- $\lnot N(x) \Rightarrow P(x)$

### 辞書による事前知識

- $PS(x) \iff P(x)$
- $NS(x) \iff N(x)$

ここで PS は positive source の略.
NS も同様.

ここが一番重要な気がするけど、WordNet を使ってどうこうとかルールベースで頑張ってるだけという感じ.

### 隣接セグメント

２つのセグメント $x, y$ が隣接していることを述語 $pre(x,y)$ で書くとき、

- $pre(x,y) \land P(x) \Rightarrow P(y)$
- $pre(x,y) \land N(x) \Rightarrow N(y)$

これは隣り合うセグメントは同じ極性を持ちやすいことを言う.

### 対比関係

2つのセグメントが対比関係にあるのを述語 $cont(x,y)$ で、
対比関係でないのを述語 $nconst(x,y)$ で書くとき、

- $cont(x,y) \land P(x) \Rightarrow N(y)$
- $cont(x,y) \land N(x) \Rightarrow P(y)$
- $ncont(x,y) \land P(x) \Rightarrow P(y)$
- $ncont(x,y) \land N(x) \Rightarrow N(y)$


## 実験

Amazon のレビューで実験.
SVM が56% で提案手法の max が 69%.

## 感想

本当に MLNs の貢献なのか大変に疑わしいし、
ルールベースにルールベースを積み重ねたような古典的手法だと思った.
今なら LSTM に読ませるだけでももっとまともな精度が出そう.

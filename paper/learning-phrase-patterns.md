% Learning Phrase Patterns for Text Classification
% http://ieeexplore.ieee.org/xpl/articleDetails.jsp?arnumber=6457440
% 自然言語処理 テキストマイニング テキスト分類

## Intro

テキスト分類.
N-gram なんかで十分な精度はある.
けれどもドメインに特化してしまうこと,
application に依存してしまうことから一般性がない.
n-gram に補充する素性の一つとして, phrase pattern を使いたい.

## 先行研究

- Jaillet+, 2006
    - topic categorization
-  Wiebe+, 2005
    - 一人称を教師無しで当てる
    - 目的語を含むようなフレーズパターンを作って分類
- Sun+, 2007
    - 第二外国語学習者の書いた誤文法を検出
- Thur+, 2010 and Davidov+, 2010
    - TwitterやAmazonレビューから「皮肉」な文を検出
- Zhang+, 2010
    - N10-1108 で紹介したとおり,  N-gram よりも高精度であった！（まだ読んでない）

## Phrase Pattern

単純パターンと, その拡張版の拡張パターンの定義を述べる

### 単純パターン

文を word の列
$u = [u_1, u_2 .. u_n]$
とみなすのと全く同様に, パターンも word の列
$w = [w_1, w_2 .. w_m]$
として定義する.

また, パターン $w$ が文 $u$ にマッチすることを次で定める.
$$w \preceq u \iff \exists ( 1 \leq j_1 < j_2 < \cdots < j_m \leq n ) ,~ \forall i ,~ w_i = u_{j_i}$$
すなわち部分列であること.

### 拡張パターン

word に加えて word class の概念も使えるように拡張する.
class の使い方はこれに限定しないが, 例えば単語に対して品詞だとか極性などがあるだろう.
同時に複数の class を割り当てることを考える.

word $w$ に対して $n$ 種類の class $\{c_1, \ldots, c_n\}$ があるときに
$w$ を考える代わりに,
$$\{w, c_1, \ldots, c_n \}$$
という集合を一つの word だと思って扱うことにする.
これを文とパターンに適用する.

マッチは, 部分列であって各要素が部分集合であることとする.
(さっきのマッチの定義の $=$ が $\subset$ に代わった.)

$$w \preceq u \iff \exists ( 1 \leq j_1 < j_2 < \cdots < j_m \leq n ) ,~ \forall i ,~ w_i \subset u_{j_i}$$

## パターンの学習

拡張パターンの学習方法として PrefixSpan を挙げる.
ここには挙げないけど CloSpan っていうのもある.

### PrefixSpan [Pei, Han+, 2001]

コーパス (文集合) $D$ から頻度 $f$ 以上の単純パターンを効率的に列挙する手法.
$\rho$ (`rho`) を接頭辞に持つものに再帰的に後ろに付け足して列挙してく.

```python
def PrefixSpan(D, rho, f):
  A = [a for all tokens in D, and count(a) >= f]

  P = []  # pattern set as return value
  Q = []  # new patterns

  for a in A:
    q = append(rho, a)
    if match_freq(D, p) >= f:
        A.append(q)

  for a in A:
    q = assemble(rho, a)
    if match_freq(D, q) >= f:
        A.append(q)

  P = P.extend(A)

  for a in A:
    D2 = project(D, a)
    B = PrefixSpan(D2, a, f)
    P = P.extend(B)

  return P
```

`match_freq` はマッチする回数.

`append` および `assemble` はパターンとトークンから新しいパターンを作る.

```python
def append(rho, a):
  return rho.append({a})

def assemble(rho, a):
  init = rho[0:-1]
  last = rho[-1]
  return init.append(last.union({a}))
```

すなわち, パターン
$\[ a_1, a_2, \ldots, a_n \]$
に $s$ を付け足す方法として,

1. append
    - $\[ a_1, a_2, \ldots, a_n, \{s\} \]$
1. assemble
    - $\[ a_1, a_2, \ldots, a_n \cup \{s\} \]$

があると言っている.

また, コーパス $D$ についてのパターン $\rho$ による project とは,
$\rho$ にマッチする文だけフィルタリングしたもの.

```python
def Project(D, rho):
    return set(match(rho, s) for s in D)
```

ただし実際には文全体を持たないで,
最小マッチをさせてその後ろ部分 (postfix) だけを持つようにする.
そうすると, 次にパターンに付け足す候補はそれの頭１文字だけになる.

### 尺度

先のアルゴリズムでは, 頻度という尺度でパターンを採択するか決めていたが,
相互情報量のほうがいいだろう.

コーパス $D$ の各文にクラス $Y = \{ 1, 2, \ldots, K\}$ が与えられ,
また, あるパターン $p$ がマッチするかどうかが $X_p = \{0,1\}$ も与えられているとする.
このとき, $X_p, Y$ の間の相互情報量が次で与えられる.

$$I(X_p;Y) = \sum_{x} \sum{y} p(x,y) \log \frac{p(x,y)}{p(x)p(y)}$$

これは次のように書き換えると計算効率上都合が良くなる.

$$I(X_p;Y) = \sum_{x} \sum{y} p(x \mid y) p(y) \log \frac{p(x \mid y)}{\sum_{y'} p(x\mid y')p(y')}$$

今, パターン $p$ を拡張 (append, assemble) して $p'$ を得た時,
頻度は必ず非増加だから,
$$p(X_p' = 1 \mid y) \leq p(X_p = 1 \mid y)$$
である.
従って相互情報量も上から抑えることが出来る.
$$I(X_p';Y) \leq I(X_p; Y)$$

この値に関して枝刈りをしながらパターンを探索するような方法も考えられる.

## Word Classes

どんな word class が実用的にありえるか考えてみる.

### Lemma (語の標準形)

```haskell
{go, goes, going, went gone} -> go
```

NLTK WordNet lemmatizer を使う

### Word shape

大文字の使われ方.
全部大文字になってるか, 最初だけか, ドットで連結した大文字（つまり省略形）か.

### POS

いわずもがな.
Stanford log-lenear POS tagger ってのがあって, 
英語と中国語に対して使える？らしいよ.

### Named entity (NE)

テキスト分類についてはこれはすごい大事な素性.

```
(sentence, word) -> class ({Location, Person, Organization, Time, Date})
```

Stanford conditional random field-based NE recognizer (NER)
なるものが良いって.

### LIWC dictionary ($89.95)

Linguistic Inquiry and Word Count (LIWC)
は, 単語を64の(感情の?)クラスに分類する.
Facebookが使った奴.
文脈に依存せず, 一つの単語について分析する.

[LIWC: Linguistic Inquiry and Word Count](http://www.liwc.net/tryonline.php)

### MPQA subjectivity lexicon

under GNU GPL

自己申告で個人情報送ると即座にダウンロードできる.
[Subjectivity Lexicon | MPQA](http://mpqa.cs.pitt.edu/lexicons/subj_lexicon/)

```haskell
(word, POS) -> class
```

8222 (word, POS) 登録されてる.

```
type=weaksubj len=1 word1=dominate pos1=verb stemmed1=y priorpolarity=negative
```

### manual

> we use various word listsc onstructed by linguists who have looked at data related to some of our tasks.

つまり手作業で, 
あるクラスに属する単語のリストを作る.
これは, タスクごとに, そのトピックに詳しい人間がやる.

例えば, 後の実験で使った例では, 

```haskell
AGREEMENT = [right, agree, true]
DISAGREEMENT = [doubt, inappropriate]
ALIGNMENT = AGREEMENT ++ DISAGREEMENT
MODAL = [could, should]
NEGATIVE_DISCOURSE_ORDER = [however, but, nevertheless]
```

### automatic

1次マルコフモデルを使って, 
wordをクラスタリングする.
クラスた数は 10, 100, 1000 ってする.

Brown+, 1992
"Class-based n-gram models of natural language"

### 実験

n-gramと他の素性を使えば十分に分類可能なタスクは
してもしょうがないので, 
それなりに難しいタスクを３つやる.

- speaker role
- alignment move
- authority claim

初めに訓練データでパターンを学習して, 
n-gramの場合と, パターンの場合を比較する.
公平のために, n-gramは3-gramまで, 
パターンも長さ3までにする.

- Maximum entropy classification
    - $P(c|d) = \frac{1}{Z_d} \exp \left[ \sum_i \lambda_i f_i \right]$
- 5-fold cross validation

#### Speaker role

ニュースショーにおける, (人, その人が発した言葉) から, 
その人のショーにおける役割をあてる.
役割とは, Host, Guest, Voice bite

Liu+ 80%

48 English talks and 90 Mandarin talks の録音に対して, 
REF (Reference human transcripts) と
ASR (automatic speech recognition) output
(using SRI Decipher ASR system)
を対象にする.

ASR は, 結構間違えることに註意.
英語については22.8%
北京語については38.6%
くらい, 単語/文字を誤る.

kappa = 0.67 / 0.78

#### Alignment move

ネット上の議論において, 
参加者の同意(positive), 異論(negative)
を見る.
文に対して,  pos/neg をつける.
あるアノテータがposをつけて, あるアノテータがnegを
つけたら pos+neg というラベルにする.

実験で使うのは
Wikipedia talk page

211 English pages and
225 Chinese pages

kappa = 0.50 / 0.53

で, たまに pos/neg 両方を含むような面倒な文がある.
そこで, 
pos/none, neg/none の２つの分類器を作って

#### Authority claim

> showing her knowledge or experience with respect to a
topic, or using some external evidence to support herself

Marin+, 2010:
Unigramで実際けっこういい.
(外のページヘの引用とかがある)

339 English pages and
225 Chinese pages

発言ごとに, authority claimであるかどうか.

kappa = 0.59 / 0.73

全体の20%がauthority claim であった.

### Result

表は適宜参照のこと.
ここには書くことはしない.

Table I は, PrefixSpan と, ExtendedPrefixSpan との差を見る.
$-0.2%$ から $+4.1%$ とか.

Table II から VII は, baseline (with only n-gram) と, pattern (with each class) との比較.

Speech role は, REFでもASRでも十分な結果が得られている.
つまり, 頑強である.

manualは利用ならば, それが最強

Wikipedia English pages alignmentについてのパターンとして, 

```
i ALIGNMENT MODAL
a POSITIVE #idea
```

とか.

あ, そうそう. 英語のパターンの場合は, 
２つのトークンが連続で出現してなくてもマッチするわけだけど, 
上のように`#`というのは, 連続であることを意味するらしい.
初めからそうすればいいのにね.

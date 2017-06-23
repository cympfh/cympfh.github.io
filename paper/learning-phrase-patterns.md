% Learning Phrase Patterns for Text Classification
% http://ieeexplore.ieee.org/xpl/articleDetails.jsp?arnumber=6457440
% 自然言語処理 テキストマイニング テキスト分類

## Intro

テキスト分類.
N-gram なんかで十分な精度はある.
けれどもドメインに特化してしまうこと、
application に依存してしまうことから一般性がない.
n-gram に補充する素性の一つとして、phrase pattern を使いたい.

## 先行研究

### Jaillet+, 2006
topic categorization

### Wiebe+, 2005

文章の一人称を教師ナシで
これは目的語を含んだフレーズパターンで分類した.
先行研究よりも高い精度.

### Sun+, 2007

第二外国語学習者の書いた誤文法を検出.

### Thur+, 2010 and Davidov+, 2010

TwitterやAmazonレビューから「皮肉」な文を検出

### Zhang+, 2010

memo/N10-1108.md

で紹介したとおり、 N-gram よりも高精度であった！（まだ読んでない）

# 手法

## phrase pattern

普通パターンと言う場合の素のやつと、拡張バージョンのパターンの定義と、
パターンが文にマッチする、の定義を述べる.

### 素 phrase pattern

文を word の列
$u = [u_1, u_2 .. u_n]$
とみなすのと全く同様に、
phrase pattern もまた、word の列
$w = [w_1, w_2 .. w_m]$
とする.
これが、先の文にマッチするとは、sub sequence になっていること.

すなわち、
$$u \preceq w \iff \exists \{ j_1 < j_2 < .. < j_m \} .~ \forall i .~ w_i = u_{j_i}$$

### extend

語の列でなく、word class も利用したい.
word class としては、POS とか polarity とかを使い、制限しない.
word $w$ の
$n$ 種類のclass が (文脈に依存して)
$\{c_1 .. c_n\}$
であるとき

語 $w$ を考える代わりに
$\{w, c_1 .. c_n \}$
という集合を一つの語だと見なすことで拡張する.

文と、phrase pattern ともに、この拡張を適用できる.

すなわち、
文とは以前と変わらずに word の列
$u = [u_1, u_2 .. u_n]$
であるが、
phrase pattern を
$v = [v_1, v_2 .. v_m]; v_i = \{ w_i, c_{i1} .. c_{in} \}$
とする.

マッチングを
$$u \preceq v \iff \exists \{ j_1 < j_2 < .. < j_m \} .~ \forall i .~ u_{j_i} \in v_i$$
とする.


## learning

拡張バージョンの phrase pattern を学習するアルゴリズムを一つ挙げる.
他には CloSpan っていうのもある.

### PrefixSpan (Pei, Han+, 2001)

コーパス `D` (文の集合) から、閾値 `f` 以上の頻度のあるような
素 phrase pattern を得る.

python-like コードで以下に示すが、これは、
prefix `rho` について、
先頭から再帰的に付け足すような再帰でパターンを得る.
`rho = []` からスタートする.

```python
def PrefixSpan(D, rho, f):
  P = [] # pattern set as return value
  A = [] # new patterns

  for_each a in D: # a is a token
    rho' = append(rho, a)
    A.append(rho') if match_freq(D, p) >= f
  for_each a in D: # a is a token
    rho' = assemble(rho, a)
    A.append(rho') if match_freq(D, p) >= f

  P = P.extend(A)

  for_each rho' in A:
    D' = project(D, rho')
    B = PrefixSpan(D', rho', f)
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

言い直すと、

パターン `[{w1,c1..c1} .. {wn,cn..cn}]` に `s` をつけたす方法として、

- `[{w1,c1..c1} .. {wn,cn..cn}, {s}]`  # append
- `[{w1,c1..c1} .. {wn,cn..cn, s}]`  # assemble

がある、って言ってる.

あと、コーパスDについてのパターンrhoによるproject とは、
マッチする文だけフィルタリングしたもの.

```python
def Project(D, rho):
  D' = []
  for_each s in D:
    D' = D'.append(s) if match(rho, s)

  return D'
```

論文に載ってるのはもうちょっと複雑で、
効率よく動くようになってる.
上の場合、
パターン `[w1]` を採択したら、
`project` で それにマッチする文だけを集めて、
次は `[w1, w2]` を見る.

しかし、
先頭から作って行くのだから、
`project` の定義を、マッチした文、じゃなくて、マッチした文のマッチより後ろ部分だけ、にすることで、
`[w2]`を見ればよくなる.

## 尺度

先のアルゴリズムでは、頻度という尺度で、
パターンを採択するか決めていたが、
相互情報量のほうがいいだろう.

コーパスD に、クラス `Y = 1, 2 .. K` があって、
変数`X`はあるパターンがマッチするかどうか(`X=0,1`) とすると、

定義通りには、

```haskell
I X Y = sum [ sum [ (p x y) * log ((p x y) / (p x) / (p y))  | y <- [1..K] ] | x <- [0,1] ]
```

次のように書き換えると、計算しよい. (計算効率をおとさない)

```haskell
p_given x y -- probability of x given y
I X Y = sum [ sum [ (p_given x y) * (p y) * log ((p_given x y) / p_x) | y <- [1..K] ] | x <- [0,1] ]
  where
    p_x = sum [ p_given x y' * p y' | y' <- [1 .. K] ]
```

で、えっと、あるパターン `p` について の、`X`に対して
そのパターンを拡張した時のそれを `XE`と書くと、
$$p(XE=1|y) \leq p(X=1|y)$$
が当然なりたつ.
したがって、相互情報量の上限
$$\sup_E I(XE;Y)$$
が存在する (まじで？？？).

改訂版のアルゴリズム
`ExtendedPrefixSpan`

```python
def ExtendedPrefixSpan(D, rho, Theta):
  P = []

  for_each t in D:
    rho' = rho.append(t)
    rho' の相互情報量 が閾値以上なら、
      P = P.append(rho')

    else 上限が閾値を超えるなら
      D' = project(D, rho')
      P' = ExtendedPrefixSpan(D', rho', Theta)
      P = P.extend(P')

  return P
```

# Word Classes

## Lemma

canonical form of a word のこと.

```haskell
{go, goes, going, went gone} -> go
```

NLTK WordNet lemmatizer を使う

## Word shape

大文字の使われ方.
全部大文字になってるか、最初だけか、ドットで連結した大文字（つまり省略形）か.

## POS

いわずもがな.
Stanford log-lenear POS tagger ってのがあって、
英語と中国語に対して使える？らしいよ.

## Named entity (NE)

テキスト分類についてはこれはすごい大事な素性.

```
(sentence, word) -> class ({Location, Person, Organization, Time, Date})
```

Stanford conditional random field-based NE recognizer (NER)
なるものが良いって.

## LIWC dictionary ($89.95)

Linguistic Inquiry and Word Count (LIWC)
は、単語を64の(感情の?)クラスに分類する.
Facebookが使った奴.
文脈に依存せず、一つの単語について分析する.

[LIWC: Linguistic Inquiry and Word Count](http://www.liwc.net/tryonline.php)

## MPQA subjectivity lexicon

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

## manual

> we use various word listsc onstructed by linguists who have looked at data related to some of our tasks. 

つまり手作業で、
あるクラスに属する単語のリストを作る．
これは、タスクごとに、そのトピックに詳しい人間がやる．

例えば、後の実験で使った例では、

```haskell
AGREEMENT = [right, agree, true]
DISAGREEMENT = [doubt, inappropriate]
ALIGNMENT = AGREEMENT ++ DISAGREEMENT
MODAL = [could, should]
NEGATIVE_DISCOURSE_ORDER = [however, but, nevertheless]
```

## automatic

1次マルコフモデルを使って、
wordをクラスタリングする．
クラスた数は 10, 100, 1000 ってする．

Brown+, 1992
"Class-based n-gram models of natural language"

# 実験

n-gramと他の素性を使えば十分に分類可能なタスクは
してもしょうがないので、
それなりに難しいタスクを３つやる．

- speaker role
- alignment move
- authority claim

初めに訓練データでパターンを学習して、
n-gramの場合と、パターンの場合を比較する．
公平のために、n-gramは3-gramまで、
パターンも長さ3までにする．

- Maximum entropy classification
    - $P(c|d) = \frac{1}{Z_d} \exp \left[ \sum_i \lambda_i f_i \right]$
- 5-fold cross validation

## Speaker role

ニュースショーにおける、(人, その人が発した言葉) から、
その人のショーにおける役割をあてる．
役割とは、Host, Guest, Voice bite

Liu+ 80%

48 English talks and 90 Mandarin talks の録音に対して、
REF (Reference human transcripts) と
ASR (automatic speech recognition) output
(using SRI Decipher ASR system)
を対象にする．

ASR は、結構間違えることに註意．
英語については22.8%
北京語については38.6%
くらい、単語/文字を誤る．

kappa = 0.67 / 0.78

## Alignment move

ネット上の議論において、
参加者の同意(positive)、異論(negative)
を見る．
文に対して、 pos/neg をつける．
あるアノテータがposをつけて、あるアノテータがnegを
つけたら pos+neg というラベルにする．

実験で使うのは
Wikipedia talk page

211 English pages and 
225 Chinese pages

kappa = 0.50 / 0.53

で、たまに pos/neg 両方を含むような面倒な文がある．
そこで、
pos/none, neg/none の２つの分類器を作って

## Authority claim

> showing her knowledge or experience with respect to a
topic, or using some external evidence to support herself

Marin+, 2010:
Unigramで実際けっこういい．
(外のページヘの引用とかがある)

339 English pages and
225 Chinese pages

発言ごとに、authority claimであるかどうか．

kappa = 0.59 / 0.73

全体の20%がauthority claim であった．

## Result

表は適宜参照のこと．
ここには書くことはしない．

Table I は、PrefixSpan と、ExtendedPrefixSpan との差を見る．
-0.2%から+4.1%とか．

Table IIからVIIは、baseline (with only n-gram) と、pattern (with each class) との比較．

Speech role は、REFでもASRでも十分な結果が得られている．
つまり、頑強である．

manualは利用ならば、それが最強

Wikipedia English pages alignmentについてのパターンとして、

```
i ALIGNMENT MODAL
a POSITIVE #idea
```

とか．

あ、そうそう．英語のパターンの場合は、
２つのトークンが連続で出現してなくてもマッチするわけだけど、
上のように`#`というのは、連続であることを意味するらしい．
初めからそうすればいいのにね．

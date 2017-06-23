% Class-based n-gram models of natural language
% http://dl.acm.org/citation.cfm?id=176316
% 言語モデル 自然言語処理

Brown+ら．

[Learning phrase patterns for Text Classification](memo/learning-phrase-patterns.md)
中で、

> 単語のクラスを1次マルコフモデル尤度を最大化することによって自動分類した

とあって引用されていた．

# Introduction

noisy channel 経由で来た、歪んだ英語の文章を元に戻したい．これが第一の議論である．
それに関与することとして、単語にクラスを当てはめることを統計的にしたい．これが第二の議論である．

# 言語モデル

次のような言語モデルを考える．

English text は語の列．

```python
w[1:k]
```
これを、条件付き確率

```python
Pr(w[k] | w[1:k-1])
```
で特徴づける．
文章全体が出来上がる確率はこうだ．

$Pr(w[1:k]) = Pr(w[1]) \cdot Pr(w[2] | w[1:1]) \cdot Pr(w[3] | w[1:2])  \cdots  Pr(w[k] | w[1:k-1])$

<blockquote>
python-like なつもりで書いたけど、

```python
w[i:j]
```
は、列

```tex
{w_i, w_{i+1}, ..., w_j}
```
を表す．
ここで `i <= j` を暗黙的に前提する．
</blockquote>

意味を言えば、`w[1:k-1]`がhistoryであり、`w[k]`がpredictionである．

## n-gram

n-gram language model では、
history の内の最後の `(n-1)` words だけを見る．
それが同じなら同じ history だと見做す．

すなわち

```python
Pr(w[k] | w[1:k-1]) = Pr(w[k] | w[k-n+1 : k-1])
```

とする．ただし `k >= n` と仮定してる．

そうでない場合の確率は特別に扱わなければ．
例えば 2-gram model では、
history には `V (V-1)` 通りある (V = size of vocabulary)．
それと別に `Pr(w[2] | w[1])` が `V - 1` 通りある．

ではそれらの確率をどっからもってくるか．
training text における最尤推定、すなわち、
数えて割合を出すことをする．

`C(w)` は training text における `w` の頻度数．

$Pr(w[n] | w[1:n-1]) = \dfrac{C(w[1:n-1] w[n])}{\sum_w C([1:n-1] w)}$

ここで、`w[1:n-1] w` は、列の末尾にword を一つ追加した新しい列を意味する．

## interpolated estimation (Jelinek and Mercer, 1980)

vocabulary は大きければ良い．
しかしながら、n-gram の `n` が増えるにしたがって、指数的に、頻度は減っていく．
単純に、`n`は大きいほうがモデルの精度としては上がるけれど、
固定された語彙に対しては、信頼性が減っていく．

interpolated estimation と呼ばれるものは、
いくつかの言語モデル $Pr^{(j)}$ を構築して、それらをcombineすることで、$Pr'$ を得る．

$$Pr'(w[i] | w[1:i-1]) = \sum_j \lambda_j(w[1:i-1]) Pr^{(j)}(w[i] | w[1:i-1])$$

重み $\lambda_j$ は EMアルゴリズムで作る．

# Word Classes

意味的にか、構造的にか、ある語とある語が似ているということがある．
`(Thursday, Friday)`
とかね．

vocabulary `V`, classes `C` があって、語 `w` をclass `c` に写す写像を `pi` とする．

```python
pi(w) = c
```

## n-gram class model

写像 `pi` が既に与えられた上で、クラスを用いた n-gram model を次のように定める．

```python
Pr(w[k] | w[1:k-1]) = Pr(w[k] | c[k]) Pr(c[k] | c[1:k-1])
```

ここで、n-gram とする以上、

```python
Pr(c[k] | c[1:k-1]) = Pr(c[k] | c[k-n+1 : k-1])
```
とする．

training text から、右辺の2つの確率を最尤推定する．

まず、簡単な 1-gram の場合は、

```python
Pr(w | c) = C(w) / C(c)
Pr(c) = C(c) / T
```

ここで、`T` は、training text 中の word 数である．
training text は、 `t[1:T]` と書けて、
`C(c)`は、`length(map(pi, t))` である．

2-gramなら、
$Pr(c[2] | c[1]) = \dfrac{C(c[1]c[2])}{\sum_c C(c[1] c)}$
となる．

## 尤度

$L(pi) = (T - 1)^{-1} \log Pr(t[2:T] | t[1])$

これを尤度とする．2-gram model の下でこれを式変形すると、

$L(pi) = \sum_{w_1, w_2} \dfrac{C(w_1 w_2)}{T-1} \log Pr(c_2 | c_1) Pr(w_2 | c_2)$

さらにうわぁーってやると、

$L(pi) = -H(w) + I(c1, c2)$
ここで、`H`はエントロピー、`I`は相互情報量．
`w` は training text から降ってくるから、

`L(pi)`を最大化するような`pi`を選択する、というのは、
相互情報量を最大化するようなクラス分類を選択することになる．

## Prictical

We know of no practical method to find max `I`, or the `I` is the maximum or not.

### greedy algorithm

- goal:
classifying `V` words into `C` classes (`V > C`)

- initially, distincts words to each classes, that is there are `V` classes
- do class merge `V-C` times (in a step, one merge be done)
- Then, we get `C` classes remained

The step is described recursively as follows.
After `V-k` merges, we got `k` classes

```
C_k(1), C_k(2), ..., C_k(k)
```

we think of the merge of `C_k(i)` with `C_k(j)`
where `1 <= i < j <= k`.

```python
p_k(l, m) = Pr(C_k(l), C_k(m))
```

This is the probability of that
the class `C_k(m)` follows after the class `C_k(l)`
in the text.

let
$pl_k(l) = \sum_m p_k(l, m)$

let
$pr_k(m) = \sum_l p_k(l, m)$

let
$q_k(l, m) = p_k(l, m) \log \dfrac{p_k(l, m)}{pl_k(l) pr_k(m)}$

The mutual information of the `k` classes is denoted by

$I_k = \sum_{l,m} q_k(l, m)$

The new class merged `C_k(i)` and `C_k(j)` is denoted by `i + j`.

$p_k(i+j, m) = p_k(i, m) + p_k(j, m)$
$q_k(i+j, m) = p_k(i+j,m) \log \dfrac{p_k(i+j,m)}{pl_k(i+j) pr_k(m)}$

and the mutual information after the merge is

$I_k(i,j) = I_k - s_k(i) - s_k(j) + q_k(i,j) + q_k(j,i) + q_k(i+j,i+j) + \sum_{l \ne i,j} q_k(l, i+j) + \sum_{m \ne i,j} q_k(i+j,m)$

where
$s_k(i) = \sum_l q_k(l, i) + \sum_m q_k(i, m) - q_k(i,i)$

So, we will find the pair `(i,j)`
such that the mutual information loss
$L_k(i,j) = I_k - I_k(i,j)$
is least.

### Classes gotten with this alogrithm

- Friday, Monday, ... Sunday, weekends
- June, March, July ...
- people guys folks fellows ...
- down, backwards, ashore, sideways ...
- water, gas, coal, liquid ...
- had, hadn't hath would've could've ...

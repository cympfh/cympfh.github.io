% Exploring Twitter Hashtags
% http://arxiv.org/pdf/1111.6553.pdf
% 自然言語処理 twitter

2011年の論文なので古い部類だろうなあ

## Intro

SMS language

1. abbreviation (e.g. "4 u")
1. emoticons (e.g. ":)" )

Twitter-specific forms

1. @-replies
1. hashtags

### 例.

> @merazindagi Thanks! Will make more 4 U. Live performances in
> #boulder area will be on http://saxy.us :) #jazz #rock #funk
> #dance #livemusic

ハッシュタグはそのツイートが何の目的であるかを教えてくれるが、
複数のツイートが沢山含まれるようなものは一体何なのかわからなくなる.
そこで、co-occurrences に基づく辞書の構築を目指す.
分類器の構成を考え，最終的にアプリケーションを作成する

## Dataset

29,000,000 tweets から、
ノイズの少ない 310,000 種類のハッシュタグは取り除いて、
85,503 種類を使った

## Hashtag co-occurrences

### Dictionary

共起 where ハッシュタグ $h_i, h_j$:

$$C(h_i, h_j) = \# \{ t : t \in \text{tweets},
\text{has}(t, h_i)
\land
\text{has}(t, h_J) \}$$

辞書:

$$D(h) = \{ (h', C(h, h')) : h \ne h' \}$$

### Similarity of two hashtags

$$\text{synnet}: h \mapsto s$$

類似度関数:
$$S(h_1, h_2) = \max \{ S'(s_1, s_2 :
s_1 \in \text{synset}(h_1),
s_2 \in \text{synset}(h_2) \}$$

$S'$ として、

PythonのnltkのWordNet module には、
次の2種類が組み込まれている

1. path distance similarity
1. Wu-Palmer distance

それぞれ、Spath, Swp と呼ぼう．

どちらも数字が大きいほうが近いことを意味する

実際の値を見てみると、

|                           | Spath | Swp  |
| :-                        | :-    | :-   |
| 共起ハッシュタグ          | 0.12  | 0.37 |
| Twitter (ランダムな2単語) | 0.07  | 0.26 |

って感じ．

## Clustered graph

共起してたら枝をつなぐ，でグラフがかけた．
連結成分というクラスらリングもできる．

## Classification

### hashtag classes

まあハッシュタグは何かそのものを表しているわけだけど，

1. `organization`
1. `geolocation`
1. `person`
1. `event`: particular interest on Twitter
1. `category`: all other hashtags

に分類するのを第一目標とする

例として，

| class  |  example hashtags |
|:------ |:----------------- |
| organization | #google, #nokia       |
| geolocation  | #europe, #uk, #graz   |
| person       | #obama, #madonna      |
| event        | #christmas, #election |
| category     | #fun, #math, #ipod    |

## 学習

最大エントロピー (MaxEnt) で学習する

### features

- ハッシュタグ周りの window size 5 の words
- その words の shape
- その words の POS tag
- その words の geographical background knowledge
- ハッシュタグの shape
- ハッシュタグがツイートの最初であるか


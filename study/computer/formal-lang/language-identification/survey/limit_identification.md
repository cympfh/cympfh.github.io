% Language Identification in the Limit

<section>
<div class="author">Gold</div>
<div class="title">Language Identification in the Limit</div>
<div class="public">Information and Control 10 (1967)</div></section>

# 動機: 子供の言語学習

正しい例 (instance) を子供は逐次的に受け取ることで子供は言語を学習していく.
これをモデルにしたAIを考えようというのが動機である.  
また実際の子供の場合は学習結果として自分で作文を行い,
結果正しい文を発話できたか否かを相手の反応から学習し,
それからなんらかの形で修正を加えるかもしれない.

# 言語の同定モデル

言語の学習モデルを考える

1. 学習の定義
1. 情報提示の方法
1. 名付け関係 (naming relation)

以上が、モデルに必要である.

3つめは言語自体を区別する行為である.
一つの文を与えられたときにそれが英語か日本語かを区別するみたいな?

情報提示の方法として、こうする  
まず時間とは有限時間から始まり量子化されたものだとする  
つまり
$$t=1,2,3,...$$
と書くもの

## 学習可能性

毎時間、未知の言語 $L$ に関する情報が提示される
$$i_1, i_2, i_3,...$$

学習という行為を手続き$G$とすると,
今までに提示された情報全てを用いて
$$g_t = G(i_1, i_2, \ldots i_t)$$
これを推測 (guess; guessing) という.
ただし推測するのは言語 $L$ の名前である

さて「極限における同定」とは、  
十分時間の経った時間以降、推測が同じになることである

また、「極限において同定可能」とは、  
効率的な $G$ が存在することである

極限であることの意味として、一つ挙げられている.  
学習者は自分がいつ正しく言語を学習できているかを知る必要はないのである

## 情報提示

提示される情報として2種類を考える.
text と informant である.
それぞれ次のように定められるもの

text とは、言語 $L$ から得られる文字列の列
$$x_1, x_2, ...$$
のこと.
時刻 $t$ において文字列 $x_t \in L$ を提示するわけ

さらに text に中でも3つクラスを定義することにする

1. Arbitary Text: 任意の関数 $f$ で $x_t = f(t)$
1. Recursive Text: 再帰関数 $f$ で $x_t = f(t)$
1. Primitive Recursive Text: 原始再帰関数 $f$ で $x_t = f(t)$

さて一方で、
informant
とは
文字列 $y_t \in A^+$ についてそれを提示するとともに
$L$
に含まれるか否かを提示する

1. Arbitary informant: 提示する文字列は任意の関数 $f$ で $y_t = f(t)$ と表されるもの
1. Methodical informant: 文字列は事前に列挙されていて逐次的に前から提示される
1. Request informant: 学習者が $y_t$ を選ぶ

## naming relation

1. tester
1. generator

`tester` は文字列が渡されてそれが言語 $L$ に属するかどうかを判定するもの

```haskell
tester :: String -> Bool
```

`generator` は実際に言語 $L$ を生成するもの

```haskell
generator :: IO [String]
```

## 等価性

### 学習モデルの等価性
ちょうど同じ言語族についてどちらであっても正しく
極限において同定するとき、
等価なモデルだとする

### naming relations の等価性
任意の情報提示についてそれぞれの
naming relation
を用いた学習モデルが等価

### 情報提示の等価性
任意の naming relations を用いた学習モデルが等価であること

極限同定 (identification in the limit)
とはパターン認識 (the pattern recognition literature) の枠組みでしばしば使われる
[Aizerman+, 1964].
学習者は、ステップごとに未知の object を渡されて、その名前を推測する.
有限の時間で持って、いつかは学習を完了し、
それ以降は常に、正しい推測が出来るようになる.

有限同定 (finite identification)
とは、普通に同定と言ったときに用いられる枠組みである.
最も有名なのはオートマトン理論
[Gill, 1961]
であろう.
学習者は、情報の提示を十分受け取ったと思ったら、
そこで提示を受諾を打ち止めなければならない.

固定時間同定 (fixed-time identification)
とは、予め与えられる情報の量 (時間、ステップ数) が固定されて有限であること.

ある object の class が極限同定可能であるとは、
何でもいいけど、効率的な推定アルゴリズム $G$ が存在すること.
効率を無視する場合は
非効率に極限同定可能 (ineffectively identifiable in the limit)
だという.

情報提示の(無限)列 (information string) $\{i\}$ としてあり得るものの集合を
$I^\infty(\omega)$
と書く.
一つの情報提示列は、ただ一つの object を表現するものである.
このようなとき、区別可能 (distinguishability) という.

collapsing uncertainty condition: よく分からん

# 極限同定の方法

# 非効率的な極限同定の方法

# text提示の弱さ

# 学習時間

# generator から tester への変換

# 帰納推論


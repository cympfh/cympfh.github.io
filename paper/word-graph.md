% Multi-Sentence Compression: Finding Shortest Paths in Word Graphs (Filippova, 2010)
% http://dl.acm.org/citation.cfm?id=1873818
% 自然言語処理 自動要約

## 概要

同じ内容を言っている複数の文から、より短く圧縮された一文を生成したい.
自動要約の中の一つのテクニックで文圧縮と呼ばれる.

論文の例を借りると

1. Hilary Clinton wanted to visit China last month but ...
1. Hilary Clinton paid a visit to the People Republic of China on ...
1. Last week ...
1. The wife of a former U.S. president Bill Clinton Hilary Clinton visited ...

という4つの文から

- Hilary Clinton visited China last Monday.

という文を作り上げる.

このためにこの論文は Word Graph という新しい概念を導入する.
Word Graph とはノードが単語であるようなグラフで、その上のパスがちょうど新しい文となる. エッジに重みを与えるｋとおで、短さと有用な単語を拾うことを保証する.

## Word graph

文を単語の列 $\{ w_i \}_{i=1}^n$ とする.
ただし `BOS` と `EOS` を列の最初と最後に付ける.
$w_i$ をノードとし、
文の隣り合った2単語
$w_i \rightarrow w_{i+1}$
を有向枝だとすることで一つの有向グラフを得る.

ただし表層的に同じ単語は同じノードであるとする.

複数の文から、ノードをマージしながら、このような一つのグラフを得る.
これを Word Graph という.

## パスの選択

構成した Word graph の `EOS` から `BOS`
へのパスを一つ選んだとき,
それはまぁ大体ほとんど文法的に正当な文である  
(どんなパスでも正当であるのかなぁ？)

1. This dog is a dog.
1. This is a dog.

```@dot
digraph {
    bgcolor=transparent;
    rankdir=LR;
    BOS -> This -> is -> a -> dog -> EOS;
    This -> dog -> is;
}
```

重要なワードをできるだけ拾うパスが必要である  
次のようにパスを重みを考えて, 小さなパスを良いとする  
実際には,
短さで $K$ 本のパスを列挙して,
エッジの重さでフィルタリングをする  
動詞を含むかとか、そういう最低限のフィルタリングもするみたい

### エッジの重み

エッジ
$e_{ij}: w_i \rightarrow w_j$
の重みを

$$
\frac{1}{\texttt{freq}(w_i) \texttt{freq}(w_j)}
\frac{\texttt{freq}(w_i) + \texttt{freq}(w_j)}{\sum_s \texttt{diff}(s, w_i, w_j)^{-1}}
$$

元の文章における一単語の頻度を freq,  
文章 $s$ における 単語 $w_i$, $w_j$ が順に出現したときにその単語の離れてる単語数 を pos とする.  
ちょうど隣り合っているとき, pos を 1 とする.  
出現しないとき pos を 0 とする  
分母がにゼロの逆数だから、重みはゼロになるよね  
(つまり出現しない2単語をいくら含んでても問題ないとしてる)  

### パスの重み

エッジの重みの平均とする

パスは短い方がいいだろうけど、それが考慮されてない気がする.  
足して $n$ で割る代わりに $\sqrt{n}$ くらいで割るとかさぁ

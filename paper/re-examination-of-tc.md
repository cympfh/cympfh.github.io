% A Re-Examination of Text Categorization Methods (1999)
% http://dl.acm.org/citation.cfm?id=312647
% 自然言語処理 テキスト分類 機械学習

次の5つの分類器によって
テキスト分類 する実験が世の中に散在してる。
(e.g.
[Text Categorization with Suport Vector Machines](http://dl.acm.org/citation.cfm?id=649721), 1998)

1. SVM
1. kNN
1. LLSF
1. NNet
1. NB

コーパスが違ったり、統計量検定が無かったりなので、
一回綺麗に実験し直そうというもの.

- コーパスとして、 `reuters-21578` を使う (1999時代のニュースタンダードらしい)
- 指標として、F値のmacro平均とmicro平均との2つを使う
- 手法同士の有意な差を図るのに、`{micro,macro}-{s,t}検定` をする

## 手法

分類器の原理は解説してあるけど、素性の使い方とか詳しくないからだめだ.

## 結論

```
{SVM, kNN} > LLSF > NNet >> NB
```

Figure-4, 5 は、トピックごとの micro,macro-F1 を、
トピックの頻度で並べて線でつないだもの
(何かの収束する様子かと思ってしまった)

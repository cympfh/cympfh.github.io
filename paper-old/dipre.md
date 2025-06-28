% Dual Iterative Pattern Relation Extraction (DIPRE)
% http://ilpubs.stanford.edu:8090/421/1/1999-65.pdf
% 自然言語処理 テキストマイニング パターン

HTMLテキストから、ある関係 R にあるような
二つの名詞からなるタプルを回収する。

彼らのシナリオでは、
`(本のタイトル, 著者)`
を回収する。

このタプルのことを R と言ってる?

## method

1. 小さなサンプルから関係 R' を抽出 (手でタプルを探す?) `R' = Sample`
2. コーパス D から、関係 R' に共起する単語 O `O = FindOccurrences R', D`
3. Oからパターンを作ってPとする `P = GenPatterns O`
4. Oにマッチする関係を改めて R' とする `R' = M_D P`
5. 2に戻っても良い `goto 2`

## pattern

pattern とは、
`(author, title, order :: Bool, url, prefix, middle, suffix)`
のこと.
order以外は 全部 `String` 型。
prefix, suffix は長さ`m` (以下?) とする。

つまり、tokenizeはしない。
対象がHTMLなので、これは妥当だ。

### 意味

url は文書のURLを表す(つまり文書ID)けど、
ちょっと謎なことを後でする。

`order == True`
のとき、
文中に、`author, title` が順に現れ、
`author` の直前の `m`文字が `prefix`
で、間が `middle` で、
`title` の直後の `m`文字が `suffix`
である。

`order == False`
なら、`title, author` の順で現れること。
ほかは同じ。

### generate a pattern

ある
`order`, `title`, `author`
に対して、
共通の `middle` を持つ文を見つけたら、

それぞれの、prefixの最長suffixを `prefix'`,
それぞれの、suffixの最長prefixを `suffix'`,
それぞれの、urlの最長prefixを `urlprefix`
とする。

```haskell
outpattern = (title, author, order, urlprefix, prefix', middle, suffix')
specificity = (length middle) * (length urlprefix) * (length prefix') * (length suffix')
```

specificity が適当な閾値より小さかったら捨てる

### example

```haskell
"www.sff.net/locus/c.*"
("<LI><B>", Title, "</B> by ", Author, " (")
```

## 実験

### datum

- 24 million web pages
- start with 5 tuples (author, title)

### first iteration

- 105 patterns
- 9369 unique (author, title)

### final iteration

- 346 patterns
- 15257 unique (author, title)

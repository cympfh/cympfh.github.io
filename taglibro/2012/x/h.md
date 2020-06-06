# X h day 2012

[g.html](2012/x/g.md) の javascript バージョン。

javascriptにおけるstring to int は、Numberコンストラクタ(?関数?)か
弱い型付けであること、暗黙の型キャストが頻繁に行われることを
利用して+単項演算子を付けるのがよくあると思う。最悪evalもある。

10万回 "123" をintに変換したものを要素とする配列の作成。
普通なら、私はこうする。

```javascript
a = "123";

ret = [];
for (i=0;i<=100000;++i) ret[i] = +a;
/*
$ time node test.js

real	0m0.133s
user	0m0.084s
sys	0m0.016s
*/
```

おお、Haskellより早い。意外。
何かで読んだけど、実際こういう型キャストは処理系の中で
アセンブリで書かれて最適化されているらしい。

次に自前のパースを用意したバージョン

```javascript
a = "123";

ret = [];
read_int = function(str) {
    var x = 0;
    for (var i=0,l=str.length;i<l;) x = x*10 + str.charCodeAt(i++) - 48;
    return x;
}
for (i=0;i<=100000;++i) ret[i] = read_int(a);
/*
$ time node test.js

real	0m0.127s
user	0m0.080s
sys	0m0.016s
*/
```

わずかに速くなった。
まあ、このくらいなら型キャストさせるね。

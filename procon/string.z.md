# 文字列 - 検索 - Z アルゴリズム

## 概要

与えられた文字列 $S$ について,
$$Z_i = \mathrm{len}(\mathrm{longest\_common\_prefix}(S, S[i:]))$$
なる配列 $Z$ を線形時間で求めるアルゴリズム.
ここで $S[i:]$ とは $i$ 文字目以降を切り出した部分文字列で,
$Z_i$ とは $S$ と $S[i:]$ との最長共通接頭辞の長さのこと.
特に $i=0$ のときは $S[0:]=S$ で $Z_0 = \mathrm{len}(S)$.

```
              a  b  c  a  a  b  c
Z(abcaabc) = [7, 0, 0, 1, 3, 0, 0]
```

## Z アルゴリズムによる文字列検索

文字列 $S$ 中に $T$ が部分文字列として出現するかの検索が Z アルゴリズムによって行える.
すなわち,
$T$ と $S$ 及び特別な文字 `@` （仮にこれは $S$ にも $T$ にも出現しない文字だとする）を結合した
$T@S$
という文字列を Z アルゴリズムに渡して配列 $Z$ を構成し,
その $S$ に当たる後半に $\mathrm{len}(T)$ が登場する場所を見ればよい.

@[rust](procon-rs/src/string/z.rs)

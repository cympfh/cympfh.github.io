# collections - 多重集合 (MultiSet)

## 概要

値の重複を許すような集合を定義する.
Map や辞書のようなデータ構造で, 値をキー, 個数を値とすることで表現できる.

キーが存在しないまたは値が $0$ の場合にその値を含まないことを言う.
実装上では値が $0$ になった時点でキーも削除しているのでキーを走査することで含む値が走査できる.

`BTreeSet` 及び `HashMap` による実装をそれぞれ載せる.
`BTreeSet` の場合には含む値の最小値/最大値の取得といった `BTreeSet` 自体で出来ることがもちろんそのまま出来る.

## 実装

@[rust](procon-rs/src/collections/btreemultiset.rs)

@[rust](procon-rs/src/collections/multiset.rs)

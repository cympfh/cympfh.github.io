# collections - 多重集合 (MultiSet)

## 概要

重複を許すような集合を定義する.
実装は要素の個数を `HashMap` で管理している.
個数が `0` になったらキーを削除している.

## 実装

@[rust](procon-rs/src/collections/multiset.rs)


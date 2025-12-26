# 時間/時刻 - 暦 - うるう年判定

## 参考

- [コンピュータシステムと閏年](https://ja.wikipedia.org/wiki/%E9%96%8F%E5%B9%B4#%E3%82%B3%E3%83%B3%E3%83%94%E3%83%A5%E3%83%BC%E3%82%BF%E3%82%B7%E3%82%B9%E3%83%86%E3%83%A0%E3%81%A8%E9%96%8F%E5%B9%B4)

## 概要

グレゴリオ暦で $Y$ 年がうるう年であることは次と同値

$$\left( (Y \bmod 4 = 0) \land (Y \bmod 100 \neq 0) \right) \lor (Y \bmod 400 = 0)$$

## 実装

@[rust](procon-rs/src/datetime/leap.rs)

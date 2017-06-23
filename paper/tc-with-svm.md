% Text Categorization with Suport Vector Machines: Learning with Many Relevant Features
% http://dl.acm.org/citation.cfm?id=649721
% 自然言語処理 テキスト分類

## 概要

SVM でテキスト分類します

1. 語の出現回数を数える
    - 3未満のものは消す
    - stop-words は消す
2. この時点で、10,000次元かそれ以上になる
    - これは過学習の原因でもあるから、[11]的手法に拠って、
    - 情報量基準で、素性のいくつかを捨てる
3. `idf`を用いてスケーリングし直す。今回は `tfc` なる量を使う (意味不明)
4. 文ごとの長さの違いを無くす (abstract) ために、素性ベクトルを正規化する

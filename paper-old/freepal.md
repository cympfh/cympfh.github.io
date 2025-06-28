% Freepal: A Large Collection of Deep Lexico-Syntactic Patterns for Relation Extraction
% http://www.lrec-conf.org/proceedings/lrec2014/pdf/764_Paper.pdf
% テキストマイニング 自然言語処理

## 目的

コーパス中の一文に現れた二つの名詞の関係を抽出する。

## 手法

現れた二つの名詞 A, B について、

- freebase によって、entity linking する. (id_A, id_B) (いつ使うかわからん)
- freebase によって、AとBの関係 R を取ってくる
- dependency tree で、AとBの最短路を取る (列にする)
- 最短路に現れるA, B を [X], [Y] で置き換えてパターンとする

## 例

- パターン: PLAY [X] IN MOVIE [Y]
- 関係: StarringInFilm
- confidence: 0.431

## 実装

http://free-pal.appspot.com/#show
で公開されてる。

- Free Text Search
- Search by Relation

の二つがある。
前者は、なんかサーバーのエラーで動かなかった。
後者は、freebaseにある関係から、
その関係はどんなパターンで抽出できるかを列挙してくれる。

例えば、
`education.field_of_study.students_majoring..education.education.specialization`
は、

- receive in [X] with emphasis in [Y]
- receive in [X] with specialization in [Y]

とかパターンが19個出てきて、
各々に、
Counts, Entropy, Confidence が情報として付いてる。

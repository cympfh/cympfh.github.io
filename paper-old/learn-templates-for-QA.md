% Learning Surface Text Patterns for a Question Answering System (Ravichandran+, 2002)
% http://www.aclweb.org/anthology/P02-1006
% 自然言語処理 テキストマイニング

関係抽出の為のパターンを生成する.

例えば、

- "Mozart was born in 1756."
- "Gandhi (1869–1948)…"

といった文に対して、もし次のようなテンプレート

- "\<NAME\> was born in \<BIRTHDATE\>"
- "\<NAME\> (\<BIRTHDATE\>–"

があれば、
"誰々はいつ生まれましたか？" という質問についての答えが自動的に抽出できる.

というわけで、そのようなテンプレートの自動生成を目標にして、
教師あり学習をする.

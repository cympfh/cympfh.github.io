% Automatic Extraction of Briefing Templates
% 
% 自然言語処理 自然言語生成 自動要約

_"automatic briefing generation from non-textual event"_

元がテキストでないようなイベントを自動要約したい。
従ってテキストの元と成るテンプレートが必要である。

例えば、天気、風、という情報を知らせるためのテンプレート:

- [A warm front] from [Iceland] to [the Faeroes] will move [ENE] across [the Norwegian Sea] [this evening]
- [A ridge] from [the British Isles] to [Iceland] will move [NE] across [the North Sea] [today]

the domain of the weather forecast のニュース記事からこのようなテンプレートを作りたい


1. クラスタリングをして
1. 構文木 (主語が根) を作って、適当に枝刈り
1. 評価
    - 良さ気なテンプレートを選んで
    - その数を精度とする
    - ROUGE

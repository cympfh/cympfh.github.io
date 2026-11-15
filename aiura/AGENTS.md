# aiura

数学・計算機科学の勉強ノート。公開先は https://cympfh.cc/aiura/ 。親リポジトリ `cympfh.github.io` のサブディレクトリ。作業範囲は `aiura/`。親の `Makefile` や他セクション（`taglibro/`、`memo/`、`paper/`）は触らない。

## コマンド

作業ディレクトリは `aiura/`。

```bash
make <id>.html    # 1本。本文を直したあとはこれ
make posts        # *.md を全部 HTML 化
make index        # index.html と resources/{postlist,taglist,table}
make dev          # weasel で *.md を監視し make posts
make new          # peco で *new。対話式。エージェントは使わない
just dev          # make dev と同じ
```

ビルド依存は `unidoc`（`~/.cargo/bin/unidoc`）。`make dev` は `weasel`、`make new` / `make edit` は `peco` と `$EDITOR`。

プレビューは親ディレクトリで `python -m http.server` し、`/aiura/index.html` と `/aiura/<id>.html` を開く。

`make git` は `git add ./` と `git commit` までやる。エージェントは実行しない。push もしない。

## 記事

1本が `<id>.md` と `<id>.html`。`<id>` はファイル名（拡張子なし）。URL は `https://cympfh.cc/aiura/<id>.html`。

先頭はこの4行。空行を挟まない。

```markdown
% タイトル
% YYYY-MM-DD (Mon.)
% タグ1 タグ2
% 一行の概要（任意。無くてもよい）
```

- 1行目がタイトル。`unidoc` は最初の `% ` 行をページタイトルにする
- 2行目が日付。`script/post.awk` は2行目だけを日付表示に変える。曜日は `LC_ALL=C date "+%Y-%m-%d (%a.)"` の形（`Sun.` のように3文字 + ピリオド）
- 3行目がタグ。空白区切り。`post.awk` は3行目だけをタグリンクに変える。タグは2行目に書かない
- 4行目も `% ` で始めると本文に残る。概要が要る記事だけ書く（例: `kernel.md`）
- 見出しは `##` から。`index.sh` のカード要約は `^## ` の行だけ拾う
- 本文末尾は改行で終わる。`unidoc` は末尾改行が無いとパースできない
- 記事間リンクは `<id>.html`。`.md` へはリンクしない
- 数式は `$...$` と `$$...$$`。`$$` は行全体。マクロは本文先頭の `$$ ... $$` に置く
- コードフェンスの言語名に `@` を付けない。`@bash` `@dot` `@gnuplot` はビルド時に実行される

`post.awk` は行番号で見ている。先頭3行の順序を変えると、日付とタグの HTML が入れ替わる。

## 索引

`resources/postlist` が掲載順。`index.sh` は末尾を新しい側として一覧する。新規 `<id>` は末尾に1行足す。

`index.sh` は直下の `*.md` のうち `postlist` に無いものを検出して末尾へ足す。`AGENTS.md` は除外する。`make posts` と `make AGENTS.html` も `AGENTS.html` を作らない。サブディレクトリの `.md` は対象外。

`resources/taglist` と `resources/table` は `make index` の生成物。手で編集しない。

`index.html` も生成物。直したときは `make index` で作り直す。タグ絞り込みは CSS の `:target`。タグ名がそのまま `id` になる。

## サブディレクトリ

`cube-nxnxn/` の図は `iso-cubeviz`。`*.cube` から `*.svg`。記事 `cube-nxnxn.md` から相対パスで参照する。

`script/` と `templates/` はビルド基盤。記事の依頼で変えない。

## やってはいけないこと

- `*.html` を手編集しない。直すのは `*.md` で、その後 `make <id>.html`
- 既存記事の `<id>` を変えない。変えると公開 URL が切れる
- 本文の事実、数式、定義、証明を、頼まれていない範囲で書き換えない。誤記の修正は、直す箇所を名指しされたときだけ
- `make git` を走らせない。コミットメッセージに日時以外の説明が乗らない
- 親リポジトリの `Makefile`、`sitemap.xml`、他セクションを、aiura の記事作業で更新しない

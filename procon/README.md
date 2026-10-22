# procon/

Rust の競技プログラミング用ライブラリ集のドキュメントです.
<https://cympfh.cc/procon/> で公開しています.

## 構成

- `src/*.md`: 各ページの原稿. コードは `@[rust](procon-rs/src/...)` の形で submodule から埋め込む
- `book.toml`: サイトの設定とページ一覧 (目次). ページを足したらここに追記する
- `procon-rs/`, `procon-cc/`: ライブラリ本体 (git submodule)
- `*.html`, `search-index.json`: [unibook](https://github.com/cympfh/unibook) が生成する公開用ファイル

## ビルド

```bash
make update-rs  # procon-rs を最新にする
make build      # unibook build
make serve      # ローカルで確認
```

% vim
% linux

## ビルド

### ソースコード

github から適当に新しいのを手に入れる

- [/github.com/vim/vim/releases](https://github.com/vim/vim/releases)

### ビルドコマンド

追加のプラグインを指定しない場合は次のように

```bash
sudo apt install libncursesw5-dev
./configure
make
```

ただし, 最近の vim プラグインの多くは python3 の埋め込み機能を利用して出来ており,
これらを使うには vim に python3 をリンクさせておく必要がある.
そのためには configure にオプションを与える.

```bash
./configure --enable-python3interp=yes
make
```

これで上手くいけばいいが,
リンクがうまく行かずに起動したら SEGV で落ちたり,
Import Error を吐いてプラグインが使えなかったりなどの問題がある.
考えられる原因は色々あって,

- バージョンが合わない不運
    - vim と python のバージョンの組み合わせを試す
- リンクのさせかたが駄目
    - `yes` の代わりに `dynamic` にしてダイナミックリンクにするとか
- そもそも Python の shared object が無い
    - python ビルドからやり直し

次の章で解決するかもしれない.

## Vim+Python3 のビルド

### 諸注意

おすすめのバージョンの組み合わせやフルのビルドコマンドは後述する.
予め注意すべき点をここで述べる.

- Python3
    - `--enable-shared` によって `.so` ファイルを出力させる設定を有効にしておく
    - pyenv 等は使わずにシステムの Python を置き換えてしまうのが無難
        - 必要であれば, 普段使いは pyenv で Vim 用はシステムの Python を使う, といった工夫をする
        - Vim 用に Python モジュールを後から pip インストールする場合にはシステムに入れるように注意
    - いくつかのモジュールはコンパイルに失敗しても, さらっと警告して見逃しがち
        - `Failed to build these modules: ...` といったメッセージを見逃さないこと
        - 特に `_ctypes` が失敗してたら `libffi-dev` 相当を `apt install` なりしてから再度ビルドする
- Vim
    - ビルドしたあとは, 必ず動作確認をしてから `make install` を叩くこと
        - `./src/vim` にバイナリファイルがあるのでこれを直接動かしてみる
        - `./src/vim --version` の中に `+python3` があることをチェックする

### おすすめセット (2021/07/15 動作版)

#### [Python 3.9.6](https://www.python.org/downloads/release/python-396/)

```bash
sudo apt install libffi-dev
./configure --enable-optimizations --enable-shared
make
sudo make install
```

#### [vim 8.2.3161](https://github.com/vim/vim/releases/tag/v8.2.3161)

```bash
./configure --enable-python3interp=yes --with-python3-command=python3.9
make
sudo make install
```

### おすすめセット (2020/11/26 動作版)

#### [Python3.8.5](https://www.python.org/downloads/release/python-385/)

```bash
sudo apt install libffi-dev
./configure --enable-optimizations --enable-shared
make
sudo make install
```

#### [vim 8.2.1484](https://github.com/vim/vim/releases/tag/v8.2.1484)

```bash
./configure --enable-python3interp=yes --with-python3-command=python3.8
make
sudo make install
```


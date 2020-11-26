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

これが大変で, リンクがうまく行かずに起動したら SEGV で落ちたり,
Import Error を吐いてプラグインが使えなかったりなどの問題がある.
考えられる原因は色々あって,

- バージョンが合わない不運
    - vim と python のバージョンの組み合わせを試す
- リンクのさせかたが駄目
    - `yes` の代わりに `dynamic` にしてダイナミックリンクにするとか
- そもそも Python の shared object が無い
    - python ビルドからやり直し

### おすすめセット (2020/11/26 動作版)

#### [Python3.8.5](https://www.python.org/downloads/release/python-385/)

pyenv は使わないのが本当に無難.
ソースコードから直接システムに置いておく.
普段遣いしたい Python が別途あるなら, これは Vim 専用と割り切ってもいいくらい.
ただし Vim 用に `pip install` したいときは, もちろんこの pip を使わないと行けないのだけ注意.

```bash
sudo apt install libffi-dev
./configure --enable-optimizations --enable-shared
make
sudo make install
```

make の後,
ビルドに失敗したモジュールがあると,

```
Failed to build these modules:
_ctypes
```

みたいなのがさらっと出るので注意.
特に `_ctypes` が失敗してたら `libffi-dev` 或いはそれ相当のものを入れてから再度ビルドする.

#### [vim 8.2.1484](https://github.com/vim/vim/releases/tag/v8.2.1484)

```bash
./configure --enable-python3interp=yes --with-python3-command=python3.8
make
sudo make install
```

最後のインストールをしてしまう前に動作確認をしておくとよい.
`./src/vim` に実行可能バイナリがあるので,
これを `--version` で実行して `+python3` とあるのを確認したり,
確かに起動できることを見たりするとよい.


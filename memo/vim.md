% vim
% linux

## Build

### default build

特に追加のプラグインを指定しないデフォルトのビルド.

```bash
sudo apt install libncursesw5-dev

./configure

make
```

### huge Build

プラグインてんこもりバージョン

```bash
sudo apt-get install libncurses5-dev libgnome2-dev libgnomeui-dev libgtk2.0-dev libatk1.0-dev libbonoboui2-dev libcairo2-dev libx11-dev libxpm-dev libxt-dev

./configure --with-features=huge --enable-rubyinterp=yes --enable-pythoninterp=yes --with-python-config-dir=/usr/lib/python2.7/config-x86_64-linux-gnu_d --enable-python3interp=yes --with-python3-config-dir=/usr/lib/python3.4/config-3.4m-x86_64-linux-gnu --enable-luainterp=yes --with-luajit --enable-fontset --enable-fail-if-missing

make
```

デフォルトだと, オプションで指定してても必要なパッケージが見つからなかったら勝手に無視して進めてしまう.
`--enable-fail-if-missing` はそのような場合に失敗して落ちるようにする.
しかしながら、`huge` の中については、依存が足りないものは無視してすすめる.


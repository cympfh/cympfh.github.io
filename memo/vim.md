
# build

```bash
./configure --with-features=huge --enable-rubyinterp=yes --enable-pythoninterp=yes --with-python-config-dir=/usr/lib/python2.7/config-x86_64-linux-gnu_d --enable-python3interp=yes --with-python3-config-dir=/usr/lib/python3.4/config-3.4m-x86_64-linux-gnu --enable-luainterp=yes --with-luajit --enable-fontset --enable-fail-if-missing
```

必要な依存が無いものは勝手に無視される.
`--enable-fail-if-missing` で自分で付け加えたオプションは無視せずエラーにさせられる.
しかしながら、`huge` の中については、依存が足りないものは無視してすすめる.

## 参考: huge を全て有効にする

```bash
sudo apt-get install libncurses5-dev libgnome2-dev libgnomeui-dev libgtk2.0-dev libatk1.0-dev libbonoboui2-dev libcairo2-dev libx11-dev libxpm-dev libxt-dev
./configure --with-features=huge
make
```



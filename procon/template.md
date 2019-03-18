% プロコン用 C++ テンプレート

[cympfh/language-template/archive/master.zip](https://github.com/cympfh/language-template/archive/master.zip)
をどっかに置いて、内の `template` にだけパスを通す.

例えば

```bash
[ -d ~/bin ] || mkdir ~/bin
export PATH=$PATH:~/bin
cd ~/bin
wget https://github.com/cympfh/language-template/archive/master.zip
unzip master.zip && rm master.zip
mv language-template-master template
ln -s ~/bin/template/template ~/bin/
```

## 標準テンプレート

```bash
template cpp > main.cc
```

## 幾何テンプレート

標準テンプレートにいくつか載せたもの

```bash
template cpp -g > main.cc
```

## 極小テンプレート

長ったらしいテンプレートは格好が悪いと思った時のテンプレート

```bash
template cpp -m > main.cc
```


## clang なとき

Mac を使ってたりして clang を使うときは、
テンプレートでインポートしてある `<bits/stdc++.h>` が無い.
そういうときは、以上のコマンドに `--clang` オプションを附けることで、
必要そうなヘッダ (思いつくもの全て) に置き換える.

### 例

```bash
template cpp -g --clang > main.cc
```


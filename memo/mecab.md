% MeCab using UTF-8
% 自然言語処理

## インストール

### ダウンロード

必要なファイルは MeCab 本体と、そのための辞書  
辞書には複数種類があるが、IPA辞書が推奨とされている

いつのまにか Google Code から Github にプロジェクトが移ってて、

- https://github.com/taku910/mecab.git

に、mecab本体も辞書も入ってる.

以下、LinuxまたはMacOSで文字コードをUTF-8に縛って利用するためのビルド方法を書く

### cd mecab-0.996

MeCab本体のインストールを行う

```bash
./configure --with-charset=utf8 --enable-utf8-only
sudo make install
```

辞書がない状態でmecabを起動するとこうなる

```bash
   mecab
param.cpp(69) [ifs] no such file or directory: /usr/local/lib/mecab/dic/ipadic/dicrc
```

### cd mecab-ipadic-2.7.0-20070801

次にMeCabで利用するための辞書をインストールする

```bash
./configure --with-charset=utf8
sudo ldconfig
sudo make install
```

### 試用

正しくインストールされたか見てみる

```bash
   mecab <<< "こんにちわ"
こんにちわ      感動詞,*,*,*,*,*,こんにちわ,コンニチワ,コンニチワ
EOS
```

「こんにちわ」は感動詞である。

### 追加の辞書: [ipadic-neologd](https://github.com/neologd/mecab-ipadic-neologd)

ipadic辞書utf-8版が入っているとき、この辞書を追加で入れても良い.
この辞書は新語が週2ペースで追加されているらしい.
その代わり辞書のサイズが膨大.
[README.ja](https://github.com/neologd/mecab-ipadic-neologd/blob/master/README.ja.md)
の通りにやればインストールできる.

また、この辞書を使って mecab を動かすには
`mecab -d /usr/local/lib/mecab/dic/mecab-ipadic-neologd`
という風に `-d` オプションが必要.

意外な語が固有名詞として登録されていたりするので注意が必要.

## オプション

`man` 見ても何かあんまり説明が足りてない  
次のサイトは大変詳細に書いてある  

- [MeCabのコマンドライン引数一覧とその実行例 | mwSoft](http://www.mwsoft.jp/programming/munou/mecab_command.html)

### 制約付き解析 (部分解析) `-p`

辞書に無いが品詞が既知な語や、
その箇所のそこだけこの品詞にしたい。

```
mecab <<< '彼女はせもぽぬめと呼ばれている'
彼女    名詞,代名詞,一般,*,*,*,彼女,カノジョ,カノジョ
は      助詞,係助詞,*,*,*,*,は,ハ,ワ
せ      動詞,自立,*,*,サ変・スル,未然ヌ接続,する,セ,セ
も      助詞,係助詞,*,*,*,*,も,モ,モ
ぽ      形容詞,接尾,*,*,形容詞・アウオ段,ガル接続,ぽい,ポ,ポ
ぬ      助動詞,*,*,*,特殊・ヌ,基本形,ぬ,ヌ,ヌ
め      名詞,一般,*,*,*,*,め,メ,メ
と      助詞,格助詞,引用,*,*,*,と,ト,ト
呼ば    動詞,自立,*,*,五段・バ行,未然形,呼ぶ,ヨバ,ヨバ
れ      動詞,接尾,*,*,一段,連用形,れる,レ,レ
て      助詞,接続助詞,*,*,*,*,て,テ,テ
いる    動詞,非自立,*,*,一段,基本形,いる,イル,イル
EOS
```

入力を
`s/せもぽぬめ/\nせもぽぬめ\t名詞\n/g`
と置換する

```
mecab -p <<< '彼女は
せもぽぬめ      名詞
と呼ばれている
EOS'
彼女    名詞,代名詞,一般,*,*,*,彼女,カノジョ,カノジョ
は      助詞,係助詞,*,*,*,*,は,ハ,ワ
せもぽぬめ      名詞,一般,*,*,*,*,*
と      助詞,格助詞,引用,*,*,*,と,ト,ト
呼ば    動詞,自立,*,*,五段・バ行,未然形,呼ぶ,ヨバ,ヨバ
れ      動詞,接尾,*,*,一段,連用形,れる,レ,レ
て      助詞,接続助詞,*,*,*,*,て,テ,テ
いる    動詞,非自立,*,*,一段,基本形,いる,イル,イル
EOS
```

ただし、「せもぽぬめ」が複数出現する場合  
そのたびに上のような置換を行わなければならない

小さい辞書をテキストで書いて追加に使うにはどうしたら良いんだろう？

## Python3 バインディング

```bash
pip install mecab-python3
mecab-config --libs-only-L | sudo tee /etc/ld.so.conf.d/mecab.conf && sudo ldconfig  # https://qiita.com/sogawa@github/items/fd9bdaf8df27335f9a65
```

### 試用

わかち書きをさせてみる.

```python
import MeCab
mecab = MeCab.Tagger('-Owakati -d /usr/local/lib/mecab/dic/mecab-ipadic-neologd')
mecab.parse('今日はいい天気ですね').split()  # => ['今日', 'は', 'いい', '天気', 'です', 'ね']
```

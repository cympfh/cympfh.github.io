% GNU screen
% linux terminal

ターミナルの様子をスクリーンショットやスニペットで貼りますが、
"&nbsp;&nbsp;&nbsp;" (空白3つ) が私のプロンプトです.

## 日本語文字化け

たぶん `LC_ALL` が正しく設定されてない.

例えば素の状態だと `LC_ALL` が空の場合がある.

```bash
   LC_ALL=
   screen
```

この状態で `echo あ` を試みる. コマンド入力の時点で文字化けしている.

![](https://i.imgur.com/kOJNNb5.png)

`LC_ALL` を日本語+UTF-8 にする.
何故か `LANG` は正しく設定されていたのでそれを使う.

```bash
   echo $LANG
ja_JP.UTF-8
   LC_ALL=$LANG
   echo $LC_ALL
ja_JP.UTF-8
   screen
```

治りました.

![](https://i.imgur.com/HKr3flc.png)

`LC_ALL` を設定しなくても、screen を utf-8 モードで起動しても文字化けを防げる.

```bash
   LC_ALL=
   screen -U
```

これでも問題ない. 既に起動してしまった screen セッションにも `-U` 付きでアタッチすれば utf-8 モードで入れる.

% WSL
% Windows linux

## 環境

以下を前提にしています.

- Windows10
- WSL（WSL2 ではない）
- Ubuntu 18.04, 20.04

## Base Setup

- [お前らのWSLはそれじゃダメだ](https://xztaityozx.hatenablog.com/entry/2017/12/01/001544)

タイトルはともかく基本の設定はこれだけ見ておけばいい.
内容は Xサーバ (VcXsrv) を入れてやっていこうという話.

## IME

- [WSLでMozcで日本語入力](https://qiita.com/maromaro3721/items/be8ce6e3cec4cbcdac00)

fcitx-mozc のセットアップ

## クリップボード

選択肢としては２つある.

1. X Window System を使う
    - Windows 側に X Window Server が必要
        - VcXsrv などを使う
    - WSL からは xsel または xclip コマンドを使う
2. Windows に入ってるクリップボード操作を使う

前者は書いてある通りなので後者について述べる

Windows にはクリップボードを操作するためのコマンドとして `clip.exe` がある.
これはコピーする（クリップボードにテキストを上書きする）ことだけができる.
ペーストする（取り出す）専用のコマンドはたぶんないが, `PowerShell` のコマンド `Get-Clipboard` があるのでこれを使うと良い.

注意点が3つあり,

1. 文字コードは `Shift JIS` にした方がよい
2. 改行コードは CRLF (`\r\n`) にした方がよい
3. `clip.exe` は末尾に無駄な空行を一つ差し込んでコピーする

最初の2つの注意点を無視しても上手く動いてるように見えることもあるが, 動かない場合がある.
この2つは `nkf` コマンドを持っていけば容易に達成できる.

3つ目はペーストするタイミングで良ければ, sed で消すなどすれば良いが,
シェル以外のところでペーストすると無駄な空行が残るし,
最後に空行が残ってるのが正しい場合でも消すので, 正しい対処とは言えない.

```bash
# コピーする
echo ほげほげ | nkf -sc | clip.exe
cat input.txt | nkf -sc | clip.exe

# ペーストする
powershell.exe /c "Get-Clipboard" | nkf -d | sed '${/^$/d}'
```

これらを適当にエイリアスにしておけばよい.

シェルスクリプトから標準入力があるかどうかをチェックすることで挙動を変えることは可能なので,
コピーもペーストも同じコマンドとして登録することは可能（実際 `xsel` などはそうだし）.
私は [clip コマンド](https://github.com/cympfh/bin/blob/master/clip) として使えるように置いてある.

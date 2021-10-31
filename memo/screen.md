% GNU screen
% linux terminal ssh

ターミナルの様子をスクリーンショットやスニペットで貼りますが、
"&nbsp;&nbsp;&nbsp;" (空白3つ) が私のプロンプトです.

## index

<div id='toc'></div>

## 日本語の文字化け

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

## ssh パスフレーズの省略 (ssh-agent)

(screen とは直接関係なく) `ssh-agent` コマンドを用いると, パスフレーズを一回入力することで,
次回から入力が省略できる.
まず, そのよくある使い方を2通り示す.
そして screen でこれをより便利に使うための手法を1つ提案する.

### ssh-agent

一つのターミナルの中で

```bash
   eval $(ssh-agent)
   ssh-add ~/.ssh/id_rsa
```

とすればパスフレーズの入力が促され, `~/.ssh/id_rsa` をそのターミナルの中で使う場合にはパスフレーズの入力が省略される.
ただし新しく開いたターミナルでは有効ではない.

### ssh-agent terminal

`ssh-agent` に引数を渡して起動すると, 引数をコマンドとして実行する.

```bash
   ssh-agent screen
```

とすれば, `screen` が立ち上がる.
この screen の中では ssh-agent が有効になっており,
どれかのウィンドウの中で `ssh-add` すれば, その screen の中ではずっと有効である.

ただし, 別の新しく立ち上げた screen では無効だし, また一度デタッチしてまたアタッチし直した以降も無効である.
この問題は以下で解決される.

### 提案: SSH_AUTH_SOCK を使い回す

そもそも ssh-agent が有効な範囲がある理由をを知るには `ssh-agent` が何をやっているかを知る必要がある.

```bash
   ssh-agent
SSH_AUTH_SOCK=/var/folders/kp/xctwhj0d7p1_pfrdcx03l46w_vnlbk/T//ssh-LAbAHJgJ4olH/agent.34946; export SSH_AUTH_SOCK;
SSH_AGENT_PID=34947; export SSH_AGENT_PID;
echo Agent pid 34947;
```

要は `$SSH_AUTH_SOCK` と `$SSH_AGENT_PID` という2つの環境変数をセットしてるだけらしい.
ならば新しいターミナルでもいちいちこの2つの変数をセットすれば良い.
ただし `ssh-agent` を改めて叩くと新しい値が発行されるだけなので, 前に発行した値をどこかに保存して, それを読み込めばよい.
ちなみにどうも `$SSH_AUTH_SOCK` だけで十分でもう一方は無くても問題ないらしい.

例えば以下を `~/.bashrc` (or `~/.zshrc`) に書いておくとする.

```bash
if [ -f ~/.ssh/auth.sock ]; then
    SSH_AUTH_SOCK=$(cat ~/.ssh/auth.sock)
else
  eval $(ssh-agent)
  ssh-add ~/.ssh/id_rsa
  echo $SSH_AUTH_SOCK > ~/.ssh/auth.sock
fi
```

これは初回時には強制的に `ssh-agent` を呼んで, 発行された `$SSH_AUTH_SOCK` を適当に保存しておく.
保存されたファイルがある場合にはそれを読んでセットする.

私は else 節を関数に書き出して,
調子が悪くなったら `fuck-ssh` コマンドを叩くようにしている.

```bash
if [ -f ~/.ssh/auth.sock ]; then
    SSH_AUTH_SOCK=$(cat ~/.ssh/auth.sock)
else
    echo NO SSH_AUTH_SOCK FOUND
fi
function fuck-ssh() {
  eval $(ssh-agent)
  ssh-add ~/.ssh/id_rsa
  echo $SSH_AUTH_SOCK > ~/.ssh/auth.sock
}
```

## 罫線が崩れる

![](https://i.imgur.com/jeD57jX.png)

これが参考になった: [■GNU Screen 4.2.0にしたら罫線表示がぶっ壊れた](https://anond.hatelabo.jp/20140512183601).
4.2.0 にしたらとあるが, 4.8.0 でもこの現象を確認した.
上のキャプチャ画像がそれ.
なる環境もあればならない環境もある.

次を `.screenrc` に追加する.

```bash
cjkwidth off
```

![](https://i.imgur.com/sA8JlRh.png)

治った.


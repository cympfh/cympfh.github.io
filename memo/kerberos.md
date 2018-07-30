% Kerberos 認証, HDFS
% linux kerberos hdfs

## Kerberos 認証とはなにか

古くからある認証方式らしい.
単にパスワードを毎回入力する方式と、パスワード情報をハッシュ化して保存したファイル (これをkeytabという) を参照することでパスワード入力をスキップする方式とがある.
自動化する場合などには後者が必須.

## keytab ファイルの作成

ktutil コマンドを使う. Linux のそれと Mac のそれとで全く使い方が違う.
Linux のそれは対話式プログラムになっている.

サーバのドメインはなぜか全部大文字で書く.

```bash
$ # Linux
$ ktutil
add_entry -password -p ${USER}@DOMAIN.CO.JP -k 1 -e aes256-cts
(パスワード入力)
write_kt output.keytab
quit
```

Mac だとそもそも対話式ではなくてワン・コマンド.

```bash
$ # Mac
ktutil -k output.keytab add -p $USER@DOMAIN.CO.JP -e aes256-cts-hmac-sha1-96 -V 1
```

## 環境変数

Kerberos クライアントは、ドキュメントに書いてなくても、次の環境変数を勝手に読んで使う.

- `KRB5_CLIENT_KTNAME`
    - 普通はこっちだけあればいい
- `KRB5_KTNAME`
    - これはいらないことが多い

ともに、参照させたい keytab ファイルのパスを入れておく.
クライアントはこれを読んで keytab ファイルを参照しようとする.

## HDFS

Hadoop に使われるファイルシステム.
Kerberos 認証がかかってることがよくあるので、このメモに一緒に書いておく.

HDFSをブラウザで見る以外のクライアントについてメモする.

### [HdfsCLI 2.1.0](https://hdfscli.readthedocs.io/en/latest/quickstart.html)

Python製クライアント.
Pythonプログラムの中からも使えるが、CLIも提供している.
バージョンによって動作の説明が激しく異なるようなので注意が必要.

```bash
$ pip install pykerberos==1.2.1 requests-kerberos==0.11.0 hdfs==2.1.0
$ cat <<EOM > ~/.hdfscli.cfg
[global]
autoload.modules = hdfs.ext.kerberos
default.alias = server

[server.alias]
url = http://domain.co.jp:80
client = KerberosClient

$ hdfscli  # ipython が立ち上がる
...
Welcome to the interactive HDFS python shell.
The HDFS client is available as `CLIENT`.

In [1]: CLIENT.list('/')  # 認証に失敗したらここでコケる
Out[1]: ['lib', 'system', 'tmp', 'user']

In [2]:
```

### curl (webhdfs)

[webhdfs REST API](https://hadoop.apache.org/docs/r1.0.4/webhdfs.html) という API が提供されている.
これを curl で直接叩けば、ファイル操作が一通りできる.
大抵は、サーバの url `domain.co.jp` に対して `/webhdfs/v1/` が API のエンドポイント.

```bash
$ kinit -kt $KRB5_CLIENT_KTNAME ${USER}@DOMAIN.CO.JP  # はじめの認証. 一定時間で切れる
$ curl --negotiate -u : 'http://domain.co.jp/webhdfs/v1/?op=LISTSTATUS'
{"FileStatuses":{"FileStatus":[{"pathSuffix":"lib","type":"DIRECTORY",...},{"pathSuffix":"system","type":"DIRECTORY",...},{"pathSuffix":"tmp","type":"DIRECTORY",...},{"pathSuffix":"user","type":"DIRECTORY",...}]}}
```

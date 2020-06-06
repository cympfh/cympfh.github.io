% Samba Server & Client in Ubuntu
% samba linux ubuntu

<div id=toc></div>

## Server on Ubuntu

以下のコマンドで鯖デーモン `smbd` が入る.
インストールした時点から勝手に動く.

```bash
sudo apt install samba
```

ubuntu のバージョンによるが、16くらいなら

```bash
sudo systemctl status smbd
sudo systemctl restart smbd
```

でデーモンを操作する.

### 設定ファイルについて

`smbd` は起動時に設定ファイル

```
/etc/samba/smb.conf
```

を読む.

この設定ファイルはおそらく気づいたら既にある.
注意点として、
`samba` のインストールの際に生成されるなどということは無いということ.
それどころか、この設定ファイルが存在しないと、起動に失敗する.
`apt install samba`
するとき、勝手に起動しようとするので、エラーを吐くことになる.

雛形として
`/usr/share/samba/smb.conf`
がある.

もし設定ファイルを誤って消したか、何故か無かったら、以下のようにただコピーしてくればよい:

```bash
sudo mkdir -p /etc/samba
sudo cp /usr/share/samba/smb.conf /etc/samba/
```

### ユーザーの追加

サーバに `cympfh` というユーザーが既にいて、クライアントからはこれで samba にアクセスするとする.
次のように追加する.

```bash
sudo pdbedit -a cympfh
```

確かパスワードもここで設定する.

### 共有ディレクトリの設定

断然おすすめは
`system-config-samba`
というGUIツールを使うこと.
こちらも `apt install` で入る.

```bash
sudo system-config-samba
```

で立ち上げて、共有するディレクトリと名前を与えるだけ.
どういう設定の書き換えをするかを見れば、実際単純なので、もう手で変更できるようになる.

*NOTE*: 初回はたぶん `/etc/libuser.conf` が無いというエラーが出る.
`sudo touch /etc/libuser.conf`
で空ファイルを一度作ってから起動するだけで問題ない.

*NOTE*: 手で設定ファイルをいじると警告が出る.
初めは雛形をコピーして `system-config-samba` で設定し、
一度直接手で変更するようになった以降はずっと `system-config-samba` を使うのをやめたらよいと思う.

#### 例

以下は私の実際の設定ファイル.
以下のような5行が `/etc/samba/smb.conf` の末尾に付け足された.
意味は次のようなものである.
`share` という名前の共有設定を新しく定義する.
サーバの `/media/cympfh/Volume` というディレクトリ下を共有する.
クライアントはこの下に書き込むことが出来る (`writeable`).
この設定をクライアントは見ることは出来ず `share` という名前を知っておく必要がある.
行頭の `;` を外せば `share` という設定があることが見える.
アクセスが許されているユーザーは `cympfh` ただ1人.
この `cympfh` はサーバに既にあるユーザーであり、先程 `pdbedit` で追加した.

```
[share]
	path = /media/cympfh/Volume
	writeable = yes
;	browseable = yes
	valid users = cympfh
```

### 他の設定項目

`[global]` の下に

```
   dos charset = CP932
   unix charset = UTF8
   display charset = UTF8

   mangled names = no

   vfs objects = catia
   catia:mappings = 0x3a:0x7e
```

*NOTE*: 上の3行は文字コードの設定.

*NOTE*: 4行目. 互換性のために長いファイル名を短縮する mangle というものがあるらしい.
それをさせない.

*NOTE*: 名前にコロン `:` を含むディレクトリ下、ファイルにアクセスできない問題がある.
下の二行はそれを解決する.
[https://evren-yurtesen.blogspot.jp/2017/04/how-to-access-files-with-colon-in.html](https://evren-yurtesen.blogspot.jp/2017/04/how-to-access-files-with-colon-in.html)

## Clients on Ubuntu

mount して使う.

```bash
sudo apt install cifs-utils
```

`mount.cifs` コマンド、または `mount -t cifs` または単に `mount` コマンドでマウントできる.
例えばサーバが `192.168.0.6` だとする.
ここに `cympfh` ユーザーで `share` という共有にアクセスするには

```bash
sudo mkdir /mnt/smb
sudo mount //192.168.0.6/share /mnt/smb -o user=cympfh
```

パスワードが求められるので入れる.
あるいは

```bash
sudo mount //192.168.0.6/share /mnt/smb -o user=cympfh,pass=YOURPASS
```

と直接入れることもできる.

アンマウントも普通に

```bash
sudo umount /mnt/smb
```

で良い.

## Clients on MacOS

`open smb://hogehogefugafuga` ってしたら開いた記憶がある.

## Clients on Android

"AndSMB (samba client)"
[https://play.google.com/store/apps/details?id=lysesoft.andsmb&hl=ja](https://play.google.com/store/apps/details?id=lysesoft.andsmb&hl=ja)
というアプリを使ってる.


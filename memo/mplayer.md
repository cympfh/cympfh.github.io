% mplayer
% linux

## index

<div id=toc></div>

## 再生

```bash
mplayer <file>
```

実行中に次のキーシグナルを送ることでいくつかの操作ができる.

  key              function
---------------    --------------------------------
 `<Space>`         再生/一時停止 (toggle)
 `q`               終了
 右クリック        再生/一時停止 (toggle)
 `s`               スクリーンショット (カレントディレクトリに適当にrenameしたpngが生成される)
 `<Right>`         数秒次に送る
 `<Left>`          数秒前に送る

状態として再生速度を浮動小数で持つ.
デフォルトで 1.0.

  key                 function
-------------------   --------------------------------
  `[`                 再生速度をいくらか下げる
  `]`                 再生速度をいくらか上げる
  `{`                 再生速度をかなり下げる
  `}`                 再生速度をかなり上げる
  `<BackSpace>`       再生速度を 1.0 にする

## オプション

```bash
mplayer [options] <file>
```

### speed

再生速度の指定

```bash
mplayer -speed 1.3
```

### audio filter

再生速度を変更するとデフォルトでは周波数もそのまま変わる.
たとえば再生速度を上げると高く聴こえる.
次のオプションは元の周波数をできるだけ保ってくれる.

```bash
mplayer -af scaletempo
```

あと今こんなのも見つけた.
音声が2chの場合、一般にボーカルの音声だけを取り除くことができて:

```bash
mplayer -af karaoke
```

精度は、
あまり実用的には思えないが.

## playlist

直接、複数のファイルを destination に指定すると、その順に再生する.

```bash
mplayer file1 file2 ...
```

或いは、テキストファイルに、音楽ファイルのパスを1行に1つ書いておくことで、
それを読みこませることもできる.

```bash
   cat pls.txt
file1
file2
   mplayer -playlist pls.txt
```

`<Enter>` または `>` で次の曲に、 `<` で前の曲に移動する.
次の曲がないと終了する.

## shuffle

```bash
mplayer --shuffle file1 file2
```

## loop

```bash
mplayer --loop 0 file1 file2
```

# CD-ROM

## 再生

`/dev/` 上にあるであろう、CDの仮想デバイスを特定する.
例えば `/dev/cdrw1` だとする.


```bash
   mplayer --cdrom-device /dev/cdrw1 cdda://
Found audio CD with 4 tracks.
```

複数トラックが入ってても一つのファイルのように扱われる.


上の例では、4 tracks 収録されており、
`track-number` として 1,2,3,4 が有効.
これを直接指定できる:

```bash
mplayer -cdrom-device /dev/cdrw1 cdda://[track-number] # 一つのトラック
mplayer -cdrom-device /dev/cdrw1 cdda://[track-number]-[track-number] # トラックの範囲
```

トラック間の移動は不明.
全体で1曲として扱われ、`<Enter>` など押すと即座に終了するから
(トラックってのはあくまでもシーク位置).

## CD からの取り込み

大抵の目的の場合 `Asunder` 等、専用のソフトウェアを用いるべきである.
音楽タグなどが付与されるから.

`mplayer` では、再生しながら、再生している音をファイルに書き出すことができる.
これを「取り込み (インポート)」と呼ぶことにする.
再生中に、再生速度を変更する、次の曲に移動する、など行えば、それがそのまま書き出される.

```bash
   mplayer -cdrom-device /dev/cdrw1 cdda://3 -ao pcm:file=track3.wav -vo null -vc null
   file track3.wav
track3.wav: RIFF (little-endian) data, WAVE audio, Microsoft PCM, 16 bit, stereo 44100 Hz
```

あとは、 `ffmpeg` なりで、wav形式から好きな形式に:

```bash
ffmpeg -i track3.wav track3.mp3
```

### N.B.

`-ao pcm:file=`  は別にCDからじゃなくても、
例えば、動画ファイルを指定することで、動画ファイルを再生しながら、音だけを書き出す、など応用できる.

# DVD

## 再生

DVD のデバイスを特定する.
例えば `/dev/dvdrw1`.

```bash
mplayer -speed 1.0 -dvd-device /dev/dvdrw1 dvd://<int>
```


`<int>` は CD でいうところの `<track-number>`
(`<chapter-number>` ?).

例えば:

```
mplayer -speed 1.0 -dvd-device /dev/dvdrw1 dvd://2
```

# camera

## 再生 (ライブ)

```bash
mplayer tv:// -tv device=/dev/video0
```


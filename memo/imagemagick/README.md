% imagemagick

## 参考

- \[1\] [須崎純一, "ImageMagickによる基本的な画像処理"](http://www.envinfo.uee.kyoto-u.ac.jp/user/susaki/image/magick_process.html)

## INDEX

<div id=toc></div>

## 余白を付け足す

```bash
convert -background "#ffffff" -gravity north -splice 0x10
convert -background "#ffffff" -gravity south -splice 0x10
convert -background "#ffffff" -gravity east -splice 10x0
convert -background "#ffffff" -gravity west -splice 10x0
```

二方向以上への余白を一度に付け足すことはサポートされてないので2回 `convert` する.

ファイル名 "-" がよろしく `stdin` または `stdout` になるのでパイプで繋げば良い:

```bash
cat hoge.jpg |
convert -background "#ffffff" -gravity west -splice 800x0 "-" "-" |
convert -background "#ffffff" -gravity north -splice 0x300 "-" out.jpg
```

## 写真からグレイスケール画像への復元

漫画のスキャン画像や写真は、本来はグレイスケール画像であるが、照明等の影響を受け見た目が異なる.
元のグレイスケールを復元する試み.

### 使うコマンド

- `-type GrayScale`
    - グレイスケールへ変換する
    - 近いものに `-monochrome` があるが、これは白黒への二値化
- `-contrast`
    - 白黒の強調
- `-modulate <int>`
    - 明るさを調整する
    - 引数には元の明るさを100として比率を与える

### 実例 1

オリジナル:

![](img/september.jpg)

```bash
convert -type GrayScale -contrast -contrast
```

![](img/september.grayscale.contrast.contrast.jpg)

```bash
convert -type GrayScale -contrast -contrast -contrast -contrast
```

![](img/september.grayscale.contrast.contrast.contrast.contrast.jpg)

オプションは先頭から順に実行される?

### 実例 2

オリジナル:

![](img/yume_org.png)

```bash
convert -modulate 200 -type GrayScale -contrast -contrast -contrast
```

![](img/yume_out.png)


% Pillow

私の場合、言語に Python を採用する上に画像の読み込みをするなんて機械学習をする場合しかないので、その文脈で.

## index

<div id=toc></div>

## 参考ページ

- [Pillow - Pillow (PIL Fork) 4.2.1 documentation](https://pillow.readthedocs.io/en/4.2.x/)
    - 公式ドキュメント
- [Python 3.5 対応画像処理ライブラリ Pillow (PIL) の使い方 - Librabuch](https://librabuch.jp/blog/2013/05/python_pillow_pil/)
    - 一般のブログ

## thumbnail: 縮小

リサイズするには `im.resize` があるが、縮小を目的とする場合、その綺麗さから
`Image.ANTIALIAS` で `im.thumbnail` するに限る.

```python
from PIL import Image
im = Image.open('path.jpg')
im.thumbnail((W, H), Image.ANTIALIAS)
```

## paste: 貼り付け

ある画像の上に別の画像を貼り付ける.
土台となる画像と上に載せる画像の2つを用意する.

```python
W = 60
H = 100
white = (255, 255, 255)
canvas = Image.new('RGBA', (W, H), white)

img = Image.open('icon.png')

left = 5
top = 30
canvas.paste(img, (left, top))

canvas.save('out.png')
```

上に載せる画像に透過ピクセルが使われている場合、予想に反した出来になるだろう.
この場合 `paste` の第三引数に `mask` を与える必要がある.

- [python - How to merge a transparent png image with another image using PIL - Stack Overflow](https://stackoverflow.com/questions/5324647/how-to-merge-a-transparent-png-image-with-another-image-using-pil)
- [http://effbot.org/imagingbook/image.htm#tag-Image.Image.paste](http://effbot.org/imagingbook/image.htm#tag-Image.Image.paste)

```python
canvas.paste(img, (left, top), img)
```

## PIL.ImageDraw: テキストの描画

`.text` の `font` オプションを省略するとデフォルトのフォントが選択されるが、その場合フォントサイズも自動で選ばれる.
フォントサイズを指定するには `ImageFont` を用いてしかもフォント名を指定する必要がある.

フォント名は、ファイル名から拡張子を除いたもの.
以下のように truetype を使うなら

```bash
locate .ttf | sed 's,.*/,,g' | sed 's/\.ttf$//g'
```

で列挙されるものから選ぶ必要がある.

```python
from PIL import Image, ImageDraw, ImageFont


W = 200
H = 28
white = (255, 255, 255)
canvas = Image.new('RGBA', (W, H), white)

font = ImageFont.truetype(font='Osaka', size=18)
d = ImageDraw.Draw(canvas)

left = 10
top = 5
black = (0, 0, 0)
d.text((left, top), 'Hello', fill=black, font=font)

canvas.save('out.png')
```

## numpy.ndarray への相互変換

```bash
$ identify test.png
test.png PNG 640x480 640x480+0+0 8-bit sRGB 13KB 0.000u 0:00.000
```

```python
import numpy
from PIL import Image

# open as PIL.Image
img = Image.open('test.png')  # <PIL.PngImagePlugin.PngImageFile image mode=RGB size=640x480 at 0x101C49E80>
img.size  # (640, 480) == (width, height)

# PIL.Image => numpy.ndarray
arr = numpy.array(img)
arr.shape  # (480, 640, 3) == (height, width, ch)
type(arr), arr.dtype  # <class 'numpy.ndarray'> uint8

# dummy RGB numpy-array
arr = numpy.zeros((10, 30, 3), dtype=numpy.uint8)
arr[:, :10, 0] = 255  # R
arr[:, 10:20, 1] = 255  # G
arr[:, 20:30, 2] = 255  # B

# numpy.ndarray => PIL.Image
img = Image.fromarray(arr)
img.show()
```


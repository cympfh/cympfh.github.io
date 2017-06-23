% データの段落分け, index

一つのファイルに複数のデータを書き、
`index` キーワードを使うことでそのうちのいくつかのデータだけを使ってプロットさせられる.
データは **2** つの空行で区切って並べる.

[every](data.blocks.html) とよく似ているが、こちらは出来ることが少ない代わりに特化しており、
データに名前を付けることで名前で使うデータを指定できる.

## data format

データは **2行** の空行で区切る.
データは先頭から 0-start の index が与えられる.
データの先頭にコメントで名前 (`<data_name>`) を与えられる.

```dat
# data1
x1 y1
x2 y2
x3 y3


# data2
x1 y1
x2 y2
x3 y3
```

## `index` keyword

次の2種類の使い方がある.

```bash
plot ... index <start_index>{:<end_index>{:<index_incr>}}
plot ... index <data_name>
```

| params         | default     |        value | explanation                |
|:---------------|:------------|:-------------|:---------------------------|
| `start_index`  |             |   (int)index | このデータをプロットに使う |
| `end_index`    | start_index |   (int)index | start_index からここまでのデータをプロットに使う
| `index_incr`   | 1           |        (int) | start_index から end_index までの範囲にステップを与える |
| `data_name`    |             |     (string) | この名前のデータをプロットに使う |

## example

@[bash](data.index.gp)

@[dat](data.index.dat)

![](data.index.png)




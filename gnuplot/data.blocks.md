% データの段落分け, every

段落に分けることで異なるデータを一つのファイルに含めることができる.
段落は **1** つの空行で区切る.
段落は block と呼ばれる.
空行を除いた行を point (または column) と呼ぶ.

単に一つのブロックを指定してプロットしたいだけの場合は、
[index](data.index.html) を使った方がいいと思う.

## data format

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

## `every` keyword

```bash
plot ... every {<point_incr>}
    {:{<block_inr>}
    {:{<start_point>}
    {:{<start_block>}
    {:{<end_point>}
    {:{<end_block>}}}}}}
```

| params           | default       | value          | explanation |
| :--------------- | :------------ | :------------- | :---------- |
| `point_incr`     | 1             | (int)          | 読む point (行) のステップ            |
| `block_inr`      | 1             | (int)          | 読む block のステップ  |
| `start_point`    | 0             | (int)          | 読む point の最初 (0-start index)  |
| `start_block`    | 0             | (string)       | 読む block の最初 (0-start index)  |
| `end_point`      | last          | (string)       | 読む point の最期 |
| `end_block`      | last          | (string)       | 読む block の最期 |

例えば、 1 番目のブロック (0-start) のみ指定するには
`every :::1::1`
とする
(何度も言うがこれなら `index` の方が分かりやすいし良い).

## example

@[bash](data.blocks.gp)

@[dat](data.blocks.dat)

![](data.blocks.png)

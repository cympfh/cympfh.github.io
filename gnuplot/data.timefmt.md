# 日付時刻データ

## timefmt を使う方法

用いるデータの中に出現する日付時刻のフォーマットがただ一通りの場合に有効.

まず、
読み込むデータの `x` 及び `y` が日付時刻であることを宣言する必要がある.

```bash
set xdata time
set ydata time
```

日付時刻データのフォーマットはデフォルトでは `"%d/%m/%y,%H:%M"` である.
`%-`指定子の意味は後述.
C言語の printf みたいな感じでフォーマットを作って、

```bash
set timefmt <format>
```

を用いて自由にフォーマットを変更できる.

また `xtics` `ytics` の表示に関しても、そのフォーマットを別途指定する必要がある
(`timefmt` に勝手に揃う気がしてたんだけど、バージョンによるのかもしれない).

```bash
set format x <format>
set format y <format>
```

この `<format>` も先ほどのと同じ、%-指定子を用いた文字列である.

## timeformat `%-`指定子

| format   | explanation                |
| :------: | :-----------               |
| `%d`     | 日 (1-31)                  |
| `%m`     | 月 (1-12)                  |
| `%y`     | 年の下2桁 (0-99)           |
| `%Y`     | 年の4桁                    |
| `%j`     | day of the year (1-365)    |
| `%H`     | 時 (0-24)                  |
| `%M`     | 分 (0-60)                  |
| `%S`     | 秒 (0-60)                  |
| `%s`     | UNIX time                  |
| `%B`     | 月の英語表記               |
| `%b`     | 月の英語表記 (3文字省略形) |

### 例

時刻表示の中にスペース文字など、通常区切り文字として使われるようなものが含まれることが多々ある. そういうときのために `using 1:2` などを明示的に指定する必要がある.

@[bash](data.timefmt.gp)
@[dat](data.timefmt.dat)

![](data.timefmt.png)

## 異なるフォーマットを共存させるには

`x` と `y` が異なるフォーマットの日付時刻データである、
あるいは複数のデータを同時にプロットさせるに当たって別のフォーマットが使われてるなどの場合、
異なるフォーマットを指定したい.
`set timefmt` は設定を上書きするだけで、 `plot` 時点での設定が使われるので、
基本的に1つのフォーマットしか使えない.

StackOverFlow の
"Plot two files in gnuplot with different timefmt" という質問にあった回答の
[https://stackoverflow.com/a/31009235](https://stackoverflow.com/a/31009235)
で出来た.
`using` の中で `strptime` 関数を直接呼び出せばよい.
`gnuplot 5.0` 以上ならより簡素な `timecolumn` 関数の方が便利

### 例

`timecolumn` 関数を使って、x, y で別のフォーマットが使われているデータをプロットする.

@[bash](data.timefmt2.gp)

![](data.timefmt2.png)

% 日付時刻データ

- [gnuplot demo script: timedat.dem](http://www.gnuplot.info/demo/timedat.html)

日付時刻をデータに使う.

読み込むデータの `x` 及び `y` が日付時刻であることを宣言するには

```bash
set xdata time
set ydata time
```

を用いる.
データのフォーマットはデフォルトでは `"%d/%m/%y,%H:%M"` である必要がある (`%-`指定子の意味は後述).

```bash
set timefmt <format>
```

を用いて自由にフォーマットを変更できる.

また `xtics` `ytics` の表示は基本的にはデータに揃えて自動的に時刻表示になるが、
そのフォーマットもまた別途指定する必要がある
(データに勝手に揃う気がしてたんだけど、バージョンによるのかもしれない).

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

## example

時刻表示の中にスペース文字など、通常区切り文字として使われるようなものが含まれることが多々ある. そういうときのために `using 1:2` などを明示的に指定する必要がある.

@[bash](data.timefmt.gp)
@[dat](data.timefmt.dat)

![](data.timefmt.png)

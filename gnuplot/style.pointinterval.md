# 点の周りにスペースを空ける

## 概要

`with linespoints`
のときに点を線でつないで描画されるがそのとき点の周りに少しスペースを空ける事ができる.

`pointinterval` (`pi`) で `-1` を指定して, `set pointintervalbox` でスペースの大きさを指定すると実現できる.

```bash
set style line 1 pi -1
set pointinterval 3

plot $data w lp ls 1
```

```gnuplot
set object 1 rect behind from screen 0,0 to screen 1,1 fc rgb "#ffffff" fillstyle solid 1.0

set style line 1 lw 2 pt 6 lc rgb "#00aaaa" pi -1

set style line 11 lc rgb '#808080' lt 1 lw 3
set border 0 back ls 11
set tics out nomirror

set style line 12 lc rgb '#808080' lt 0 lw 1
set grid back ls 12

set samples 10
set pointinterval 2
plot x w lp ls 1
```

## 参考

[Join data points with non-continuous lines](http://www.gnuplotting.org/tag/linespoints/)

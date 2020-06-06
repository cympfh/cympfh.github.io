# awesome style

```bash
set terminal pngcairo

set style line 1 lw 2 pt 6 lc rgb "#00aaaa"

set style line 11 lc rgb '#808080' lt 1 lw 3
set border 0 back ls 11
set tics out nomirror

set style line 12 lc rgb '#808080' lt 0 lw 1
set grid back ls 12

set xrange [-4:4]
plot x**3
```

以下は pngcairo ではないが

```gnuplot
set style line 1 lw 2 pt 6 lc rgb "#00aaaa"

set style line 11 lc rgb '#808080' lt 1 lw 3
set border 0 back ls 11
set tics out nomirror

set style line 12 lc rgb '#808080' lt 0 lw 1
set grid back ls 12

set xrange [-4:4]
plot x**3 ls 1
```

set terminal pngcairo size 700,400
set output 'data.timefmt.png'

set xdata time
set timefmt '%Y/%m'
set format x '%Y/%m'
set grid
plot 'data.timefmt.dat' u 1:2 smooth cspline

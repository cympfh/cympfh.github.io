set terminal pngcairo
set output 'timefmt.png'

set xdata time
set timefmt '%m/%d'

set grid
plot 'timefmt.dat' u 1:2 smooth cspline ,\
                '' u 1:2:1 with labels point pt 7 left offset 1

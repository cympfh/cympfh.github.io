set terminal pngcairo size 350,600
set output 'box.png'

set grid
set ytics 0.1
unset key
plot 'box.dat' u (0):2:(0):1 with boxplot

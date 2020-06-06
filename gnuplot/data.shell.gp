set terminal pngcairo
set output 'shell.png'

set grid
set key bottom

plot '<seq 100' ,\
     '<seq 100' u 1:($1*sin($1/pi)) smooth bezier

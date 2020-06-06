set terminal png
set output 'blocks.png'
plot 'blocks.dat' every :::0::0 lc rgb "#0000ff" w lp title 'data1' ,\
     'blocks.dat' every :::1::1 lc rgb "#00ff00" smooth bezier title 'data2'

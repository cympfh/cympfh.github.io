set terminal pngcairo size 700,400
set output 'yerrorbars.png'

set key bottom right
set xrange [0:4]
plot '< cat yerrorbars.dat | ruby error.rb' ls 1 with yerrorbars ,\
                                 '' ls 1 with lines ,\

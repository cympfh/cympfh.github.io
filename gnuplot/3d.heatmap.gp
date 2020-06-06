set terminal pngcairo
set output 'heatmap.png'

unset key
set title 'Heatmap with image'

set cbrange [0:30]  # the range of colorbox
set palette cubehelix start -2 cycles 0 saturation 3 gamma 3 negative  # color scheme

plot 'heatmap.dat' matrix rowheaders columnheaders u 1:2:3 with image ,\
                '' matrix rowheaders columnheaders u 1:2:(sprintf("%g", $3)) with labels

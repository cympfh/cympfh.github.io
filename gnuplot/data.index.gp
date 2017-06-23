set terminal png
set output 'index.png'

# index で指定する場合
# plot 'index.dat' index 0 lc rgb "#0000ff" w lp title 'index0' ,\
#      'index.dat' index 1 lc rgb "#00ff00" smooth bezier title 'index1'

# data_name で指定する場合
plot 'index.dat' index 'linear' lc rgb "#0000ff" w lp ,\
     'index.dat' index 'exp' lc rgb "#00ff00" smooth bezier

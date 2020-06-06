set terminal pngcairo size 700,400
set output 'data.timefmt2.png'

$data << EOD
2017-10-23 13:43:00
2017-10-24 14:37:45
2017-10-25 14:18:06
2017-10-26 14:31:48
2017-10-27 12:12:41
2017-10-30 13:56:49
EOD

set xdata time
set ydata time

xformat = '%Y-%m-%d'  # parse format (for timecolumn)
yformat = '%H:%M:%S'

set format x '%m/%d'  # tics format
set format y '%H:%M'

plot $data using (timecolumn(1, xformat)):(timecolumn(2, yformat)) w lp

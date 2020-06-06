set term pngcairo
set output '3d.heatmap.grid.ng.png'

$data << EOD
X a b c d e
A 0.0 -0.06 -0.25 -0.56 -1.0
B 0.11 0.04 -0.13 -0.45 -0.88
C 0.44 0.38 0.19 -0.11 -0.55
D 1.0 0.93 0.75 0.43 0.0
E 1.77 1.71 1.52 1.21 0.77
EOD

set grid front lw 1.5 lt -1 lc rgb 'white'
plot $data matrix rowheaders columnheaders w image not

/// Sequence - 2D Cumulative Summation
struct CumSum2D(Vec<Vec<i64>>);
impl CumSum2D {
    fn new(data: &Vec<Vec<i64>>) -> CumSum2D {
        let h = data.len();
        let w = data[0].len();
        let mut cs = vec![vec![0; w + 1]; h + 1];
        for i in 0..h {
            for j in 0..w {
                cs[i + 1][j + 1] = data[i][j] + cs[i][j + 1] + cs[i + 1][j] - cs[i][j];
            }
        }
        CumSum2D(cs)
    }
    fn sum_up(&self, x: usize, y: usize) -> i64 {
        let x = std::cmp::min(x, self.0.len());
        let y = std::cmp::min(y, self.0[0].len());
        self.0[x][y]
    }
    fn sum(&self, xrange: std::ops::Range<usize>, yrange: std::ops::Range<usize>) -> i64 {
        if xrange.end <= xrange.start || yrange.end <= yrange.start {
            0
        } else {
            self.sum_up(xrange.end, yrange.end)
                - self.sum_up(xrange.start, yrange.end)
                - self.sum_up(xrange.end, yrange.start)
                + self.sum_up(xrange.start, yrange.start)
        }
    }
}

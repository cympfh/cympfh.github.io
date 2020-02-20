/// Sequence - Binary Indexed Tree (Fenwick Tree)
use std::ops::Range;
struct BIT { size: usize, array: Vec<i32> }
impl BIT {
    fn new(n: usize) -> BIT {
        BIT  { size: n, array: vec![0; n + 1] }
    }
    fn add(&mut self, idx: usize, w: i32) {
        let mut x = idx + 1;
        while x <= self.size {
            self.array[x] += w;
            let xi = x as i32;
            x += (xi&-xi) as usize;
        }
    }
    fn sum_up(&self, idx: usize) -> i32 { // [0, idx)
        let mut sum = 0;
        let mut x = idx;
        while x > 0 {
            sum += self.array[x];
            let xi = x as i32;
            x -= (xi&-xi) as usize;
        }
        sum
    }
    fn sum(&self, range: Range<usize>) -> i32 {
        self.sum_up(range.end) - self.sum_up(range.start)
    }
}

/// Sequence - Binary Indexed Tree (Fenwick Tree)
// @algebra.group.rs
struct BIT<T> { size: usize, array: Vec<T> }
impl<T: Group> BIT<T> {
    fn new(n: usize) -> BIT<T> {
        BIT  { size: n, array: vec![T::zero(); n + 1] }
    }
    fn add(&mut self, idx: usize, w: T) {
        let mut x = idx + 1;
        while x <= self.size {
            self.array[x] = self.array[x] + w;
            let xi = x as i32;
            x += (xi&-xi) as usize;
        }
    }
    fn sum_up(&self, idx: usize) -> T { // [0, idx)
        let mut sum = T::zero();
        let mut x = idx;
        while x > 0 {
            sum = sum + self.array[x];
            let xi = x as i32;
            x -= (xi& - xi) as usize;
        }
        sum
    }
    fn sum(&self, range: std::ops::Range<usize>) -> T {
        self.sum_up(range.end) - self.sum_up(range.start)
    }
}

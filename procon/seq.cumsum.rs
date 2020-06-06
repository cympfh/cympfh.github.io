/// Sequence - Cumulative Summation
// @algebra.group.rs
struct Cumsum<T>(Vec<T>);
impl<T: Group> Cumsum<T> {
    fn new(xs: &Vec<T>) -> Cumsum<T> {
        let mut ac = T::zero();
        let mut arr = vec![T::zero(); xs.len()];
        for i in 0..arr.len() {
            ac = ac + xs[i];
            arr[i] = ac;
        }
        Cumsum(arr)
    }
    fn sum_up(&self, idx: usize) -> T {
        // [0, idx)
        if idx > 0 {
            self.0[idx - 1]
        } else {
            T::zero()
        }
    }
    fn sum(&self, range: std::ops::Range<usize>) -> T {
        // sum(i..j) = sum of [i, j)
        assert!(range.start <= range.end);
        self.sum_up(range.end) - self.sum_up(range.start)
    }
}

/// Sequence - Cumulative Summation
struct Cumsum { array: Vec<i32> }
impl Cumsum {
    fn new(xs: &Vec<i32>) -> Cumsum {
        let mut ac = 0;
        let mut arr = vec![0; xs.len()];
        for i in 0..arr.len() {
            ac += xs[i];
            arr[i] = ac;
        }
        Cumsum { array: arr }
    }
    fn sum_up(&self, idx: usize) -> i32 { // [0, idx)
        if idx > 0 {
            self.array[idx - 1]
        } else {
            0
        }
    }
    fn sum(&self, range: std::ops::Range<usize>) -> i32 { // sum(i..j) = sum of [i, j)
        assert!(range.start <= range.end);
        self.sum_up(range.end) - self.sum_up(range.start)
    }
}

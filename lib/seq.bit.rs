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
    fn sum(&self, idx: usize) -> i32 {
        let mut sum = 0;
        let mut x = idx + 1;
        while x > 0 {
            sum += self.array[x];
            let xi = x as i32;
            x -= (xi&-xi) as usize;
        }
        sum
    }
}

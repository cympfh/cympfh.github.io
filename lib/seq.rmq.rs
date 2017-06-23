struct RMQ {heap: Vec<i32>, size: usize, lefts: Vec<usize>, rights: Vec<usize>}
impl RMQ {

    fn alignment(n: usize) -> usize {
        let mut m = 1; let mut k = 1;
        while n > m { k += 1; m *= 2; }
        m * 2 - 1
    }

    fn of_left(idx: usize, base: usize) -> usize {
        let mut i = idx; while i < base { i = i * 2 + 1; }
        i - base
    }

    fn of_right(idx: usize, base: usize) -> usize {
        let mut i = idx; while i < base { i = i * 2 + 2; }
        i - base
    }

    fn new(v: &Vec<i32>) -> RMQ {
        let n = v.len();
        let size = RMQ::alignment(n);
        let mut heap = vec![0; size];
        for i in 0..n { heap[i + size/2] = v[i]; }
        for i in (0..size/2).rev() { heap[i] = max(heap[i*2+1], heap[i*2+2]); }
        let lefts = (0..size).map(|i| RMQ::of_left(i, size/2)).collect();
        let rights = (0..size).map(|i| RMQ::of_right(i, size/2)).collect();
        RMQ {heap: heap, size: size, lefts: lefts, rights: rights}
    }

    // max [left..right] inclusively
    fn max(&self, left: usize, right: usize) -> i32 {
        if left > right { return 0 }
        if left == right { return self.heap[self.size/2 + left] }
        let mut i = self.size/2 + left;
        loop {
            let parent = (i - 1) / 2;
            if self.lefts[parent] == left && self.rights[parent] <= right {
                i = parent;
            } else {
                break
            }
        }
        max(self.heap[i], self.max(self.rights[i] + 1, right))
    }

    // [idx] <- x
    fn update(&mut self, idx: usize, x: i32) {
        let mut i = idx + self.size/2;
        self.heap[i] = x;
        loop {
            i = (i - 1) / 2;
            if i == 0 { break }
            self.heap[i] = max(self.heap[i*2+1], self.heap[i*2+2]);
        }
    }

    // [idx] <- [idx] + x
    fn add(&mut self, idx: usize, x: i32) {
        let z = self.heap[idx + self.size/2] + x;
        self.update(idx, z);
    }

    fn at(&self, idx: usize) -> i32 {
        self.heap[idx + self.size/2]
    }
}

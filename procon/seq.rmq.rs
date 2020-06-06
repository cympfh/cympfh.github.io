/// Sequence - Range Maximum/Minimum Query (RMQ)
// @algebra.hyper.rs
struct RMQ<X> {
    size: usize, len: usize,
    heap_max: Vec<X>,
    heap_min: Vec<X>,
    lefts: Vec<usize>, rights: Vec<usize>
}

impl<X: Ring + Ord> RMQ<X> {
    fn new(v: &Vec<X>) -> RMQ<X> {
        let n = v.len();
        let size = RMQ::<X>::alignment(n);
        let lefts = (0..size).map(|i| RMQ::<X>::of_left(i, size/2)).collect();
        let rights = (0..size).map(|i| RMQ::<X>::of_right(i, size/2)).collect();
        let mut heap_max = vec![X::zero(); size];
        for i in 0..n { heap_max[i + size/2] = v[i]; }
        for i in (0..size/2).rev() { heap_max[i] = std::cmp::max(heap_max[i*2+1], heap_max[i*2+2]); }
        let mut heap_min = vec![X::zero(); size];
        for i in 0..n { heap_min[i + size/2] = v[i]; }
        for i in (0..size/2).rev() { heap_min[i] = std::cmp::min(heap_min[i*2+1], heap_min[i*2+2]); }
        RMQ {size: size, len: n, heap_max: heap_max, heap_min: heap_min, lefts: lefts, rights: rights}
    }
    fn len(&self) -> usize {
        self.len
    }
    fn alignment(n: usize) -> usize {
        let mut m = 1;
        while n > m { m <<= 1; }
        m * 2 - 1
    }
    fn of_left(idx: usize, base: usize) -> usize {
        let mut i = idx; while i < base { i = i * 2 + 1; }
        i - base
    }
    fn of_right(idx: usize, base: usize) -> usize {
        let mut i = idx; while i < base { i = i * 2 + 2; }
        i - base + 1
    }
    fn max(&self, range: std::ops::Range<usize>) -> Hyper<X> {
        if range.end == 0 || range.start + 1 > range.end {
            return NegInf
        }
        if range.start + 1 == range.end {
            return Real(self.heap_max[self.size / 2 + range.start])
        }
        let left = range.start;
        let right = range.end;
        let mut i = self.size / 2 + left;
        while i > 0 {
            let p = (i - 1) / 2;
            if self.lefts[p] == range.start && self.rights[p] <= range.end {
                i = p;
            } else {
                break
            }
        }
        std::cmp::max(Real(self.heap_max[i]), self.max(self.rights[i]..right))
    }
    fn min(&self, range: std::ops::Range<usize>) -> Hyper<X> {
        if range.end == 0 || range.start + 1 > range.end {
            return Inf
        }
        if range.start + 1 == range.end {
            return Real(self.heap_min[self.size / 2 + range.start])
        }
        let left = range.start;
        let right = range.end;
        let mut i = self.size / 2 + left;
        while i > 0 {
            let p = (i - 1) / 2;
            if self.lefts[p] == range.start && self.rights[p] <= range.end {
                i = p;
            } else {
                break
            }
        }
        std::cmp::min(Real(self.heap_min[i]), self.min(self.rights[i]..right))
    }
    // [idx] <- x
    fn update(&mut self, idx: usize, x: X) {
        let mut i = idx + self.size/2;
        self.heap_max[i] = x;
        self.heap_min[i] = x;
        loop {
            i = (i - 1) / 2;
            if i == 0 { break }
            self.heap_max[i] = std::cmp::max(self.heap_max[i*2+1], self.heap_max[i*2+2]);
            self.heap_min[i] = std::cmp::min(self.heap_min[i*2+1], self.heap_min[i*2+2]);
        }
    }
    // [idx] <- [idx] + x
    fn add(&mut self, idx: usize, x: X) {
        self.update(idx, self[idx] + x);
    }
    fn to_vec(&self) -> Vec<X> {
        (0..self.len()).map(|i| self[i]).collect()
    }
}

impl<X> std::ops::Index<usize> for RMQ<X> {
    type Output = X;
    fn index(&self, i: usize) -> &X {
        &self.heap_max[i + self.size / 2]
    }
}

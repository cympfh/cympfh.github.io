/// Seq - Segment Tree
#[derive(Debug, Copy, Clone, PartialEq, Eq, PartialOrd, Ord)]
enum MaxInt { Minimal, Val(i64) }
impl std::ops::Mul for MaxInt {
    type Output = Self;
    fn mul(self, other: Self) -> Self {
        if self > other { self } else { other }
    }
}
impl Monoid for MaxInt {
    fn unit() -> Self { MaxInt::Minimal }
}

#[derive(Debug, Copy, Clone, PartialEq, Eq, PartialOrd, Ord)]
enum MinInt { Val(i64), Maximal }
impl std::ops::Mul for MinInt {
    type Output = Self;
    fn mul(self, other: Self) -> Self {
        if self < other { self } else { other }
    }
}
impl Monoid for MinInt {
    fn unit() -> Self { MinInt::Maximal }
}

#[derive(Clone)]
struct SegmentTree<T> { size: usize, depth: usize, data: Vec<Vec<T>> }
impl<T> std::ops::Index<usize> for SegmentTree<T> {
    type Output = T;
    fn index(&self, i: usize) -> &Self::Output {
        &self.data[self.depth - 1][i]
    }
}
impl<T: Monoid> SegmentTree<T> {
    fn new(size: usize) -> SegmentTree<T> {
        let mut data = vec![];
        let mut i = 1;
        loop {
            data.push(vec![T::unit(); i]);
            if i >= size { break }
            i *= 2;
        }
        SegmentTree { size: size, depth: data.len(), data: data }
    }
    fn to_vec(self) -> Vec<T> {
        (self.data[self.depth - 1][0..self.size]).to_vec()
    }
    fn update(&mut self, idx: usize, t: T) {
        self.data[self.depth - 1][idx] = t;
        let mut i = idx;
        for d in (0..self.depth - 1).rev() {
            i /= 2;
            self.data[d][i] = self.data[d + 1][i * 2] * self.data[d + 1][i * 2 + 1];
        }
    }
    fn product(&self, range: std::ops::Range<usize>) -> T {
        if range.end == 0 || range.start + 1 > range.end {
            T::unit()
        } else if range.start + 1 == range.end {
            self[range.start]
        } else {
            let mut i = range.start;
            let mut d = self.depth - 1;
            let mut width = 1;
            while d > 0 {
                let left = (i / 2) * width * 2;
                let right = left + width * 2;
                if left == range.start && right <= range.end {
                    i /= 2;
                    d -= 1;
                    width *= 2;
                } else {
                    break
                }
            }
            let right = range.start + width;
            self.data[d][i] * self.product(right..range.end)
        }
    }
}
impl<T: std::fmt::Debug> SegmentTree<T> {
    fn debug(&self) {
        for i in 0..self.depth {
            trace!(&self.data[i]);
        }
    }
}

/// Seq - Lazy Segment Tree
// @algebra.monoid.rs
// @algebra.act.rs
#[derive(Clone)]
struct LazySegmentTree<X, M> {
    size: usize,
    size_upper: usize, // power of 2
    depth: usize,
    data: Vec<Vec<X>>,
    act: Vec<Vec<M>>,
}
impl<X: Monoid, M: Monoid + Act<X>> LazySegmentTree<X, M> {
    fn new(size: usize) -> Self {
        let mut data = vec![];
        let mut act = vec![];
        let mut i = 1;
        loop {
            data.push(vec![X::unit(); i]);
            act.push(vec![M::unit(); i]);
            if i >= size {
                break;
            }
            i *= 2;
        }
        LazySegmentTree {
            size,
            size_upper: i,
            depth: data.len(),
            data,
            act,
        }
    }
    fn from(xs: Vec<X>) -> Self {
        let mut tree = Self::new(xs.len());
        for i in 0..xs.len() {
            tree.data[tree.depth - 1][i] = xs[i];
        }
        for depth in (0..tree.depth - 1).rev() {
            for i in 0..tree.data[depth].len() {
                tree.data[depth][i] = tree.data[depth + 1][2 * i] * tree.data[depth + 1][2 * i + 1];
            }
        }
        tree
    }
    fn propagation(&mut self, depth: usize, idx: usize) {
        if depth + 1 < self.depth {
            self.act[depth + 1][idx * 2] = self.act[depth + 1][idx * 2] * self.act[depth][idx];
            self.act[depth + 1][idx * 2 + 1] =
                self.act[depth + 1][idx * 2 + 1] * self.act[depth][idx];
        }
        self.data[depth][idx] = self.act[depth][idx].act(self.data[depth][idx]);
        self.act[depth][idx] = M::unit();
    }
    fn update_sub(
        &mut self,
        range: std::ops::Range<usize>,
        m: M,
        depth: usize,
        idx: usize,
        focus: std::ops::Range<usize>,
    ) {
        self.propagation(depth, idx);
        if focus.end <= range.start || range.end <= focus.start {
            return;
        }
        if range.start <= focus.start && focus.end <= range.end {
            self.act[depth][idx] = self.act[depth][idx] * m;
            self.propagation(depth, idx);
        } else if depth + 1 < self.depth {
            let mid = (focus.start + focus.end) / 2;
            self.update_sub(range.clone(), m, depth + 1, idx * 2, focus.start..mid);
            self.update_sub(range.clone(), m, depth + 1, idx * 2 + 1, mid..focus.end);
            self.data[depth][idx] =
                self.data[depth + 1][idx * 2] * self.data[depth + 1][idx * 2 + 1];
        }
    }
    fn update(&mut self, range: std::ops::Range<usize>, m: M) {
        self.update_sub(range, m, 0, 0, 0..self.size_upper);
    }
    fn product_sub(
        &mut self,
        range: std::ops::Range<usize>,
        depth: usize,
        idx: usize,
        focus: std::ops::Range<usize>,
    ) -> X {
        self.propagation(depth, idx);
        if focus.end <= range.start || range.end <= focus.start {
            X::unit()
        } else if range.start <= focus.start && focus.end <= range.end {
            self.data[depth][idx]
        } else {
            let mid = (focus.start + focus.end) / 2;
            let a = self.product_sub(range.clone(), depth + 1, idx * 2, focus.start..mid);
            let b = self.product_sub(range.clone(), depth + 1, idx * 2 + 1, mid..focus.end);
            a * b
        }
    }
    fn product(&mut self, range: std::ops::Range<usize>) -> X {
        self.product_sub(range, 0, 0, 0..self.size_upper)
    }
    fn index(&mut self, i: usize) -> X {
        self.product(i..i + 1)
    }
    fn to_vec(&mut self) -> Vec<X> {
        (0..self.size).map(|i| self.index(i)).collect()
    }
}
impl<X: std::fmt::Debug, M: std::fmt::Debug> LazySegmentTree<X, M> {
    fn debug(&self) {
        for i in 0..self.depth {
            for j in 0..self.data[i].len() {
                eprint!("{:?} / {:?}; ", &self.data[i][j], &self.act[i][j]);
            }
            eprintln!();
        }
    }
}

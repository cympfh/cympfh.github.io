/// Neighbor
// @collections.list_comprehension_macro.rs
mod neighbor {
    pub struct Grid4(pub usize, pub usize);
    impl Grid4 {
        pub fn iter(&self, i: usize, j: usize) -> NeighborIter<(usize, usize)> {
            NeighborIter::new(list! {
                (i + s - 1, j + t - 1);
                for s in 0..3;
                for t in 0..3;
                if (s + t) % 2 == 1;
                if (1..self.0 + 1).contains(&(i + s));
                if (1..self.1 + 1).contains(&(j + t));
            })
        }
    }
    pub struct Grid8(pub usize, pub usize);
    impl Grid8 {
        pub fn iter<'a>(&'a self, i: usize, j: usize) -> NeighborIter<(usize, usize)> {
            NeighborIter::new(list! {
                (i + s - 1, j + t - 1);
                for s in 0..3;
                for t in 0..3;
                if s * t != 1;
                if (1..self.0 + 1).contains(&(i + s));
                if (1..self.1 + 1).contains(&(j + t));
            })
        }
    }
    pub struct NeighborIter<T>(Vec<T>, usize);
    impl<T> NeighborIter<T> { fn new(data: Vec<T>) -> Self { NeighborIter(data, 0) } }
    impl<T: Copy> Iterator for NeighborIter<T> {
        type Item = T;
        fn next(&mut self) -> Option<Self::Item> {
            if self.0.len() > self.1 { self.1 += 1; Some(self.0[self.1 - 1]) } else { None }
        }
    }
}

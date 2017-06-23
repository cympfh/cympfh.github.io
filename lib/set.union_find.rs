struct UnionFind { table: Vec<i32> }
impl UnionFind {

    fn new(n: usize) -> UnionFind {
        UnionFind { table: vec![-1; n], }
    }

    fn root(&mut self, x: i32) -> i32 {
        if self.table[x as usize] < 0 {
            x
        } else {
            let px = self.table[x as usize];
            let r = self.root(px);
            self.table[x as usize] = r;
            r
        }
    }

    fn merge(&mut self, x: i32, y: i32) {
        let mut rx = self.root(x) as usize;
        let mut ry = self.root(y) as usize;
        if rx != ry {
            if self.table[ry] < self.table[rx] { swap!(rx, ry) }
            self.table[rx] += self.table[ry];
            self.table[ry] = rx as i32;
        }
    }

    fn size(&mut self, x: i32) -> i32 {
        let r = self.root(x);
        return -self.table[r as usize]
    }

}

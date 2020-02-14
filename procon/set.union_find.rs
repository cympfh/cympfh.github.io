#[derive(Debug, Clone)]
enum UF { Root(usize), Child(usize) }

#[derive(Debug)]
struct UnionFind { table: Vec<UF> }
impl UnionFind {
    fn new(n: usize) -> UnionFind {
        UnionFind { table: vec![UF::Root(1); n], }
    }
    fn root(&mut self, x: usize) -> usize {
        match self.table[x] {
            UF::Root(_) => x,
            UF::Child(parent) => {
                let root = self.root(parent);
                self.table[x] = UF::Child(root);
                root
            }
        }
    }
    fn is_same(&mut self, x: usize, y: usize) -> bool {
        self.root(x) == self.root(y)
    }
    fn size(&mut self, x: usize) -> usize {
        let r = self.root(x);
        match self.table[r] {
            UF::Root(size) => size,
            UF::Child(_) => 0
        }
    }
    fn merge(&mut self, x: usize, y: usize) {
        let root_x = self.root(x);
        let root_y = self.root(y);
        if root_x != root_y {
            let size_x = self.size(root_x);
            let size_y = self.size(root_y);
            let (i, j) = if size_x > size_y {
                (root_x, root_y)
            } else {
                (root_y, root_x)
            };
            self.table[i] = UF::Root(size_x + size_y);
            self.table[j] = UF::Child(i);
        }
    }
}

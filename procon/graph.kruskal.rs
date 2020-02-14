/// @algebra.group.rs
fn kruskal<Cost: Group + PartialOrd>(n: usize, edges: &Vec<(usize, usize, Cost)>) -> Cost {
    let mut total = Cost::zero();
    let mut uf = UnionFind::new(n);
    let mut q: Vec<_> = edges.iter().map(|&(i, j, c)| (Total(c), i, j)).collect();
    q.sort();
    for &(cost, i, j) in q.iter() {
        if uf.is_same(i, j) { continue }
        uf.merge(i, j);
        total = total + cost.0;
    }
    total
}

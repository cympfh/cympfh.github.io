fn is_bipartite_graph(n: usize, g: &Vec<Vec<usize>>) -> bool {
    let mut uf = UnionFind::new(n * 2);
    for i in 0..n {
        for &j in g[i].iter() {
            if i >= j { continue }
            uf.merge(2 * i, 2 * j + 1);
            uf.merge(2 * i + 1, 2 * j);
        }
    }
    for i in 0..n {
        if uf.is_same(2 * i, 2 * i + 1) { return false }
    }
    true
}

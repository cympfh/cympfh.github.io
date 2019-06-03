#[derive(Debug)]
struct Topological(Vec<usize>);

impl Topological {

    fn visit(u: usize, mut used: &mut Vec<bool>, rd: &Vec<Vec<usize>>, mut ord: &mut Vec<usize>) {
        if used[u] { return }
        used[u] = true;
        for &v in rd[u].iter() {
            Self::visit(v, &mut used, &rd, &mut ord);
        }
        ord.push(u);
    }

    fn new(neigh: &Vec<Vec<usize>>) -> Self {
        let n = neigh.len();
        let mut rd = vec![vec![]; n];
        for u in 0..n {
            for &v in neigh[u].iter() {
                rd[v].push(u);
            }
        }
        // sort
        let mut used = vec![false; n];
        let mut ord = vec![];
        for u in 0..n { Self::visit(u, &mut used, &rd, &mut ord); }
        Topological(ord)
    }
}

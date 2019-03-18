use std::collections::BinaryHeap;

type Cost = i64;
const MaxCost: Cost = 1_000_000_000_000_000;

fn dij(s: usize, neigh: &Vec<Vec<(usize, Cost)>>) -> Vec<Cost> {
    let n = neigh.len();
    let mut d: Vec<Cost> = vec![MaxCost; n];
    let mut q = BinaryHeap::new();
    q.push((0, s));
    d[s] = 0;
    while let Some((_, u)) = q.pop() {
        for &(v, cost) in neigh[u].iter() {
            if d[v] > d[u] + cost {
                d[v] = d[u] + cost;
                q.push((-d[v], v));
            }
        }
    }
    d
}

fn main() {

    let mut sc = Scanner::new();

    let n: usize = sc.cin(); // nodes
    let m: usize = sc.cin(); // edges
    let mut neigh = vec![vec![]; n];
    for _ in 0..m {
        let u = sc.cin::<usize>() - 1;
        let v = sc.cin::<usize>() - 1;
        let c: Cost = sc.cin();
        neigh[u].push((v, c));
        neigh[v].push((u, c));
    }

    let d = dij(0, &neigh);
    trace!(d);

}

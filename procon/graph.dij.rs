/// @algebra.hyper.rs
/// @algebra.total.rs

fn dij<Cost: Group + PartialOrd> (s: usize, neigh: &Vec<Vec<(usize, Cost)>>) -> Vec<Hyper<Cost>> {
    let n = neigh.len();
    let mut d: Vec<Hyper<Cost>> = vec![Inf; n];
    let mut q = std::collections::BinaryHeap::new();
    d[s] = Real(Cost::zero());
    q.push((Total(d[s]), s));
    while let Some((_, u)) = q.pop() {
        for &(v, cost) in neigh[u].iter() {
            if d[v] > d[u] + Real(cost) {
                d[v] = d[u] + Real(cost);
                q.push((Total(-d[v]), v));
            }
        }
    }
    d
}

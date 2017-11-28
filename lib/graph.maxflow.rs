mod Dinic {
    use std::collections::VecDeque;
    use std::cmp::min;

    pub type Weight = i32;
    pub type WeightedGraph = Vec<Vec<(usize, Weight)>>; // [u][] = (v, w)

    fn levelize(g: &WeightedGraph, s: usize, t: usize, cap: &Vec<Vec<Weight>>, flw: &Vec<Vec<Weight>>) -> Vec<i32> {
        let n = g.len();
        let mut level = vec![-1; n];
        let mut q = VecDeque::new(); q.push_back(s);
        while let Some(u) = q.pop_front() {
            if u == t { break }
            for &(v, _) in g[u].iter() {
                if level[v] == -1 && cap[u][v] - flw[u][v] != 0 {
                    level[v] = level[u] + 1;
                    q.push_back(v);
                }
            }
        }
        level
    }

    fn augment(limit: Weight,
               level: &Vec<i32>, mut used: &mut Vec<bool>,
               g: &WeightedGraph, u: usize, t: usize,
               cap: &Vec<Vec<Weight>>, mut flw: &mut Vec<Vec<Weight>>) -> Weight {
        if u == t {
            limit
        } else if used[u] || limit == 0 {
            0
        } else {
            used[u] = true;
            for &(v, _) in g[u].iter() {
                if level[v] > level[u] {
                    let limit2 = min(limit, cap[u][v] - flw[u][v]);
                    let f = augment(limit2, &level, &mut used, &g, v, t, &cap, &mut flw);
                    if f > 0 {
                        flw[u][v] += f; flw[v][u] -= f;
                        used[u] = false;
                        return f;
                    }
                }
            }
            0
        }
    }

    pub fn flow(g: &WeightedGraph, s: usize, t: usize) -> Weight {

        let n = g.len();

        let mut cap = vec![vec![0; n]; n];
        let mut flw = vec![vec![0; n]; n];
        for u in 0..n { for &(v, w) in g[u].iter() { cap[u][v] = w; } }

        let inf = Weight::max_value() / 8;
        let mut sum = 0;
        while true {
            let level = levelize(&g, s, t, &cap, &flw);
            if level[t] == -1 { break }
            let mut used = vec![false; n];
            sum += augment(inf, &level, &mut used, &g, s, t, &cap, &mut flw);
        }
        sum
    }
}

fn main() {
    let mut sc = Scanner::new();
    let n: usize = sc.cin();
    let m: usize = sc.cin();
    let mut g: Dinic::WeightedGraph = vec![vec![]; n];
    for _ in 0..m {
        let u = sc.cin::<usize>() - 1;
        let v = sc.cin::<usize>() - 1;
        let w: Dinic::Weight = sc.cin();
        g[u].push((v, w));
    }
    trace!( Dinic::flow(&g, 0, n - 1) );
}

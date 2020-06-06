/// Graph - Tree - Diameter
fn diameter(tree: &Vec<Vec<usize>>) -> usize {
    let n = tree.len();
    let mut s = 0;
    let mut maxd = 0;
    for _ in 0..2 {
        let mut memo = vec![n * 10; n];
        memo[s] = 0;
        let mut q = std::collections::BinaryHeap::new();
        q.push((0, s));
        while let Some((_, u)) = q.pop() {
            for &v in tree[u].iter() {
                if memo[v] > memo[u] + 1 {
                    memo[v] = memo[u] + 1;
                    let priority = - (memo[v] as i32);
                    q.push((priority, v));
                }
            }
        }
        s = (0..n).map(|i| (memo[i], i)).max().unwrap().1;
        maxd = *memo.iter().max().unwrap();
    }
    maxd
}

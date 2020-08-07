/// Graph - Warshall-Floyd Algorithm
// @algebra.hyper.rs
fn wall<X: Group + PartialOrd>(d: &mut Vec<Vec<Hyper<X>>>) {
    let n = d.len();
    for k in 0..n {
        for i in 0..n {
            for j in 0..n {
                d[i][j] = min!(d[i][j], d[i][k] + d[k][j]);
            }
        }
    }
}

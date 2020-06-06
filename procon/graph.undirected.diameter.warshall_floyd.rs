fn diameter(n: usize, g: &Vec<Vec<usize>>) -> usize {
    let mut d = vec![vec![n * 2 + 1; n]; n];
    for i in 0..n { d[i][i] = 0 }
    for i in 0..n { for &j in g[i].iter() { d[i][j] = 1; }}
    for k in 0..n {
        for i in 0..n {
            for j in 0..n {
                d[i][j] = min!(d[i][j], d[i][k] + d[k][j]);
            }
        }
    }
    let mut dia = 0;
    for i in 0..n { for j in 0..i { dia = max!(dia, d[i][j]); }}
    dia
}

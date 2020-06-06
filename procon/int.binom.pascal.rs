/// Binomial Coefficient - Pascal's Triangle
fn pascal_triagle(n: usize) -> Vec<Vec<u64>> {
    let mut binom = vec![vec![0; n + 1]; n + 1];
    for i in 1..n + 1 {
        for j in 0..i + 1 {
            binom[i][j] = {
                if i == 1 || j == 0 {
                    1
                } else if j + j > i {
                    binom[i][i - j]
                } else {
                    binom[i - 1][j] + binom[i - 1][j - 1]
                }
            };
        }
    }
    binom
}

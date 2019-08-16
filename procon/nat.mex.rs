fn mex(xs: &Vec<usize>) -> usize {
    let mut memo = vec![false; xs.len() + 1];
    for &x in xs.iter() { memo[x] = true; }
    memo.iter().take_while(|&&b| b).count()
}

/// String Search - Z Algorithm
fn z(s: &str) -> Vec<usize> {
    let s: Vec<char> = s.chars().collect();
    let n = s.len();
    let mut z = vec![0; n];
    z[0] = n;
    let mut i = 1;
    let mut j = 0;
    while i < n {
        while i + j < n && s[j] == s[i + j] { j += 1 }
        if j == 0 { i += 1; continue }
        z[i] = j;
        let mut k = 1;
        while i + k < n && k + z[k] < j {
            z[i + k] = z[k];
            k += 1;
        }
        i += k;
        j -= k;
    }
    z
}

fn z_search(s: &str, pattern: &str) -> Option<usize> {
    let m = pattern.len();
    let t = pattern.to_string() + ";$" + s;
    let table = z(&t);
    for i in 0..s.len() {
        if table[i + m + 2] == m { return Some(i) }
    }
    None
}

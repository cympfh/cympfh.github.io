/// String Serach - Shift-And Algorithm
fn shift_and(text: &String, pattern: &String) -> Option<usize> {
    let text_chars = text.chars().map(|c| c as usize).collect::<Vec<_>>();
    let pattern_chars = pattern.chars().map(|c| c as usize).collect::<Vec<_>>();
    let n = text.len();
    let m = pattern.len();
    let g = 1 << (m - 1);

    let mut d = [0; 300];
    for i in 0..m { d[pattern_chars[i]] ^= 1 << i }

    let mut x: usize = 0;
    for i in 0..n {
        x = (1 | (x << 1)) & d[text_chars[i]];
        if x & g > 0 { return Some(i+1-m) }
    }
    return None
}

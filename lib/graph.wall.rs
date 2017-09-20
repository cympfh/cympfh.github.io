use std::cmp::min;
fn wall(d: &mut Vec<Vec<i32>>) {
    let n = d.len();
    for k in 0..n {
        for i in 0..n {
            for j in 0..n {
                d[i][j] = min::<i32>(
                    d[i][j],
                    d[i][k] + d[k][j]
                );
            }
        }
    }
}

fn main() {
    let mut d = vec![
        vec![0, 1, 1],
        vec![1, 0, 1],
        vec![4, 2, 0]
    ];
    wall(&mut d);
    println!("{:?}", d);
}

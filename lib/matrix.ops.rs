type K = f64;
type Matrix = Vec<Vec<K>>;

fn eye(n: usize) -> Matrix {
    let mut e: Matrix = vec![vec![0.0; n]; n];
    for i in 0..n { e[i][i] = 1.0; }
    e
}

fn scalar_multiply(a: &Matrix, k: K) -> Matrix {
    (*a).iter().map(|row| row.iter().map(|x| x*k).collect()).collect()
}

fn multiply(a: &Matrix, b: &Matrix) -> Matrix {
    let n = a.len();
    let mut c: Matrix = vec![vec![0.0; n]; n];
    for i in 0..n {
        for j in 0..n {
            for k in 0..n {
                c[i][j] += a[i][k] * b[k][j];
            }
        }
    }
    c
}

fn pow(a: &Matrix, n: usize) -> Matrix {
    if n == 0 {
        eye(n)
    } else if n == 1 {
        a.clone()
    } else if n % 2 == 0 {
        let b = multiply(a, a);
        pow(&b, n / 2)
    } else {
        let b = multiply(a, a);
        let c = pow(&b, (n - 1) / 2);
        multiply(&c, a)
    }
}

fn add(a: &Matrix, b: &Matrix) -> Matrix {
    let n = a.len();
    let m = a[0].len();
    (0..n).map(|i| (0..m).map(|j| a[i][j] + b[i][j]).collect()).collect()
}

fn main() {
    let a: Matrix = eye(2);
    let b: Matrix = scalar_multiply(&a, 2.0);
    assert!(add(&a, &a) == b);
    assert!(pow(&a, 10) == a);
    assert!(pow(&b, 10) == scalar_multiply(&a, 1024.0));
}

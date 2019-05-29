use std::ops::{Add, Mul};
use std::f64;
type K = f64;

#[derive(Debug, Clone, PartialEq)]
struct Matrix { data: Vec<Vec<K>> }

#[allow(dead_code)]
impl Matrix {
    fn new(data: &Vec<Vec<K>>) -> Matrix {
        Matrix {data: data.clone()}
    }
    fn eye(n: usize) -> Matrix {
        let mut e = vec![vec![0.0; n]; n];
        for i in 0..n { e[i][i] = 1.0; }
        Matrix::new(&e)
    }
    fn zero(h: usize, w: usize) -> Matrix {
        Matrix::new(&vec![vec![0.0; w]; h])
    }
    fn scalar_mul(&self, k: K) -> Matrix {
        let (h, w) = (self.data.len(), self.data[0].len());
        let data: Vec<Vec<K>> =
            (0..h).map(|i| (0..w).map(|j| k * self.data[i][j]).collect()).collect();
        Matrix::new(&data)
    }
    fn pow(&self, n: usize) -> Matrix {
        if n == 0 {
            Matrix::eye(self.data.len())
        } else if n == 1 {
            self.clone()
        } else if n % 2 == 0 {
            let m = self * self;
            m.pow(n / 2)
        } else {
            let m = self * self;
            &m.pow(n / 2) * self
        }
    }
}

impl<'t> Add<&'t Matrix> for &'t Matrix {
    type Output = Matrix;
    fn add(self, right: &'t Matrix) -> Matrix {
        let (h, w) = (self.data.len(), self.data[0].len());
        let data: Vec<Vec<K>> =
            (0..h).map(|i| (0..w).map(|j| self.data[i][j] + right.data[i][j]).collect()).collect();
        Matrix::new(&data)
    }
}

impl<'t> Mul<&'t Matrix> for &'t Matrix {
    type Output = Matrix;
    fn mul(self, right: &'t Matrix) -> Matrix {
        let (h, w, v) = (self.data.len(), right.data.len(), right.data[0].len());
        let data: Vec<Vec<K>> =
            (0..h).map(|i| (0..v).map(|k| (0..w).map(|j| self.data[i][j] * right.data[j][k]).sum()).collect())
                  .collect();
        Matrix::new(&data)
    }
}

impl<'t> Mul<&'t Matrix> for K {
    type Output = Matrix;
    fn mul(self, m: &'t Matrix) -> Matrix {
        m.scalar_mul(self)
    }
}

impl<'t> Mul<K> for &'t Matrix {
    type Output = Matrix;
    fn mul(self, k: K) -> Matrix {
        self.scalar_mul(k)
    }
}

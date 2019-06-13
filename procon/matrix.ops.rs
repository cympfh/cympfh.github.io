use std::ops::{Add, Sub, Mul, Neg};
use std::iter::Sum;

#[derive(Debug, Clone, PartialEq)]
struct Matrix<K> { data: Vec<Vec<K>> }

trait MatrixElement: Add<Output=Self> + Mul<Output=Self> + Neg<Output=Self> + Sum + Clone + Copy
{
    fn zero() -> Self;
    fn one() -> Self;
}

macro_rules! impl_matrix {
    ($t:tt, $zero:expr, $one:expr) => {
        impl MatrixElement for $t {
            fn zero() -> Self { $zero }
            fn one() -> Self { $one }
        }
    }
}
impl_matrix!(i64, 0, 1);
impl_matrix!(i32, 0, 1);
impl_matrix!(f64, 0., 1.);
impl_matrix!(f32, 0., 1.);

macro_rules! mat {
    ( $( $( $x:expr )* );* ) => ( Matrix::new( vec![ $( vec![ $( $x ),* ] ),* ] ) )
}

impl<K: MatrixElement> Matrix<K>
{
    fn new(data: Vec<Vec<K>>) -> Matrix<K> {
        Matrix {data: data}
    }
    fn size(&self) -> (usize, usize) {
        (self.data.len(), self.data[0].len())
    }
    fn eye(n: usize) -> Matrix<K> {
        let mut e = vec![vec![K::zero(); n]; n];
        for i in 0..n { e[i][i] = K::one(); }
        Matrix::new(e)
    }
    fn zero(h: usize, w: usize) -> Matrix<K> {
        Matrix::new(vec![vec![K::zero(); w]; h])
    }
    fn scalar_mul(&self, k: K) -> Matrix<K> {
        let (h, w) = (self.data.len(), self.data[0].len());
        let data: Vec<Vec<K>> =
            (0..h).map(|i| (0..w).map(|j| k * self.data[i][j]).collect()).collect();
        Matrix::new(data)
    }
    fn pow(&self, n: usize) -> Matrix<K> {
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

// -M
impl<K: MatrixElement> Neg for &Matrix<K>
{
    type Output = Matrix<K>;
    fn neg(self) -> Matrix<K> {
        let data = self.data.iter().map(|row| row.iter().map(|&x| -x).collect()).collect();
        Matrix::new(data)
    }
}

// M + N
impl<K: MatrixElement> Add<&Matrix<K>> for &Matrix<K> {
    type Output = Matrix<K>;
    fn add(self, other: &Matrix<K>) -> Matrix<K> {
        let (h, w) = self.size();
        let data = (0..h).map(|i| (0..w).map(|j| self.data[i][j] + other.data[i][j]).collect()).collect();
        Matrix::new(data)
    }
}

// M - N
impl<K: MatrixElement> Sub<&Matrix<K>> for &Matrix<K> {
    type Output = Matrix<K>;
    fn sub(self, other: &Matrix<K>) -> Matrix<K> {
        self + &-other
    }
}

// M * N
impl<K: MatrixElement> Mul<&Matrix<K>> for &Matrix<K> {
    type Output = Matrix<K>;
    fn mul(self, other: &Matrix<K>) -> Matrix<K> {
        let (h, w, v) = (self.data.len(), other.data.len(), other.data[0].len());
        let data =
            (0..h).map(|i| (0..v).map(|k| (0..w).map(|j| self.data[i][j] * other.data[j][k]).sum()).collect())
                  .collect();
        Matrix::new(data)
    }
}

// M * k
impl<K: MatrixElement> Mul<K> for &Matrix<K> {
    type Output = Matrix<K>;
    fn mul(self, k: K) -> Matrix<K> {
        self.scalar_mul(k)
    }
}

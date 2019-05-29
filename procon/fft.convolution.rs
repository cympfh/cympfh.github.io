struct FFT;

impl FFT {

    fn _fft(f: &Vec<Complex>, dir: K) -> Vec<Complex> {
        let n = f.len();
        if n < 2 { return f.clone() }
        let f0: Vec<Complex> = (0..n/2).map(|i| f[i*2].clone()).collect();
        let f1: Vec<Complex> = (0..n/2).map(|i| f[i*2+1].clone()).collect();
        let g0 = FFT::_fft(&f0, dir);
        let g1 = FFT::_fft(&f1, dir);
        let pi = (-1.0 as K).acos();
        let theta = 2.0 * pi / (n as K);
        let z = Complex(theta.cos(), theta.sin() * dir);
        let mut ac = Complex::unit();
        let mut g = vec![];
        for i in 0..n {
            g.push(&g0[i % (n/2)] + &(&ac * &g1[i % (n/2)]));
            ac = &z * &ac;
        }
        g
    }
    fn fft(f: &Vec<Complex>) -> Vec<Complex> { FFT::_fft(f, 1.0) }
    fn defft(f: &Vec<Complex>) -> Vec<Complex> { FFT::_fft(f, -1.0) }

    fn _convolution(x: &Vec<Complex>, y: &Vec<Complex>) -> Vec<Complex> {
        let m = x.len();
        let xh = FFT::fft(&x);
        let yh = FFT::fft(&y);
        let xyh = (0..m).map(|i| &(&xh[i] * &yh[i]) * (1.0 / m as K)).collect();
        FFT::defft(&xyh)
    }

    fn convolution(f: &Vec<K>, g: &Vec<K>) -> Vec<K> {
        let n = max(f.len(), g.len());
        let mut m = 1; while m < n { m <<= 1 }; m <<= 1; // length should be 2**pow
        let x: Vec<Complex> =
            f.iter().map(|&k| Complex(k, 0.0)).chain(
                (0..m - f.len()).map(|_| Complex(0.0, 0.0))).collect();
        let y: Vec<Complex> =
            g.iter().map(|&k| Complex(k, 0.0)).chain(
                (0..m - g.len()).map(|_| Complex(0.0, 0.0))).collect();

        let z = FFT::_convolution(&x, &y);
        z.iter().map(|c| c.0).collect()
    }
}

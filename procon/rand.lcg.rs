/// Random - Linear Congruential Generators
struct Rand(u64);
impl Rand {
    fn next(&mut self) -> u64 {
        let a = 1000000007;
        let b = 127;
        let m = 1 << 20;
        self.0 = (self.0 * a + b) % m;
        self.0
    }
}

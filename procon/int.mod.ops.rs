#[derive(Debug, PartialEq, Eq, Clone, Copy)]
struct ModInt { res: i64, md: i64 }

impl ModInt {
    fn new(res: i64, md: i64) -> Self {
        ModInt { res, md }
    }
    fn inv(self) -> Self {
        fn exgcd(r0: i64, a0: i64, b0: i64, r: i64, a: i64, b: i64)
                -> (i64, i64, i64) {
            if r > 0 {
                exgcd(r, a, b, r0 % r, a0 - r0 / r * a, b0 - r0 / r * b)
            } else {
                (a0, b0, r0)
            }
        }
        let (a, _, r) = exgcd(self.res, 1, 0, self.md, 0, 1);
        if r != 1 { panic!("{:?} has no inverse!", self); }
        ModInt::new(((a % self.md) + self.md) % self.md, self.md)
    }
    fn pow(self, n: i64) -> Self {
        if n < 0 {
            self.pow(-n).inv()
        } else if n == 0 {
            ModInt::new(1, self.md)
        } else if n == 1 {
            self
        } else {
            let mut x = (self * self).pow(n / 2);
            if n % 2 == 1 { x *= self }
            x
        }
    }
}
impl std::fmt::Display for ModInt {
    fn fmt(&self, f: &mut std::fmt::Formatter) -> std::fmt::Result {
        write!(f, "{}", self.res)
    }
}
impl std::ops::Neg for ModInt {
    type Output = Self;
    fn neg(self) -> Self {
        ModInt { res: self.md - self.res, md: self.md }
    }
}
impl std::ops::Add<i64> for ModInt {
    type Output = Self;
    fn add(self, other: i64) -> Self {
        let res = if self.res + other >= self.md {
            self.res + other - self.md
        } else {
            self.res + other
        };
        ModInt { res, md: self.md }
    }
}
impl std::ops::Add for ModInt {
    type Output = Self;
    fn add(self, other: ModInt) -> Self {
        self + other.res
    }
}
impl std::ops::Add<ModInt> for i64 {
    type Output = ModInt;
    fn add(self, other: ModInt) -> ModInt {
        other + self
    }
}
impl std::ops::AddAssign<i64> for ModInt {
    fn add_assign(&mut self, other: i64) {
        if self.res + other >= self.md {
            self.res += other - self.md;
        } else {
            self.res += other;
        }
    }
}
impl std::ops::AddAssign for ModInt {
    fn add_assign(&mut self, other: ModInt) {
        *self += other.res;
    }
}
impl std::ops::Sub<i64> for ModInt {
    type Output = Self;
    fn sub(self, other: i64) -> Self {
        let res = if self.res < other {
            self.res + self.md - self.res
        } else {
            self.res - other
        };
        ModInt { res, md: self.md }
    }
}
impl std::ops::Sub for ModInt {
    type Output = Self;
    fn sub(self, other: ModInt) -> Self {
        self - other.res
    }
}
impl std::ops::Sub<ModInt> for i64 {
    type Output = ModInt;
    fn sub(self, other: ModInt) -> ModInt {
        -other + self
    }
}
impl std::ops::SubAssign<i64> for ModInt {
    fn sub_assign(&mut self, other: i64) {
        if self.res < other {
            self.res = self.res - other + self.md;
        } else {
            self.res -= other;
        }
    }
}
impl std::ops::SubAssign for ModInt {
    fn sub_assign(&mut self, other: ModInt) {
        *self -= other.res;
    }
}
impl std::ops::Mul<i64> for ModInt {
    type Output = Self;
    fn mul(self, other: i64) -> Self {
        ModInt { res: (self.res * other) % self.md, md: self.md }
    }
}
impl std::ops::Mul for ModInt {
    type Output = Self;
    fn mul(self, other: ModInt) -> Self {
        self * other.res
    }
}
impl std::ops::Mul<ModInt> for i64 {
    type Output = ModInt;
    fn mul(self, other: ModInt) -> ModInt {
        other * self
    }
}
impl std::ops::MulAssign<i64> for ModInt {
    fn mul_assign(&mut self, other: i64) {
        self.res = (self.res * other) % self.md;
    }
}
impl std::ops::MulAssign for ModInt {
    fn mul_assign(&mut self, other: ModInt) {
        *self *= other.res;
    }
}
impl std::ops::Div<i64> for ModInt {
    type Output = Self;
    fn div(self, other: i64) -> Self {
        self * ModInt::new(other, self.md).inv()
    }
}
impl std::ops::Div for ModInt {
    type Output = Self;
    fn div(self, other: ModInt) -> Self {
        self * other.inv()
    }
}
impl std::ops::Div<ModInt> for i64 {
    type Output = ModInt;
    fn div(self, other: ModInt) -> ModInt {
        other.inv() * self
    }
}
impl std::ops::DivAssign for ModInt {
    fn div_assign(&mut self, other: ModInt) {
        self.res = (self.res * other.inv().res) % self.md;
    }
}
impl std::ops::DivAssign<i64> for ModInt {
    fn div_assign(&mut self, other: i64) {
        *self /= ModInt::new(other, self.md);
    }
}

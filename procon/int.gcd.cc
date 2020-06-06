__gcd(int, int) ;

template<Int=int>
Int gcd(Int a, Int b) {
  if (b == 0) return a;
  return gcd(b, a%b);
}

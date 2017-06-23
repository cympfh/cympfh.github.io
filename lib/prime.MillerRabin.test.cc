bool isprime(int n) { // naiive
  if (n<2) return false;
  for (int i = 2; i*i <= n; ++i)
    if (n % i == 0) return false;
  return true;
}

int main() {
  const int M = 10000;
  for (int i = 0; i < M; ++i) {
    if(isprime(i) != Prime::test(i)) {
      cout << i << ' ' << isprime(i) << ' ' << Prime::test(i) << endl;
      return 1;
    }
  }
  return 0;
}

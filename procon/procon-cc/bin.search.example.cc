int int_root(int a) {
  auto f = [&](int x) { return x * x - a; };
  return bsearch(0, a, f);
}

int main() {
  cout << int_root(99) << endl; // 9
  cout << int_root(100) << endl; // 10
  cout << int_root(101) << endl; // 10
}

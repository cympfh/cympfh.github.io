namespace derangement { // !n
  size_t sz = 10000000;
  vector<long long> table;
  bool initialized = false;
  long long at(size_t n) {
    if (not initialized) {
      table.resize(sz);
      table[1] = 0; table[2] = 1;
      for (size_t i = 3; i < sz; ++i) {
        table[i] = (i-1) * (table[i-1] + table[i-2]);
      }
      initialized = true;
    }
    return table[n];
  }
};


int main() {

  for (size_t i = 1; i <= 10; ++i)
    cout << derangement::at(i) << endl;

  return 0;
}

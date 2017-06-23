
using vi = vector<int>;
using vvi = vector<vi>;
int main() {

  /*
   * 0 -> 1
   * 0 -> 2
   * 1 -> 3
   * 2 -> 4
   * 3 -> 4
   */
  vvi d = {
    { 1, 2 },
    { 3 },
    { 4 },
    { 4 },
    {}
  };
  Topological t(d);
  cout << t.L << endl;

  return 0;
}

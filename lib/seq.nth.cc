#include<algorithm>

int main() {

  std::vector<int> xs { 1, 2, 2, 2, 3, 4, 5, 5 };
  //                    0  1  2  3  4  5  6  7

  int n = 4;
  auto pos = begin(xs) + n;

  // std::nth_element(Iter, Iter, Iter);
  // 自身を書き換えるので註意
  std::nth_element(begin(xs), pos, end(xs));

  std::cout << n << "-th element is " << *pos << std::endl;
  // 4-th element is 3

}

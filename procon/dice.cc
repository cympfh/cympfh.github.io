constexpr int dice_lines[][4] = {
  {2,3,5,4},
  {1,4,6,3},
  {1,2,6,5}
};

enum Face {
  U, D, L, R, F, B
};

struct Dice {
  int get_right(int u, int f) {
    if (u > 3) {
      return 7 - get_right(7 - u, f);
    }
    const int *line;
    if (u == 1) line = dice_lines[0];
    if (u == 2) line = dice_lines[1];
    if (u == 3) line = dice_lines[2];
    for (int i = 0; i < 4; ++i) {
      if (line[i] == f) return line[-~i % 4];
    }
    assert(false);
  }

  int up; int down;
  int left; int right;
  int front; int back;
  Dice (int u, int f) : up(u), front(f) {
    assert(1 <= u && u <= 6);
    assert(1 <= f && f <= 6);
    assert(u != f);
    assert(u + f != 7);
    right = get_right(u, f);
    left = 7 - right;
    down = 7 - up;
    back = 7 - front;
  }

  void roll(Face f) {
    if (f == U) return;
    if (f == D) return;

    if (f == R) { // roll to right
      int tmp = up;
      up = left;
      left = down;
      down = right;
      right = tmp;
    } else if (f == L) {
      int tmp = up;
      up = right;
      right = down;
      down = left;
      left = tmp;
    } else if (f == F) {
      int tmp = up;
      up = back;
      back = down;
      down = front;
      front = tmp;
    } else if (f == B) {
      int tmp = up;
      up = front;
      front = down;
      down = back;
      back = tmp;
    }
    assert(up + down == 7);
    assert(left + right == 7);
    assert(front + back == 7);
  }

};

ostream& operator<<(ostream& os, Dice d) {
  os << "(dice "
     << d.up << ' '
     << d.front << ' '
     << d.right << ' '
     << d.down << ' '
     << d.back << ' '
     << d.left << ")" << endl;
  return os;
}


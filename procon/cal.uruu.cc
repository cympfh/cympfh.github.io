bool is_uruu(int y) {
  return y % 4 == 0 and y % 100 != 0 or y % 400 == 0;
}

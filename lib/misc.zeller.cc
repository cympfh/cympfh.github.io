enum Day {
  Sat = 0,
  Sun = 1,
  Mon, Tue, Wed, Thu, Fri
};

Day zeller(int y, int m, int d) {
  if (m == 1 || m == 2) {
    --y; m += 12;
  }
  int Y = y % 100;
  int c = y / 100;
  int gamma = 5 * c + c / 4; // Gregorian (1582 <= y)
  //int gamma = 6 * c + 5; // Julian (4 <= y <= 1582)
  int h = d + int(26 * (m+1) / 10)
    + Y + Y / 4 + gamma;
  h %= 7;
  return Day(h);
}

string show_day (Day a) {
  switch (a) {
    case Mon: return "Monday";
    case Tue: return "Tuesday";
    case Wed: return "Wednesday";
    case Thu: return "Thursday";
    case Fri: return "Friday";
    case Sat: return "Saturday";
    case Sun: return "Sunday";
    default: return "Holiday";
  }
}

int main() {
  cout << (Fri == zeller(2014, 11,28)) << endl;
  cout << (Tue == zeller(1990, 11, 6)) << endl;
  return 0;
}

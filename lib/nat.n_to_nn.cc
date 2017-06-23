template<typename Nat=int>
pair<Nat, Nat> n2nn(Nat a) {
  int i = 0;
  while (a > i) a -= ++i;
  return make_pair(a, i-a);
}


struct edge {
  int from, to, cost;
  edge(int f,int t,int c) { from=f; to=t; cost=c; }
};

bool operator< (const edge& left, const edge& right) {
  return left.cost < right.cost;
}
bool operator> (const edge& left, const edge& right) {
  return left.cost > right.cost;
}

ostream& operator<<(ostream& os, const edge& e) {
  os<<"(edge "<<e.from<<' '<<e.to<<' '<<e.cost<<')';
  return os;
}


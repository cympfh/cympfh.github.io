/*
 * sort | uniq
 *
 * ただの std::unique は size を切り詰めてくれないので注意
 */

sort(begin(xs), end(xs));
xs.erase(std::unique(xs.begin(), xs.end()), xs.end());

template<typename T>
inline
void uniq(vector<T>& xs) {
  sort(begin(xs), end(xs));
  xs.erase(std::unique(xs.begin(), xs.end()), xs.end());
}

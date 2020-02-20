/// Algebra - Totalize PartialOrd
/// Thanks to: https://qiita.com/hatoo@github/items/fa14ad36a1b568d14f3e
#[derive(Copy, Clone, Debug, PartialEq, PartialOrd)]
struct Total<T>(T);
impl<T: PartialEq> Eq for Total<T> {}
impl<T: PartialOrd> Ord for Total<T> {
    fn cmp(&self, rhs: &Total<T>) -> std::cmp::Ordering {
        self.0.partial_cmp(&rhs.0).unwrap()
    }
}

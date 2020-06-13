#[derive(Debug, Clone)]
struct DefaultMap<S, T> {
    data: std::collections::HashMap<S, T>,
    default: T,
}
impl<S: Eq + std::hash::Hash, T> DefaultMap<S, T> {
    fn new(default: T) -> DefaultMap<S, T> {
        DefaultMap {
            data: std::collections::HashMap::new(),
            default,
        }
    }
    fn keys(&self) -> std::collections::hash_map::Keys<S, T> {
        self.data.keys()
    }
    fn iter(&self) -> std::collections::hash_map::Iter<S, T> {
        self.data.iter()
    }
    fn len(&self) -> usize {
        self.data.len()
    }
}
impl<S: Eq + std::hash::Hash, T> std::ops::Index<S> for DefaultMap<S, T> {
    type Output = T;
    fn index(&self, key: S) -> &Self::Output {
        if let Some(val) = self.data.get(&key) {
            val
        } else {
            &self.default
        }
    }
}
impl<S: Eq + std::hash::Hash + Clone, T: Clone> std::ops::IndexMut<S> for DefaultMap<S, T> {
    fn index_mut(&mut self, key: S) -> &mut Self::Output {
        let val = self.default.clone();
        self.data.entry(key.clone()).or_insert(val);
        self.data.get_mut(&key).unwrap()
    }
}

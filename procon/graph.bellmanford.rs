struct BellmanFord;

#[derive(Debug, PartialOrd, Ord, PartialEq, Eq, Clone, Copy)]
enum Cost {
    MinusInfinity,
    Value(i64),
    Infinity,
}

use std::ops::Add;
impl Add for Cost {
    type Output = Cost;
    fn add(self, other: Cost) -> Cost {
        use Cost::{MinusInfinity, Value, Infinity};
        match (self, other) {
            (Infinity, _) => Infinity,
            (_, Infinity) => Infinity,
            (Value(x), Value(y)) => Value(x + y),
            _ => MinusInfinity
        }
    }
}

#[derive(Debug, PartialOrd, Ord, PartialEq, Eq, Clone, Copy)]
struct CostedEdge(usize, usize, Cost);

impl BellmanFord {
    fn yen(edges: &Vec<CostedEdge>) -> Vec<CostedEdge> {
        let mut edges_f = vec![];
        let mut edges_b = vec![];
        for &CostedEdge(i, j, c) in edges.iter() {
            if i <= j {
                edges_f.push(CostedEdge(i, j, c));
            } else {
                edges_b.push(CostedEdge(i, j, c));
            }
        }
        edges_f.sort();
        edges_b.sort();
        edges_b.reverse();
        edges_f.iter().chain(edges_b.iter()).map(|&p| p).collect()
    }
    fn shortest(n: usize, edges: &Vec<CostedEdge>, s: usize, t: usize) -> Cost {
        let mut dist = vec![Cost::Infinity; n];
        dist[s] = Cost::Value(0);
        for _ in 1..n {
            for &CostedEdge(i, j, c) in edges.iter() {
                if dist[j] > dist[i] + c {
                    dist[j] = dist[i] + c;
                }
            }
        }
        for &CostedEdge(i, j, c) in edges.iter() {
            if dist[i] + c < dist[j] {
                dist[i] = Cost::MinusInfinity
                // return Cost::MinusInfinity
            }
        }
        for _ in 1..n {
            for &CostedEdge(i, j, c) in edges.iter() {
                if dist[j] > dist[i] + c {
                    dist[j] = dist[i] + c;
                }
            }
        }
        dist[t]
    }
}

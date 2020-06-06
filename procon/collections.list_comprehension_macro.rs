macro_rules! list {
    ($($t:tt)*) => {{ let mut r = vec![]; list_inner!(r, $($t)*); r }}
}
macro_rules! list_inner {
    ($r:expr) => {};
    ($r:expr, $e:expr) => { $r.push($e) };
    ($r:expr, $e:expr;) => { $r.push($e) };
    ($r:expr, $e:expr; for $k:ident in $range:expr) => { for $k in $range { list_inner!($r, $e) } };
    ($r:expr, $e:expr; if $cond:expr) => { if $cond { list_inner!($r, $e) } };
    ($r:expr, $e:expr; for $k:ident in $range:expr ; $($t:tt)*) => { for $k in $range { list_inner!($r, $e ; $($t)*); } };
    ($r:expr, $e:expr; if $cond:expr ; $($t:tt)*) => { if $cond { list_inner!($r, $e ; $($t)*); } };
}

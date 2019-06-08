# geo.2d.ccw

## [geo.2d.ccw.rs](geo.2d.ccw.rs)

@[rust](geo.2d.ccw.rs)

```rust
fn main() {

    let p = Point(1.0, 2.0);
    let q = Point(2.0, 0.0);
    let l = Line(p, q);

    trace!(ccw(l, p)); // ON
    trace!(ccw(l, q)); // ON
    trace!(ccw(l, Point(1.5, 1.0))); // ON
    trace!(ccw(l, Point(3.0, -2.0))); // FRONT
    trace!(ccw(l, Point(0.0, 4.0))); // BACK
    trace!(ccw(l, Point(0.0, 0.0))); // RIGHT
    trace!(ccw(l, Point(10.0, 0.0))); // LEFT

}
```

## [geo.2d.ccw.cc](geo.2d.ccw.cc)

@[cpp](geo.2d.ccw.cc)

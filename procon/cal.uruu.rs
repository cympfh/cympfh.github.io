fn is_uruu(y: usize) -> bool {
    y % 4 == 0 && y % 100 != 0 || y % 400 == 0
}

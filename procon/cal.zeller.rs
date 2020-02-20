/// Calendar - Zeller's Theorem
#[derive(Debug)]
enum Day {
  Sat, Sun, Mon, Tue, Wed, Thu, Fri
}
impl Day {
    fn from(i: usize) -> Day {
        match i {
            0 => Day::Sat,
            1 => Day::Sun,
            2 => Day::Mon,
            3 => Day::Tue,
            4 => Day::Wed,
            5 => Day::Thu,
            6 => Day::Fri,
            _ => panic!("no day")
        }
    }
}
impl std::fmt::Display for Day {
    fn fmt(&self, f: &mut std::fmt::Formatter) -> std::fmt::Result {
        write!(f, "{}",
            match self {
                Day::Sat => "Saturday",
                Day::Sun => "Sunday",
                Day::Mon => "Monday",
                Day::Tue => "Tuesday",
                Day::Wed => "Wednesday",
                Day::Thu => "Thursday",
                Day::Fri => "Friday"
            })
    }
}

fn zeller(y: usize, m: usize, d: usize) -> Day {
    assert!(m >= 1 && d >= 1);
    let (year, month) = if m <= 2 {
        (y - 1, m + 12)
    } else {
        (y, m)
    };
    let y_up = year % 100;
    let y_down = year / 100;
    let gamma;
    // Gregorian if (1582 <= y)
    {
        gamma = 5 * y_down + y_down / 4;
    }
    // Julian if 4 <= y && y <= 1582
    // {
    //     gamma = 6 * c + 5;
    // };
    let h = d + (26 * (month + 1) / 10) + y_up + y_up / 4 + gamma;
    Day::from(h % 7)
}

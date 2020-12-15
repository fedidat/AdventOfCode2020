use std::fs;
use core::fmt;
use std::collections::HashSet;

#[derive(Copy, Clone, Debug, PartialEq)]
struct Seat {
    row: usize,
    col: usize,
}

impl Seat {
    fn from(pass: &str) -> Self {
        Seat {
            row: Self::translate_binary(pass.clone(), 0, 7, "F", "B"),
            col: Self::translate_binary(pass.clone(), 7, 10, "L", "R")}
    }
    pub fn new(row: usize, col: usize) -> Self {
        Seat { row: row, col: col }
    }
    fn translate_binary(pass: &str, start: usize, end: usize, low_symbol: &str, high_symbol: &str) -> usize {
        let sub: String = pass.chars().skip(start).take(end-start).collect::<String>()
            .replace(low_symbol, "0").replace(high_symbol, "1");
        return isize::from_str_radix(sub.as_str(), 2).unwrap() as usize;
    }
    fn id(self) -> usize {
        return 8 * self.row + self.col;
    }
}
impl fmt::Display for Seat {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        write!(f, "Seat row {} column {}, ID {}", self.row, self.col, self.id())
    }
}

fn part1() -> usize {
    let input = fs::read_to_string("input/Day05.txt").expect("Could not read file");
    let seats: Vec<Seat> = input.split("\n")
        .map(|pass| Seat::from(pass))
        .collect();

    let ids: HashSet<usize> = seats.iter()
        .map(|seat| seat.id())
        .collect();
    let max_id: usize = *ids.iter()
        .max().unwrap();
    return max_id; //835
}

fn part2() -> usize {
    let input = fs::read_to_string("input/Day05.txt").expect("Could not read file");
    let seats: Vec<Seat> = input.split("\n")
        .map(|pass| Seat::from(pass))
        .collect();

    let ids: HashSet<usize> = seats.iter()
        .map(|seat| seat.id())
        .collect();
    let max_id: usize = *ids.iter()
        .max().unwrap();
    let min_id: usize = *ids.iter()
        .min().unwrap();
    for id in min_id+1..max_id {
        if !ids.contains(&id) && ids.contains(&(id-1)) && ids.contains(&(id+1)) {
            return id; //649
        }
    }
    panic!("Could not find missing seat");
}

fn main() {
    println!("Part 1 result: {}", part1());
    println!("Part 2 result: {}", part2());
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn samples() {
        assert_eq!(Seat::from("BFFFBBFRRR"), Seat::new(70, 7)); // row 70, column 7, seat ID 567.
        assert_eq!(Seat::from("BFFFBBFRRR").id(), 567);
        assert_eq!(Seat::from("FFFBBBFRRR"), Seat::new(14, 7)); // row 14, column 7, seat ID 119.
        assert_eq!(Seat::from("FFFBBBFRRR").id(), 119); // row 70, column 7, seat ID 567.
        assert_eq!(Seat::from("BBFFBBFRLL"), Seat::new(102, 4)); // row 102, column 4, seat ID 820.
        assert_eq!(Seat::from("BBFFBBFRLL").id(), 820);
    }

    #[test]
    fn part1_expected() {
        assert_eq!(part1(), 835);
    }

    #[test]
    fn part2_expected() {
        assert_eq!(part2(), 649);
    }
}
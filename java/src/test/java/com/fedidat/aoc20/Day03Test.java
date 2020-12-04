package com.fedidat.aoc20;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

class Day03Test {
    private static final Day03 SOLUTION = new Day03();
    private static final String SAMPLE_INPUT = """
            ..##.......
            #...#...#..
            .#....#..#.
            ..#.#...#.#
            .#...##..#.
            ..#.##.....
            .#.#.#....#
            .#........#
            #.##...#...
            #...##....#
            .#..#...#.#""";
    private static final String[] REAL_INPUT = Utils.getResourceInput("Day03.txt").split("\n");

    @Test
    void part1_sample() {
        assertEquals(7, SOLUTION.part1_solve(SAMPLE_INPUT.split("\n")));
    }
    @Test
    void part1() {
        assertEquals(240, SOLUTION.part1_solve(REAL_INPUT));
    }

    @Test
    void part2_sample() {
        assertEquals(336, SOLUTION.part2_solve(SAMPLE_INPUT.split("\n")));
    }
    @Test
    void part2() {
        assertEquals(2832009600L, SOLUTION.part2_solve(REAL_INPUT));
    }
}
package com.fedidat.aoc20;

import lombok.Data;

import java.util.stream.Stream;

public class Day03 {
    public int part1_solve(String[] grid) {
        return solve(grid, new Slope(3, 1));
    }

    public long part2_solve(String[] grid) {
        return Stream.of(
            new Slope(1, 1),
            new Slope(3, 1),
            new Slope(5, 1),
            new Slope(7, 1),
            new Slope(1, 2))
            .map(slope -> solve(grid, slope))
            .mapToLong(i -> i)
            .reduce(1, (a, b) -> a * b);
    }

    public int solve(String[] grid, Slope slope) {
        int trees = 0;
        for (int x = 0, y = 0; y < grid.length; x += slope.getX(), y += slope.getY()) {
            if (isTree(grid, x, y)) {
                trees++;
            }
        }
        return trees;
    }

    private boolean isTree(String[] grid, int x, int y) {
        return grid[y].charAt(x % grid[0].length()) == '#';
    }

    @Data(staticConstructor = "of")
    public static class Slope {
        private final int x;
        private final int y;
    }
}

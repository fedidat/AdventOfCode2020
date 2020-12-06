import { assertEquals } from "https://deno.land/std@0.79.0/testing/asserts.ts";
import { Solution } from "./day06.ts";

Deno.test("Part 1 sample", () => {
    const input = Deno.readTextFileSync("input/day06-sample.txt");
    const solution = new Solution(input);
    assertEquals(solution.part1_solve(), 11);
});

Deno.test("Part 1", () => {
    const input = Deno.readTextFileSync("input/day06.txt");
    const solution = new Solution(input);
    assertEquals(solution.part1_solve(), 6457);
});

Deno.test("Part 2 sample", () => {
    const input = Deno.readTextFileSync("input/day06-sample.txt");
    const solution = new Solution(input);
    assertEquals(solution.part2_solve(), 6);
});

Deno.test("Part 2", () => {
    const input = Deno.readTextFileSync("input/day06.txt");
    const solution = new Solution(input);
    assertEquals(solution.part2_solve(), 3260);
});
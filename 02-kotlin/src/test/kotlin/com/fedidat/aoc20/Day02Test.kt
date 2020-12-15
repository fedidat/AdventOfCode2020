package com.fedidat.aoc20

import org.assertj.core.api.Assertions.assertThat
import org.junit.jupiter.api.DisplayName
import org.junit.jupiter.api.Nested
import org.junit.jupiter.api.Test

@DisplayName("Day 2")
class Day02Test {
	val filename = "Day02.txt"

	@Nested
	@DisplayName("Part 1")
	inner class Part1 {
		@Test
		fun `Actual answer`() {
			val answer = Day02(filename).part1()
			assertThat(answer).isEqualTo(469)
		}
	}

	@Nested
	@DisplayName("Part 2")
	inner class Part2 {
		@Test
		fun `Actual answer`() {
			val answer = Day02(filename).part2()
			assertThat(answer).isEqualTo(267)
		}
	}
}
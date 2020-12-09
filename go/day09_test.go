package main

import "testing"

func TestSample(t *testing.T) {
	filename, capacity := "Day09-sample.txt", 5
	values := getValues(getFile(filename))
	invalid := part1(values, capacity)
	if invalid != 127 {
		t.Errorf("invalid value part 2 sample = %d; want 127", invalid)
	}

	weakness := part2(values, capacity, invalid)
	if weakness != 62 {
		t.Errorf("invalid value part 2 solution = %d; want 62", weakness)
	}
}

func TestSolution(t *testing.T) {
	filename, capacity := "Day09.txt", 25
	values := getValues(getFile(filename))
	invalid := part1(values, capacity)
	if invalid != 1639024365 {
		t.Errorf("invalid value part 2 sample = %d; want 1639024365", invalid)
	}

	weakness := part2(values, capacity, invalid)
	if weakness != 219202240 {
		t.Errorf("invalid value part 2 solution = %d; want 219202240", weakness)
	}
}

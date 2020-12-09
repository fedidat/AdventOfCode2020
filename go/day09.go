package main

import (
	"fmt"
	"strconv"
	"strings"
)

func getValues(input string) []int {
	lines := strings.Split(string(input), "\n")
	values := make([]int, len(lines))
	for i, s := range lines {
		values[i], _ = strconv.Atoi(s)
	}
	return values
}

func part1(values []int, lookback int) int {
	for ref := lookback; ref < len(values); ref++ {
		found := false
		for first := ref - lookback; first < ref && !found; first++ {
			for second := first + 1; second < ref && !found; second++ {
				found = (values[first]+values[second] == values[ref])
			}
		}
		if !found {
			return values[ref]
		}
	}
	panic("no invalid number")
}

func part2(values []int, lookback int, searched int) int {
	for start := 0; start < len(values); start++ {
		for end := start; end < len(values); end++ {
			subset := values[start:end]
			sum := sum(subset)
			if sum == searched {
				min, max := minMax(subset)
				return min + max
			}
		}
	}
	panic("sum not found")
}

func run(filename string, lookback int) {
	values := getValues(getFile(filename))
	invalid := part1(values, lookback)
	fmt.Printf("Part 1: invalid value is %d\n", invalid)
	weakness := part2(values, lookback, invalid)
	fmt.Printf("Part 2: weakness is %d\n", weakness)
}

func main() {
	fmt.Println("Running sample")
	run("Day09-sample.txt", 5)
	fmt.Println("Running solution")
	run("Day09.txt", 25)
}

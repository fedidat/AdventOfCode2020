package main

import "io/ioutil"

func getFile(name string) string {
	input, _ := ioutil.ReadFile(name)
	return string(input)
}

func sum(slice []int) int {
	sum := 0
	for _, v := range slice {
		sum += v
	}
	return sum
}

func minMax(slice []int) (int, int) {
	min, max := slice[0], slice[0]
	for _, value := range slice {
		if max < value {
			max = value
		}
		if min > value {
			min = value
		}
	}
	return min, max
}

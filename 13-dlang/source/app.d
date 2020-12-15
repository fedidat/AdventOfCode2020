module day13;

import std.stdio : writeln;
import std.array : split, assocArray;
import std.typecons : tuple;
import std.algorithm : filter, map, minElement, fold;
import std.conv : to;
import std.range : enumerate;

import file = std.file;

/// Part 1: earliest embarkment
int part1(string filename) {
	string[] input = file.readText(filename).split("\n");
	return input[1]									// frequency times
		.split(",")									// split by comma for individual bus lines
		.filter!(v => v != "x")						// ignore inactive lines
		.map!(v => v.to!int)						// parse int
		.map!(v => [v, v - input[0].to!int % v])	// associate each line to its ETA
		.minElement!"a[1]"							// take min tuple by ETA
		.fold!((a, b) => a * b);					// multiply
}

/// Part 1: predict requirements met
long part2(string filename) {
	int[int] lines = file.readText(filename)
		.split("\n")[1]								// just get frequencies
		.split(",")									// split by comma for individual bus lines
		.enumerate									// add index
		.filter!(v => v[1]!="x")					// skip ignored offsets
		.map!(v => tuple(v[0].to!int, v[1].to!int))	// parse to ints
		.assocArray;								// insert into associative array

	//Chinese remainder theorem
	long minValue = 0;
	long runningProduct = 1;
	foreach(offset, frequency; lines) {
		while ((minValue + offset) % frequency != 0) {
			minValue += runningProduct;
		}
		runningProduct *= frequency;
	}
	return minValue;
}

int main()
{
	writeln("Part 1: ", part1("input/day13.txt"));
	writeln("Part 2: ", part2("input/day13.txt"));
	return 0;
}

unittest
{
	assert(part1("input/day13-sample.txt") == 295);
	assert(part2("input/day13-sample.txt") == 1_068_781L);
}

unittest
{
	assert(part1("input/day13.txt") == 3789);
	assert(part2("input/day13.txt") == 667_437_230_788_118L);
}

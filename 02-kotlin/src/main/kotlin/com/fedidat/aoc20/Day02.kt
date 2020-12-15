package com.fedidat.aoc20

class Day02(filename: String) {

    private val lines: List<String> = Utils.getInput(filename).lines()

    fun part1() = policies()
        .filter { (low, hi, letter, w) -> w.count { c -> c == letter } in (low..hi) }
        .count()

    fun part2() = policies()
        .filter { (low, hi, letter, w) -> (w[low - 1] == letter).xor(w[hi - 1] == letter) }
        .count()

    fun policies() = lines.map {
        val matches = """(\d+)-(\d+) (\w): (\w+)""".toRegex().find(it)
        val (low, hi, c, w) = matches!!.destructured
        NTuple4(low.toInt(), hi.toInt(), c[0], w)
    }
}

data class NTuple4<T1, T2, T3, T4>(val t1: T1, val t2: T2, val t3: T3, val t4: T4)
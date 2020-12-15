import scala.collection.mutable.HashMap
import scala.collection.mutable.Map

class Day10Solution(var filename: String) {
  val input: Vector[Int] = Utils.getLines(filename).sorted
  val joltages = 0 +: input :+ (input.max + 3)
  
  val combinations = Map[Int, Long]()

  private def setCombinations(joltage: Int) = {
    combinations(joltage) = joltages
      .filter(v => v > joltage && v <= joltage + 3)
      .map(j => combinations(j))
      .sum
  }
  
  def part1(): Int = {
    val diffs = Map[Int, Int]().withDefaultValue(0)

    for ((joltage, following) <- joltages zip joltages.tail) {
      val diff = following - joltage
      diffs.update(diff, diffs(diff) + 1)
    }

    return diffs(1) * diffs(3)
  }

  def part2(): Long = {
    combinations(joltages.last) = 1

    joltages
      .dropRight(1)
      .reverse
      .foreach(j => setCombinations(j))

    return combinations(0)
  }
}

object Day10 {
  def main(args: Array[String]): Unit = {
    val solution = Day10Solution("Day10.txt")
    println(solution.part1())
    println(solution.part2())
  }
}

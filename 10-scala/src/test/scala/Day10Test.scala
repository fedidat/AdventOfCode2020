import org.junit.Test
import org.junit.Assert._

class Day10Test {
  @Test def part1Sample1(): Unit = {
    assertEquals(35, Day10Solution("Day10-sample1.txt").part1())
  }

  @Test def part1Sample2(): Unit = {
    assertEquals(220, Day10Solution("Day10-sample2.txt").part1())
  }

  @Test def part1Solution(): Unit = {
    assertEquals(2201, Day10Solution("Day10.txt").part1())
  }
  
  @Test def part2Sample1(): Unit = {
    assertEquals(8L, Day10Solution("Day10-sample1.txt").part2())
  }

  @Test def part2Sample2(): Unit = {
    assertEquals(19208L, Day10Solution("Day10-sample2.txt").part2())
  }

  @Test def part2Solution(): Unit = {
    assertEquals(169255295254528L, Day10Solution("Day10.txt").part2())
  }
}
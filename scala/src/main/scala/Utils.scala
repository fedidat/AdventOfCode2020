import scala.io.Source

object Utils {
  def getLines(filename: String): Vector[Int] = {
    return Source.fromResource(filename)
      .getLines
      .map(s => s.toInt)
      .toVector
  }
}

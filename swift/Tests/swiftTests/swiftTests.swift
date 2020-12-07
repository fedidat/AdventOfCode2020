import XCTest
import class Foundation.Bundle
@testable import swift

final class swiftTests: XCTestCase {
    func test_sample() throws {
      let input: [String] =
        try String(contentsOfFile: "Input/day7-sample.txt", encoding: .utf8)
              .trimmingCharacters(in: .whitespacesAndNewlines)
              .components(separatedBy: .newlines)

        XCTAssertEqual(part1(rules: input), 4)
        XCTAssertEqual(part2(rules: input), 32)
    }

    func test_solution() throws {
      let input: [String] =
        try String(contentsOfFile: "Input/day7.txt", encoding: .utf8)
              .trimmingCharacters(in: .whitespacesAndNewlines)
              .components(separatedBy: .newlines)

        XCTAssertEqual(part1(rules: input), 238)
        XCTAssertEqual(part2(rules: input), 82930)
    }

    static var allTests = [
        ("test_sample", test_sample),
        ("test_solution", test_solution),
    ]
}

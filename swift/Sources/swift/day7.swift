import Foundation

func getMatches(text: String, pattern: String) -> [[String]] {
    let regex = try! NSRegularExpression(pattern: pattern)
    let matches = regex.matches(in: text, range: NSRange(text.startIndex..., in: text))
    return matches.map { match in
      return (1..<match.numberOfRanges).map {
        let rangeBounds = match.range(at: $0)
        guard let range = Range(rangeBounds, in: text) else {
            return ""
        }
        return String(text[range])
      }
      .filter{$0 != ""}
    }
}

func stride_list(list: [String]) -> (String, [(Int, String)]) {
  return (list[0], stride(from: 1, to: list.count - 1, by: 2).map {
    (Int(list[$0])!, list[$0+1])
  })
}

func valueOf(containers: [String: [(Int, String)]], toVisit: String) -> Int {
  if containers[toVisit] == nil {
    return 1
  }
  return 1 + containers[toVisit]!
    .map { pair in
      pair.0 * valueOf(containers: containers, toVisit: pair.1)
    }
    .reduce(0, +)
}

func part1(rules: [String]) -> Int {
  let pattern: String = #"^([\w\s]+) bags contain \d+ ([\w\s]+) bags?(?:, \d+ ([\w\s]+) bags?(?:, \d+ ([\w\s]+) bags?(?:, \d+ ([\w\s]+) bags?)?)?)?\.$"#

  let containedBy: [String: [String]] = rules
    .map{getMatches(text: $0, pattern: pattern)}
    .filter{$0 != []}
    .map{$0[0]}
    .reduce(into: [:]) { result, element in
      element[1...].forEach {
          result[$0, default: []].append(element[0])
      }
    }

  var shinyGoldContainers: Set<String> = []
  var queue: [String] = containedBy["shiny gold"]!
  while queue.isEmpty == false {
    let nextBag = queue.removeFirst()
    shinyGoldContainers.insert(nextBag)
    if containedBy[nextBag] != nil {
      queue.append(contentsOf: containedBy[nextBag]!)
    }
  }
  return shinyGoldContainers.count
}

func part2(rules: [String]) -> Int {
  let pattern: String = #"^([\w\s]+) bags contain (\d+) ([\w\s]+) bags?(?:, (\d+) ([\w\s]+) bags?(?:, (\d+) ([\w\s]+) bags?(?:, (\d+) ([\w\s]+) bags?)?)?)?\.$"#

  let containers: [String: [(Int, String)]] = rules
    .map{getMatches(text: $0, pattern: pattern)}
    .filter{$0 != []}
    .map{$0[0]}
    .map { match in
      stride_list(list: match)
    }
    .reduce(into: [:]) { $0[$1.0] = $1.1 }
  
  return valueOf(containers: containers, toVisit: "shiny gold") - 1
}
import Algorithms

struct Day01: AdventDay {
  // Save your data in a corresponding text file in the `Data` directory.
  var data: String

  // Splits input data into its component parts and convert from string.
  var lines: [Substring] {
    data.split(separator: "\n")
  }

  // Replace this with your solution for the first part of the day's challenge.
  func part1() -> Any {
    lines.map { line in
      guard
        let firstIndex = line.firstIndex(where: \.isNumber),
          let lastIndex = line.lastIndex(where: \.isNumber)
      else {
        return 0
      }
      return Int(String(line[firstIndex]) + String(line[lastIndex]))!
    }.reduce(0, +)
  }

  // Replace this with your solution for the second part of the day's challenge.
  func part2() -> Any {
    // Sum the maximum entries in each set of data
    lines.map { $0.count }.reduce(0, +)
  }
}

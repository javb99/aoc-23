import Algorithms
import RegexBuilder

struct Day01: AdventDay {
  // Save your data in a corresponding text file in the `Data` directory.
  var data: String

  // Splits input data into its component parts and convert from string.
  var lines: SplitCollection<String.UTF8View> {
    data.utf8.lazy
      .split(separator: .ascii_newline)
  }

  // Replace this with your solution for the first part of the day's challenge.
  func part1() -> Any {
    lines.map { line -> Int in
      guard
        let first = line.lazy.compactMap(Int.init(nonZeroAsciiDigit:)).first,
        let last = line.lazy.compactMap(Int.init(nonZeroAsciiDigit:)).last
      else {
        return 0
      }
      return Int(
        tensDigit: first,
        onesDigit: last
      )
    }.reduce(0, +)
  }

  // Replace this with your solution for the second part of the day's challenge.
  func part2() -> Any {
    let calibrationValues = lines
      .map(part2CalibrationValue(for:))
    return calibrationValues.reduce(0, +)
  }
  
  private func part2CalibrationValue(for line: Substring.UTF8View) -> Int {
    var first: Int? = nil
    var last: Int? = nil
    func record(_ digit: Int) {
      if first == nil { first = digit }
      last = digit
    }
    var remaining = line
    while let next = remaining.first {
      defer { remaining.removeFirst() }
      
      if let digit = Int(nonZeroAsciiDigit: next) {
        record(digit)
      } else if let digit = SpelledDigit.parseValue(fromStartOf: remaining) {
        record(digit)
      }
    }
    guard
      let first,
      let last
    else {
      return 0
    }
    return Int(tensDigit: first, onesDigit: last)
  }
  
  enum SpelledDigit: String, CaseIterable {
    case one, two, three, four, five, six, seven, eight, nine
    
    static let utf8Table: [String.UTF8View] = SpelledDigit.allCases.map(\.rawValue.utf8)

    static func parseValue(fromStartOf remaining: some Collection<UInt8>) -> Int? {
      for (offset, name) in utf8Table.enumerated() {
        if remaining.starts(with: name) {
          return offset+1
        }
      }
      return nil
    }
  }
}

fileprivate extension Int {
  /// - Precondition: `tensDigit` is non-zero
  init(tensDigit: Int, onesDigit: Int) {
    self = tensDigit * 10 + onesDigit
  }
  init?(nonZeroAsciiDigit byte: UTF8.CodeUnit) {
    guard byte > .ascii_0 else {
      return nil
    }
    self = Int(byte - .ascii_0)
    if self > 9 {
      return nil
    }
  }
}

fileprivate extension UTF8.CodeUnit {
  static let ascii_newline = Character("\n").asciiValue!
  static let ascii_0 = Character("0").asciiValue!
  static let ascii_1 = Character("1").asciiValue!
  static let ascii_9 = Character("9").asciiValue!
}

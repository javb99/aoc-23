import Algorithms
import RegexBuilder

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
    let calibrationValues = lines.map { line in
      let digits = line.matches(of: r).map(\.output.1)
      guard
        let first = digits.first,
        let last = digits.last
      else {
        return 0
      }
      return Int(String(first) + String(last))!
    }
    return calibrationValues.reduce(0, +)
  }
  
  let r = Regex<(Substring, Int)> {
    Capture {
      ChoiceOf {
        Regex {
          "on"
          Lookahead {
            "e"
          }
        }
        Regex {
          "tw"
          Lookahead {
            "o"
          }
        }
        Regex {
          "thre"
          Lookahead {
            "e"
          }
        }
        "four"
        Regex {
          "fiv"
          Lookahead {
            "e"
          }
        }
        "six"
        "seven"
        Regex {
          "eigh"
          Lookahead {
            "t"
          }
        }
        Regex {
          "nin"
          Lookahead {
            "e"
          }
        }
        "1"
        "2"
        "3"
        "4"
        "5"
        "6"
        "7"
        "8"
        "9"
      }
    } transform: { word in
      SpelledDigit(rawValue: String(word))?.number ?? Int(String(word))!
    }
  }
  
  enum SpelledDigit: String, CaseIterable {
    case one = "on", two = "tw", three = "thre", four, five = "fiv", six, seven, eight = "eigh", nine = "nin"
    
    var number: Int {
      Self.allCases.firstIndex(of: self)! + 1
    }
  }
}

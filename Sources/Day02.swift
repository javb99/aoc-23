import Algorithms
import RegexBuilder

struct Day02: AdventDay {
  // Save your data in a corresponding text file in the `Data` directory.
  var data: String
  
  // Splits input data into its component parts and convert from string.
  var lines: SplitCollection<String> {
    data.lazy
      .split(separator: "\n")
  }

  // Replace this with your solution for the first part of the day's challenge.
  func part1() -> Any {
    lines.compactMap {
      Self.parseGame(from: $0)
    }.filter {
      $0.isPossibleGame(actualContents: .init("12 red, 13 green, 14 blue")!)
    }.map(\.id).reduce(0, +)
  }
  
  static func parseGame(from line: Substring) -> Game? {
    guard var (idPortion, rest) = line.tsplit(separator: ":") else {
      return nil
    }
    rest.removeFirst() // the space
    guard let (_, idString) = idPortion.tsplit(separator: " "), let id = Int(idString) else {
      return nil
    }
    let pulls = rest
      .split(separator: "; ")
      .compactMap { pullPortion in
        Game.Pull(pullPortion)
      }
    return Game(id: id, pulls: pulls)
  }
  
  struct Game: Equatable {
    var id: Int
    var pulls: [Pull]
    
    struct Pull: Equatable {
      var counts: [Color: Int]
      
      var power: Int {
        counts.values.reduce(1, *)
      }
      enum Color: String, Equatable {
        case green
        case red
        case blue
      }
    }
    
    func isPossibleGame(actualContents: Pull) -> Bool {
      pulls.allSatisfy { pull in
        pull.counts.allSatisfy { color, count in
          actualContents.counts[color, default: 0] >= count
        }
      }
    }
    
    var minimumActualContents: Pull {
      pulls.reduce(into: Pull(counts: [:]), { result, pull in
        result.counts.merge(pull.counts, uniquingKeysWith: max)
      })
    }
  }

  // Replace this with your solution for the second part of the day's challenge.
  func part2() -> Any {
    lines.compactMap {
      Self.parseGame(from: $0)?.minimumActualContents.power
    }.reduce(0, +)
  }
}

extension Day02.Game.Pull {
  init?(_ string: Substring) {
    let colorCounts = string
      .split(separator: ", ")
      .compactMap { countPortion -> (Day02.Game.Pull.Color, Int)? in
        guard let (count, color) = countPortion.tsplit(separator: " ") else {
          return nil
        }
        guard let color = Day02.Game.Pull.Color(rawValue: String(color)), let count = Int(count) else {
          return nil
        }
        return (color, count)
      }
    
    self.init(counts: Dictionary(uniqueKeysWithValues: colorCounts))
  }
}

extension Collection where Element: Equatable {
  func tsplit(separator: Element) -> (Self.SubSequence, Self.SubSequence)? {
    let parts = self.split(whereSeparator: { $0 == separator })
    guard parts.count == 2 else {
      return nil
    }
    return (parts[0], parts[1])
  }
}

//extension StringProtocol where Self.SubSequence == Substring {
//  @available(macOS 13.0, iOS 16.0, watchOS 9.0, tvOS 16.0, *)
//  public func vsplit<each S: StringProtocol>(
//    separator: Substring,
//    maxSplits: Int = .max,
//    omittingEmptySubsequences: Bool = true,
//    substrings: (repeat (each S).Type)
//  ) -> (repeat each S)? {
//    var portions: ArraySlice<Substring> = self.split(
//      separator: separator,
//      maxSplits: maxSplits,
//      omittingEmptySubsequences: omittingEmptySubsequences
//    )[...]
//    return (repeat replace((each S).self, with: portions.popFirst() as! each S))
//  }
  
//  @available(macOS 13.0, iOS 16.0, watchOS 9.0, tvOS 16.0, *)
//  public func split2(
//    separator: Substring,
//    omittingEmptySubsequences: Bool = true
//  ) -> (Substring, Substring)? {
//    return self.vsplit(
//      separator: separator,
//      maxSplits: 2,
//      omittingEmptySubsequences: omittingEmptySubsequences,
//      substrings: (Substring.self, Substring.self)
//    ) as (Substring, Substring)?
//    let match = self.firstMatch(of: separator)
//    guard let separatorRange = match?.range else {
//      return nil
//    }
//    return
//  }
//}

//private struct NilError: Error { }
//func orThrow<T>() throws -> T {
//  throw NilError()
//}

//func zip<each T>(_ optional: (repeat (each T)?)) -> (repeat each T)? {
//  do {
//    return try (repeat (each optional) ?? orThrow())
//  } catch {
//    return nil
//  }
//}

//func replace<T, V>(_ ignored: T, with value: V) -> V {
//  return value
//}

//func map<each T, each R>(_ optional: (repeat each T), transform: (T) throws -> R) rethrows -> (repeat each R) where (repeat each T) == (repeat each R) {
//  try (repeat (each optional) ?? orThrow())
//}

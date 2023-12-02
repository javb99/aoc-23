import XCTest

@testable import AdventOfCode

// Make a copy of this file for every day to ensure the provided smoke tests
// pass.

// regex       part 2 took 0.044638583 seconds.

// for then if part 2 took 0.955438333 seconds.
// if then for part 2 took 0.112071041 seconds.
// utf8        part 2 took 0.014128875 seconds.
// subsequence part 2 took 0.019910625 seconds.
// lazy split  part 2 took 0.0151975 seconds.
// cache table part 2 took 0.013623292 seconds.
// utf8 split  part 2 took 0.0098885 seconds.
// direct sum  part 2 took 0.010497 seconds.


final class Day01Tests: XCTestCase {

  func testPart1() throws {
    // Smoke test data provided in the challenge question
    let testData = """
    1abc2
    pqr3stu8vwx
    a1b2c3d4e5f
    treb7uchet
    """
    let challenge = Day01(data: testData)
    XCTAssertEqual(String(describing: challenge.part1()), "142")
  }

  func testPart2() throws {
    let testData = """
    two1nine
    eightwothree
    abcone2threexyz
    xtwone3four
    4nineeightseven2
    zoneight234
    7pqrstsixteen
    """
    let challenge = Day01(data: testData)
    XCTAssertEqual(String(describing: challenge.part2()), "281")
  }
  
  func testPart2_twone() throws {
    let testData = """
    bmcgjkkkhfive5twonekc
    """
    let challenge = Day01(data: testData)
    XCTAssertEqual(String(describing: challenge.part2()), "51")
  }
  
  func testPart2_OtherOverlapping() throws {
    let testData = """
    twone
    oneight
    threeight
    fiveight
    nineight
    eightwo
    eighthree
    """
    let challenge = Day01(data: testData)
    XCTAssertEqual(String(describing: challenge.part2()), "398")
  }
}

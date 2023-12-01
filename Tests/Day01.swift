import XCTest

@testable import AdventOfCode

// Make a copy of this file for every day to ensure the provided smoke tests
// pass.
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

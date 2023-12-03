import XCTest

@testable import AdventOfCode

// Make a copy of this file for every day to ensure the provided smoke tests
// pass.
final class Day02Tests: XCTestCase {

  func testPart1() throws {
    let testData = """
    Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
    Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
    Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
    Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
    Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green
    """
    let challenge = Day02(data: testData)
    XCTAssertEqual(String(describing: challenge.part1()), "8")
  }
  
  typealias Game = Day02.Game
  
  func testPart1Parsing() throws {
    XCTAssertEqual(
      Day02.parseGame(from: "Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green"),
      Game(id: 1, pulls: [
        .init(counts: [.blue: 3, .red: 4]),
        .init(counts: [.red: 1, .green: 2, .blue: 6]),
        .init(counts: [.green: 2]),
      ])
    )
  }
  
  func testPart1Logic() throws {
    let testPull = Game.Pull(counts: [.red: 12, .green: 13, .blue: 14])
    
    XCTAssertEqual(Game(id: 1, pulls: [
      .init(counts: [.blue: 3, .red: 4]),
      .init(counts: [.red: 1, .green: 2, .blue: 6]),
      .init(counts: [.green: 2]),
    ]).isPossibleGame(actualContents: testPull), true)
    
    XCTAssertEqual(Game(id: 2, pulls: [
      .init(counts: [.blue: 1, .green: 2]),
      .init(counts: [.green: 3, .blue: 4, .red: 1]),
      .init(counts: [.green: 1, .blue: 1]),
    ]).isPossibleGame(actualContents: testPull), true)
    
    XCTAssertEqual(Game(id: 3, pulls: [
      .init(counts: [.green: 8, .blue: 6, .red: 20]),
      .init(counts: [.blue: 5, .red: 4, .green: 13]),
      .init(counts: [.green: 5, .red: 1]),
    ]).isPossibleGame(actualContents: testPull), false)
    
    XCTAssertEqual(Game(id: 4, pulls: [
      .init(counts: [.green: 1, .red: 3, .blue: 6]),
      .init(counts: [.green: 3, .blue: 15, .red: 14]),
    ]).isPossibleGame(actualContents: testPull), false)
    
    XCTAssertEqual(Game(id: 5, pulls: [
      .init(counts: [.red: 6, .blue: 1, .green: 3]),
      .init(counts: [.blue: 2, .red: 1, .green: 2]),
    ]).isPossibleGame(actualContents: testPull), true)
  }

  func testPart2() throws {
    let testData = """
    Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
    Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
    Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
    Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
    Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green
    """
    let challenge = Day02(data: testData)
    XCTAssertEqual(String(describing: challenge.part2()), "2286")
  }
  
  func testPart2Logic() throws {    
    /*
     In game 1, the game could have been played with as few as 4 red, 2 green, and 6 blue cubes. If any color had even one fewer cube, the game would have been impossible.
     Game 2 could have been played with a minimum of 1 red, 3 green, and 4 blue cubes.
     Game 3 must have been played with at least 20 red, 13 green, and 6 blue cubes.
     Game 4 required at least 14 red, 3 green, and 15 blue cubes.
     Game 5 needed no fewer than 6 red, 3 green, and 2 blue cubes in the bag.
     */
    
    XCTAssertEqual(Game(id: 1, pulls: [
      .init(counts: [.blue: 3, .red: 4]),
      .init(counts: [.red: 1, .green: 2, .blue: 6]),
      .init(counts: [.green: 2]),
    ]).minimumActualContents, .init(counts: [.red: 4, .green: 2, .blue: 6]))
    
    XCTAssertEqual(Game(id: 2, pulls: [
      .init(counts: [.blue: 1, .green: 2]),
      .init(counts: [.green: 3, .blue: 4, .red: 1]),
      .init(counts: [.green: 1, .blue: 1]),
    ]).minimumActualContents, .init(counts: [.red: 1, .green: 3, .blue: 4]))
    
    XCTAssertEqual(Game(id: 3, pulls: [
      .init(counts: [.green: 8, .blue: 6, .red: 20]),
      .init(counts: [.blue: 5, .red: 4, .green: 13]),
      .init(counts: [.green: 5, .red: 1]),
    ]).minimumActualContents, .init(counts: [.red: 20, .green: 13, .blue: 6]))
    
    XCTAssertEqual(Game(id: 4, pulls: [
      .init(counts: [.green: 1, .red: 3, .blue: 6]),
      .init(counts: [.green: 3, .blue: 15, .red: 14]),
    ]).minimumActualContents, .init(counts: [.red: 14, .green: 3, .blue: 15]))
    
    XCTAssertEqual(Game(id: 5, pulls: [
      .init(counts: [.red: 6, .blue: 1, .green: 3]),
      .init(counts: [.blue: 2, .red: 1, .green: 2]),
    ]).minimumActualContents, .init(counts: [.red: 6, .green: 3, .blue: 2]))
  }
}

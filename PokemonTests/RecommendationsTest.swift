//
//  RecommendationsTest.swift
//  TeamBuilderTests
//
//  Created by Parker Coelho on 2/22/23.
//

import XCTest
@testable import TeamBuilder
import PokemonAPI

final class RecommendationsTest: XCTestCase {
    var recsVC: RecommendationsViewController!

    override func setUpWithError() throws {
        recsVC = RecommendationsViewController()
        recsVC.team = Team(team: [
            TeamPokemon(name: "Slowbro", hp: 95, attack: 75, defense: 110, specialAttack: 100, specialDefense: 80, speed: 30, types: [.water, .psychic], image: .strokedCheckmark),
            TeamPokemon(name: "Chansey", hp: 250, attack: 5, defense: 5, specialAttack: 35, specialDefense: 105, speed: 50, types: [.normal], image: .add)
        ], teamName: "Test Team")
        recsVC.viewDidLoad()
        recsVC.recommendationsTable.reloadData()
    }

    override func tearDownWithError() throws {
        recsVC = nil
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
        XCTAssertNotNil(recsVC)
        XCTAssertNotNil(recsVC.recommendationsTable)
    }
    
    func testCellConfiguredCorrectly() throws {
        XCTAssertNil(recsVC.recommendationsTable.cellForRow(at: IndexPath(row: 3, section: 0)))
        XCTAssertNotNil(recsVC.recommendationsTable.cellForRow(at: IndexPath(row: 2, section: 0)))
    }
    

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

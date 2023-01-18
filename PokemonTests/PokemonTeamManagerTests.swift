//
//  PokemonTeamManagerTests.swift
//  PokemonTests
//
//  Created by Parker Coelho on 12/28/22.
//

import XCTest

class PokemonTeamManagerTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

/*
 1. The team length should be the same as the number of cells updated, the number of pokemon images being displayed in both cases
 2. The order should match top and bottom
 3. If the team is not full, suggestions should appear
 4. When a pokemon is added, the image should update, and the stacks should update and the sum stacks should update
 */

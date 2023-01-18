//
//  PokemonTests.swift
//  PokemonTests
//
//  Created by Parker Coelho on 11/5/22.
//

import XCTest
@testable import Pokemon
import PokemonAPI

class PokemonTests: XCTestCase {
    
    override func setUpWithError() throws {
//        func getTeamPokemon() -> TeamPokemon {
//            PokemonAPI().pokemonService.fetchPokemon("bulbasaur") { result in
//                switch result {
//                case .success(let pokemon):
//                    let teamedPokemon = TeamPokemon(pokemon: pokemon)
//                    return teamedPokemon
//                case .failure(let error):
//                    print(error)
//                }
//            }
//        }
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
        
    }
    func test_Team_Pokemon() {
        let pokemon = TeamPokemon(name: "bulbasaur", hp: 1, attack: 1, defense: 1, specialAttack: 1, specialDefense: 1, speed: 1, types: [.grass,.poison], image: .checkmark)
        
        XCTAssertEqual(pokemon.name, "bulbasaur")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

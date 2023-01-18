//
//  PracticeViewController.swift
//  Pokemon
//
//  Created by Parker Coelho on 12/21/22.
//

import Foundation
import UIKit
import PokemonAPI

class PracticeViewController: UIViewController {
    var coordinator: MainCoordinator?
    
    override func viewDidLoad() {
//        fetchDex()
        fetchTypes()
        initializeTeamPokemonFromFetchedPokemon()
    }
    func fetchDex() {
        PokemonAPI().gameService.fetchPokedex(14) { result in
            switch result {
            case .success(let pokedex):
                print(pokedex.name!) // kalos-mountain
                
                PokemonAPI().resourceService.fetch(pokedex.region!) { result in
                    switch result {
                    case .success(let region):
                        print(region.name!) // kalos
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    func fetchTypes() {
        PokemonAPI().pokemonService.fetchPokemon(1) { result in
            switch result {
            case .success(let pokemon):
                print(pokemon.name!)
                pokemon.types?.forEach({ pokemonType in
                    PokemonAPI().resourceService.fetch(pokemonType.type!) { result in
                        switch result {
                        case .success(let type):
                            print(type.name)
                            if let name = type.name {
                                switch name {
                                case "grass":
                                    print("Grass type seen successfully")
                                case "poison":
                                    print("Poison type seen successfully")
                                default:
                                    print("no type detected")
                                }
                            }

                        case .failure(let error):
                            print(error)
                        }
                    }
                })
            case .failure(let error):
                print(error)
            }
        }
    }
    func initializeTeamPokemonFromFetchedPokemon() {
        PokemonAPI().pokemonService.fetchPokemon(1) { result in
            switch result {
            case .success(let teamedPokemon):
                let initedPokemon = TeamPokemon(pokemon: teamedPokemon)
                print(initedPokemon)
            case .failure(let error):
                print(error)
            }
            
        }
    }
}



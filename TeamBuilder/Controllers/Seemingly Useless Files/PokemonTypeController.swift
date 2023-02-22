//
//  PokemonTypeController.swift
//  Pokemon
//
//  Created by Parker Coelho on 12/21/22.
//

import Foundation
import PokemonAPI

class PokemonTypeController {
    func getTypes(pokemon: PKMPokemon) {
        PokemonAPI().pokemonService.fetchPokemon(pokemon.id!) { result in
            switch result {
            case .success(let pokemon):
                print(pokemon.name!)
                pokemon.types?.forEach({ pokemonType in
                    PokemonAPI().resourceService.fetch(pokemonType.type!) { result in
                        switch result {
                        case .success(let type):
                            print(type)
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
}


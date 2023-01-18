//
//  PokemonType.swift
//  Pokemon
//
//  Created by Parker Coelho on 12/21/22.
//

import Foundation

struct PokemonTypeTopObject: Codable {
    let slot: Int
    let type: PokemonLowerType
}

struct PokemonLowerType: Codable {
    let name: String
}

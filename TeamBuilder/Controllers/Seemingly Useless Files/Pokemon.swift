//
//  Pokemon.swift
//  Pokemon
//
//  Created by Parker Coelho on 11/5/22.
//

import Foundation

struct Pokemon: Decodable {
    let name: String
    let id: Int
    let sprites: Sprites
    
    enum TestEnum: Int, CaseIterable {
        case normal, fire, water, electric, grass, ice, fighting, poison, ground, flying, psychic, bug, rock,
        ghost, dragon, dark, steel, fairy
    }
}

struct Sprites: Decodable {
    let classicSprite: URL
    let shinySprite: URL
    
    enum CodingKeys: String, CodingKey {
        case classicSprite = "front_default"
        case shinySprite = "front_shiny"
    }
}

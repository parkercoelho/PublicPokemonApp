//
//  AlamoShowdown.swift
//  Pokemon
//
//  Created by Parker Coelho on 11/5/22.
//

import UIKit
import PokemonAPI

class TeamPokemon {
    var name: String
    var hp: Int
    var attack: Int
    var defense: Int
    var specialAttack: Int
    var specialDefense: Int
    var speed: Int
    var image: UIImage?
    var typeDamageMultiples: [Double] = []
    var types: [PokemonType]
    var abilities: [String] = []
    
    init(name: String, hp: Int, attack: Int, defense: Int,
         specialAttack: Int, specialDefense: Int, speed: Int, types: [PokemonType], image: UIImage?) {
        self.name = name
        self.hp = hp
        self.attack = attack
        self.defense = defense
        self.specialAttack = specialAttack
        self.specialDefense = specialDefense
        self.speed = speed
        
        
        self.types = types
        self.typeDamageMultiples = calcTypeAdvantages(for: types)
        self.image = image
    }
    init?(pokemon: PKMPokemon?) {
        self.name = pokemon!.name!
        self.hp = pokemon!.stats![0].baseStat!
        self.attack = pokemon!.stats![1].baseStat!
        self.defense = pokemon!.stats![2].baseStat!
        self.specialAttack = pokemon!.stats![3].baseStat!
        self.specialDefense = pokemon!.stats![4].baseStat!
        self.speed = pokemon!.stats![5].baseStat!
        
        self.types = []
        addTypesFromPKM(pokemon: pokemon)
        self.abilities = []
        addAbilitiesFromPKM(pokemon: pokemon)
        self.typeDamageMultiples = calcTypeAdvantages(for: types)
        
        
        guard let spriteUrl = URL(string: pokemon!.sprites?.frontDefault ?? "failure") else {return}
        if let data = try? Data(contentsOf: spriteUrl) {
            self.image = UIImage(data: data)
        } else {self.image = .checkmark}
    }
    
    func addAbilitiesFromPKM(pokemon: PKMPokemon?) {
        pokemon!.abilities!.forEach({ ability in
            self.abilities.append(ability.ability!.name!)
        })
    }
    
    func addTypesFromPKM(pokemon: PKMPokemon?) {
        pokemon!.types!.forEach { pkmType in
            if let name = pkmType.type?.name {
                switch name {
                case "normal":
                    self.types.append(.normal)
                case "fire":
                    self.types.append(.fire)
                case "water":
                    self.types.append(.water)
                case "electric":
                    self.types.append(.electric)
                case "grass":
                    self.types.append(.grass)
                case "ice":
                    self.types.append(.ice)
                case "fighting":
                    self.types.append(.fighting)
                case "poison":
                    self.types.append(.poison)
                case  "ground":
                    self.types.append(.ground)
                case "flying":
                    self.types.append(.flying)
                case "psychic":
                    self.types.append(.psychic)
                case "bug":
                    self.types.append(.bug)
                case "rock":
                    self.types.append(.rock)
                case "ghost":
                    self.types.append(.ghost)
                case "dragon":
                    self.types.append(.dragon)
                case "dark":
                    self.types.append(.dark)
                case "steel":
                    self.types.append(.steel)
                case "fairy":
                    self.types.append(.fairy)
                default:
                    print("no type detected")
                }
            }
        }
    }
    func calcTypeAdvantages(for types: [PokemonType]) -> [Double] {
        var multiples: [Double] = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]
        var weakTypes: [PokemonType] = []
        var resistsTypes: [PokemonType] = []
        var immunities: [PokemonType] = []
        
        types.forEach { type in
            switch type {
                
            case .normal:
                weakTypes.append(contentsOf: [.fighting])
                immunities.append(contentsOf: [.ghost])
            case .fire:
                weakTypes.append(contentsOf: [.water, .ground, .rock])
                resistsTypes.append(contentsOf: [.fire, .grass, .ice, .bug, .steel, .fairy])
            case .water:
                weakTypes.append(contentsOf: [.electric, .grass])
                resistsTypes.append(contentsOf: [.fire, .water, .ice, .steel])
            case .electric:
                weakTypes.append(contentsOf: [.ground])
                resistsTypes.append(contentsOf: [.electric, .flying, .steel])
            case .grass:
                weakTypes.append(contentsOf: [.fire, .ice, .poison, .flying, .bug])
                resistsTypes.append(contentsOf: [.water, .electric, .grass, .ground])
            case .ice:
                weakTypes.append(contentsOf: [.fire, .fighting, .rock, .steel])
                resistsTypes.append(contentsOf: [.ice])
            case .fighting:
                weakTypes.append(contentsOf: [.flying, .psychic, .fairy])
                resistsTypes.append(contentsOf: [.bug, .rock, .dark])
            case .poison:
                weakTypes.append(contentsOf: [.ground, .psychic])
                resistsTypes.append(contentsOf: [.grass, .fighting, .poison, .bug])
            case .ground:
                weakTypes.append(contentsOf: [.water, .grass, .ice])
                resistsTypes.append(contentsOf: [.poison, .rock])
                immunities.append(.electric)
            case .flying:
                weakTypes.append(contentsOf: [.electric, .ice, .rock])
                resistsTypes.append(contentsOf: [.grass, .fighting, .bug])
                immunities.append(.ground)
            case .psychic:
                weakTypes.append(contentsOf: [.bug, .ghost, .dark])
                resistsTypes.append(contentsOf: [.fighting, .psychic])
            case .bug:
                weakTypes.append(contentsOf: [.fire, .flying, .rock])
                resistsTypes.append(contentsOf: [.grass, .fighting, .ground])
            case .rock:
                weakTypes.append(contentsOf: [.water, .grass, .fighting, .ground, .steel])
                resistsTypes.append(contentsOf: [.normal, .fire, .poison, .flying])
            case .ghost:
                weakTypes.append(contentsOf: [.ghost, .dark])
                resistsTypes.append(contentsOf: [.poison, .bug])
                immunities.append(contentsOf: [.normal, .fighting])
            case .dragon:
                weakTypes.append(contentsOf: [.ice, .dragon, .fairy])
                resistsTypes.append(contentsOf: [.fire, .water, .electric, .grass])
            case .dark:
                weakTypes.append(contentsOf: [.fighting, .bug, .fairy])
                resistsTypes.append(contentsOf: [.ghost, .dark])
                immunities.append(.psychic)
            case .steel:
                weakTypes.append(contentsOf: [.fire, .fighting, .ground])
                resistsTypes.append(contentsOf: [.normal, .grass, .ice, .flying, .psychic, .bug, .rock, .dragon, .steel, .fairy])
            case .fairy:
                weakTypes.append(contentsOf: [.poison, .steel])
                resistsTypes.append(contentsOf: [.fighting, .bug, .dark])
                immunities.append(.dragon)
            }
        }
        weakTypes.forEach { type in
            multiples[type.rawValue] = multiples[type.rawValue] * 2
        }
        resistsTypes.forEach { type in
            multiples[type.rawValue] = multiples[type.rawValue] * 0.5
        }
        immunities.forEach { type in
            multiples[type.rawValue] = multiples[type.rawValue] * 0
        }
        
        return multiples
    }
    
    enum PokemonType: Int, CaseIterable {
        case normal, fire, water, electric, grass, ice, fighting, poison, ground, flying, psychic, bug, rock,
        ghost, dragon, dark, steel, fairy
    }
    enum PokemonTypeStrings: String, CaseIterable {
        case normal, fire, water, electric, grass, ice, fighting, poison, ground, flying, psychic, bug, rock,
        ghost, dragon, dark, steel, fairy
    }
}


// use https://www.smogon.com/forums/threads/usage-stats-api.3661849/ to research a usage database for recommending specific teams

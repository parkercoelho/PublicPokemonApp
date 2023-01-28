//
//  Team.swift
//  Pokemon
//
//  Created by Parker Coelho on 11/10/22.
//

import Foundation

class Team {
    var teamName: String
    var pokemonOnTeam: [TeamPokemon] = []
    
    var teamWeaknesses: [Double] = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
    var teamResistances: [Double] = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]

    func add(pokemon: TeamPokemon) {
        self.pokemonOnTeam.append(pokemon)
        updateTeamSums(for: pokemon)
    }
    
    func updateTeamSums(for pokemon: TeamPokemon) {
        pokemon.typeDamageMultiples.enumerated().forEach { (n, multiple) in
            if multiple < 1 {
                teamResistances[n] += 1
            }
            else if multiple > 1 {
                teamWeaknesses[n] += 1
            }
        }
    }
    
    func updateAllTeamSums() {
        teamWeaknesses = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
        teamResistances = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
        
        pokemonOnTeam.forEach { teamPokemon in
            updateTeamSums(for: teamPokemon)
        }
    }
    
    init(team: [TeamPokemon], teamName: String) {
        self.pokemonOnTeam = team
        self.teamName = teamName
    }
}

extension Team: Equatable {
    static func == (lhs: Team, rhs: Team) -> Bool {
        lhs.teamName == rhs.teamName
    }
    
    
}
